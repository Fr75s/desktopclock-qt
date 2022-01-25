import sys

from PyQt5.QtGui import QGuiApplication, QIcon
from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QObject, QThread, QSettings, pyqtSignal
from PyQt5.QtWidgets import QApplication

from time import strftime, localtime

twentyFour = False

class Worker(QObject):
    finished = pyqtSignal()
    
    def run(self):
        # Setup Timer
        self.timer = QTimer()
        self.timer.setInterval(1000)
        # Connect to update_time and start
        self.timer.timeout.connect(lambda: self.finished.emit())
        self.timer.start()

    def stop(self):
        self.timer.stop()

class Backend(QObject):
    updatedClock = pyqtSignal(str, arguments=['time'])
    updatedDate = pyqtSignal(str, arguments=['date'])

    def __init__(self) :
        super().__init__()

        # Setup Thread and Worker
        self.thread = QThread()
        self.worker = Worker()

        # Move worker to thread
        self.worker.moveToThread(self.thread)
        # Define action on thread finished
        self.thread.started.connect(self.worker.run)
        self.worker.finished.connect(lambda: self.update_time())
        
        # Start the thread
        self.thread.start()

    def update_time(self):
        # Set Current time based on twentyFour
        currentTime = ''
        if twentyFour:
            currentTime = strftime('%H:%M', localtime())
        else:
            currentTime = strftime('%I:%M %p', localtime())
        currentDate = strftime('%A, %b %d, %Y', localtime())
        # Emit signal for updated time
        self.updatedClock.emit(currentTime)
        self.updatedDate.emit(currentDate)
    
    def modify_timeFormat(self):
        print('Setting Clock Format')
        global twentyFour
        twentyFour = not(twentyFour)
        self.update_time()

backend = Backend()

# Create Application Instance
app = QApplication(sys.argv)

# Create a QML Engine
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('home.qml')

root = engine.rootObjects()[0]

root.setIcon(QIcon('qClock.png'))
root.setProperty('backend', backend)
backend.update_time()

root.clickedClock.connect(backend.modify_timeFormat)

print('Starting Window...')
sys.exit(app.exec())
