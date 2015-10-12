From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: musb: communication issue with more than 12 FTDI ports
Date: Mon, 12 Oct 2015 11:34:15 +0200
Message-ID: <CAGm1_ku3d4q3jQ6ZZYaLktd182O_WY5Hvu-Z877N31e5wN2_NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We have a problem, when using more than 12 FTDI ports. Kernels tried:
3.18.1, 4.2.3 and 4.3-rc5. SoC am335x 600MHz

Below the USB topology:

# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=, Driver=hub/4p, 480M
        |__ Port 1: Dev 9, If 0, Class=, Driver=hub/4p, 480M
            |__ Port 1: Dev 10, If 0, Class=, Driver=ftdi_sio, 12M
            |__ Port 2: Dev 11, If 0, Class=, Driver=ftdi_sio, 480M
            |__ Port 2: Dev 11, If 1, Class=, Driver=ftdi_sio, 480M
            |__ Port 2: Dev 11, If 2, Class=, Driver=ftdi_sio, 480M
            |__ Port 2: Dev 11, If 3, Class=, Driver=ftdi_sio, 480M
            |__ Port 3: Dev 12, If 0, Class=, Driver=ftdi_sio, 480M
            |__ Port 3: Dev 12, If 1, Class=, Driver=ftdi_sio, 480M
            |__ Port 3: Dev 12, If 2, Class=, Driver=ftdi_sio, 480M
            |__ Port 3: Dev 12, If 3, Class=, Driver=ftdi_sio, 480M
        |__ Port 2: Dev 4, If 0, Class=, Driver=ftdi_sio, 480M
        |__ Port 2: Dev 4, If 1, Class=, Driver=ftdi_sio, 480M
        |__ Port 2: Dev 4, If 2, Class=, Driver=ftdi_sio, 480M
        |__ Port 2: Dev 4, If 3, Class=, Driver=ftdi_sio, 480M
        |__ Port 3: Dev 7, If 0, Class=, Driver=ftdi_sio, 480M
        |__ Port 3: Dev 7, If 1, Class=, Driver=ftdi_sio, 480M
        |__ Port 3: Dev 7, If 2, Class=, Driver=ftdi_sio, 480M
        |__ Port 3: Dev 7, If 3, Class=, Driver=ftdi_sio, 480M

When using 12 ports and performing serial test (a pair of ports is
connected via null-modem cable and a rather short string ca. 90
characters will be sent alternating at 1200 and 115200b/s, testing
scripts are written in Python and running as own processes per a pair
of ports) there are no timeouts, i.e. all sent characters will be
received. As soon as I open ports 13 and 14 I start to get arbitrary
timeouts  (from test software point of view) on all ports.

In order to check, if ftdi_sio has primary to do with this issue, I've
performed the same test on a PC and PandaBoard Rev. A2 (EHCI port) and
there were no issues with 16 ports. So it seems to have something to
do with am335x + musb + number of end points.

Any idea? Let me know, if you need our test script.

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
