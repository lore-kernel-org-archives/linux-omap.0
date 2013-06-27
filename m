From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: omap4 ehci sporadic resume issue
Date: Thu, 27 Jun 2013 13:51:49 +0200
Message-ID: <51CC2755.2030505@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

I'm working on omap4460 with two ulpi connected to (SMSC3320 -> HUB SMSC2514) or (TUSB1210 -> HUB SMSC2514). 
The problem only happen when both port are used and after few suspend resume are triggered.
If I use just one port there is no issue on suspend resume. I already covered all TI
errata that I know and I'm working on TI kernel.

The problem is here

[   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD

Both ports change status from 001005 to 001009 (you have a log just after). 
So from host point of view both hub connected are not working in HS mode. 
After that the omap ehci has gone because the bus can not work in FS and LS and I can not recover from here.
Status of transceivers are dumped and they are ok after resume.

Do you have any suggestion?

Normal case

SUSPEND

DIR HIGH
CLOCK is OFF

AFTER RESUME

DIR has signal

CLOCK is 60 Mhz

Disconnect case

SUSPEND

DIR HIGH
CLOCK is OFF

AFTER RESUME
DIR is LOW
CLOCK is 60Mhz



[   77.593566] ehci-omap ehci-omap.0: ehci_omap_bus_resume
[   77.593658] ehci-omap ehci-omap.0: resume root hub
[   77.615814] hub 2-0:1.0: hub_resume
[   77.639251] hub 1-0:1.0: hub_resume
[   77.639282] ehci-omap ehci-omap.0: GetStatus port:1 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   77.639282] hub 1-0:1.0: port 1: status 0507 change 0000
[   77.639312] ehci-omap ehci-omap.0: GetStatus port:2 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   77.639312] hub 1-0:1.0: port 2: status 0507 change 0000
[   77.639312] ehci-omap ehci-omap.0: GetStatus port:3 status 001000 0  ACK POWER sig=se0
[   77.639373] ehci-omap ehci-omap.0: GetStatus port:1 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   77.639404] usb 1-1: usb resume
[   77.639434] ehci-omap ehci-omap.0: GetStatus port:2 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   77.639434] usb 1-2: usb resume
[   77.678314] dump_tranceiver -----------> on port 1
[   77.678314] ULPI_FUNC_CTRL 0x40
[   77.678344] ULPI_IFC_CTRL 0x00
[   77.678344] ULPI_OTG_CTRL 0x06
[   77.678344] ULPI_DEBUG 0x00
[   77.678344] ULPI_USB_INT_STS 0x14
[   77.678344] dump_tranceiver <---------- on port 1
[   77.678375] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   77.678405] dump_tranceiver -----------> on port 2
[   77.678405] ULPI_FUNC_CTRL 0x40
[   77.678405] ULPI_IFC_CTRL 0x00
[   77.678436] ULPI_OTG_CTRL 0x06
[   77.678436] ULPI_DEBUG 0x00
[   77.678436] ULPI_USB_INT_STS 0x14
[   77.678436] dump_tranceiver <---------- on port 2
[   77.678466] ehci-omap ehci-omap.0: GetStatus port:2 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   77.701782] usb 1-1: finish resume
[   77.701812] usb 1-2: finish resume
[   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
[   77.701934] Port 2 Status 0x1000
[   77.701934] Port 1 Status 0x1009
[   77.701965] Port 0 Status 0x1009
[   82.717529] ehci-omap ehci-omap.0: IAA watchdog: status a008 cmd 10065
[   82.717590] usb 1-2: kworker/u:12 timed out on ep0in len=0/2
[   82.717590] usb 1-2: gone after usb resume? status -110
[   82.717590] usb 1-2: can't resume, status -110
[   82.717620] hub 1-0:1.0: logical disconnect on port 2
[   82.717620] Disable PORT_PE
[   82.717651] pm_op(): usb_dev_resume+0x0/0x18 returns -110
[   82.717651] PM: Device 1-2 failed to resume async: error -110
[   82.733154] ehci-omap ehci-omap.0: IAA watchdog: status a008 cmd 10065
[   82.733184] usb 1-1: kworker/u:15 timed out on ep0in len=0/2
[   82.733215] usb 1-1: gone after usb resume? status -110
[   82.733215] usb 1-1: can't resume, status -110
[   82.733215] hub 1-0:1.0: logical disconnect on port 1
[   82.733215] Disable PORT_PE
[   82.733245] pm_op(): usb_dev_resume+0x0/0x18 returns -110
[   82.733245] PM: Device 1-1 failed to resume async: error -110
[   82.734741] PM: resume of devices complete after 5229.652 msecs
[   83.303863] PM: Finishing wakeup.
[   83.307525] Restarting tasks ... 
[   83.311157] hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   83.317504] hub 2-0:1.0: hub_resume
[   83.321716] done.
[   83.323974] suspend: exit suspend, ret = 0 (2000-01-02 21:07:12.171992466 UTC)
[   83.323974] hub 2-0:1.0: activate --> -22
[   83.324005] hub 1-0:1.0: state 7 ports 3 chg 0006 evt 0006
[   83.324035] ehci-omap ehci-omap.0: GetStatus port:1 status 001801 0  ACK POWER sig=j CONNECT
[   83.324035] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[   83.324035] usb 1-1: USB disconnect, device number 2
[   83.324066] usb 1-1.2: USB disconnect, device number 4
[   83.324066] usb 1-1.2: unregistering device
[   83.324066] usb 1-1.2: unregistering interface 1-1.2:1.0
[   83.530700] usb 1-1.2: usb_disable_device nuking all URBs
[   83.537200] usb 1-1.3: USB disconnect, device number 5
[   83.542907] usb 1-1.3: unregistering device
[   83.547546] usb 1-1.3: unregistering interface 1-1.3:1.0
[   83.554107] usb 1-1.3: usb_disable_device nuking all URBs
[   83.560577] usb 1-1: unregistering device
[   83.565063] usb 1-1: unregistering interface 1-1:1.0
[   83.570800] usb 1-1: usb_disable_device nuking all URBs


Michael
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
