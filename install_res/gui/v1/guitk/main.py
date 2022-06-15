from tkinter import *

class mainpage(Tk):
    def __init__(self):
        super().__init__()
        self.geometry("700x500")
        self.resizable(False, False)
        self.title("EasyUtil")

    def Label(self):
        self.backGroundImage = PhotoImage(file="background_img.jfif")
        self.backGroundImageLabel = Label(self, image=self.backGroundImage)
        self.backGroundImageLabel.place(x=0, y=0)

Mainpage = mainpage()
Mainpage.Label()
Mainpage.mainloop()