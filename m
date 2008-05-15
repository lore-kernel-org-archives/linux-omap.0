From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: Query ISP1301 with OMAP
Date: Thu, 15 May 2008 15:57:42 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087012929E676@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


I am facing issues with configuring ISP1301 in 3-pin Host only mode.

I have a board with ISP1301 connected in 3-pin mode to OMAP3430-OHCI controller.
I am trying to reuse the file: drivers/i2c/chips/isp1301_omap.c to configure in HOST only mode.

I have setup the OHCI HCD successfully, but what I observe is that with or without the device,
OHCI is getting a "LOW SPEED" device attach interrupts.

I am suspecting something going wrong with ISP1301. Any clues from logs?

Logs:
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
usb usb1: Product: OMAP OHCI
usb usb1: Manufacturer: Linux 2.6.24.5-omap1-arm2 ohci_hcd
usb usb1: SerialNumber: ohci-omap.0

>
>usb 1-1: new low speed USB device using ohci-omap and address 2
>
 OHCI-IRQ 46

 OHCI-IRQ 44

 OHCI-IRQ 46

 OHCI-IRQ 44

 OHCI-IRQ 46

 OHCI-IRQ 44
usb 1-1: device descriptor read/64, error -62

 OHCI-IRQ 46

 OHCI-IRQ 44

 OHCI-IRQ 46

 OHCI-IRQ 44

 OHCI-IRQ 46

 OHCI-IRQ 44
usb 1-1: device descriptor read/64, error -62



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
