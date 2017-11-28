From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 17:05:17 +0100
Message-ID: <20171128160517.GA9691@lenoch>
References: <20171128073328.GF10757@kroah.com>
 <Pine.LNX.4.44L0.1711280956560.1467-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1711280956560.1467-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 10:00:32AM -0500, Alan Stern wrote:
> On Tue, 28 Nov 2017, Greg KH wrote:
> 
> > On Mon, Nov 27, 2017 at 11:08:33PM +0100, Ladislav Michl wrote:
> > > Hi there,
> > > 
> > > USB hosts do not discover any connected device on OMAP3 based board
> > > with CONFIG_PM=n. Just enabling this option is enough to restore working
> > > behaviour. Nothing unusual in log. Tested 4.14.2 and 4.15-rc1. I know
> > > a lot of stuff depends on CONFIG_PM, but is this expected behaviour?
> > > Neither EHCI nor MUSB is working without CONFIG_PM.
> > 
> > What bus type is your controllers on?  PCI?  platform?  Something else?
> > 
> > And yes, perhaps this is to be expected, why would you not want
> > CONFIG_PM to be enabled?  :)
> 
> Well, no, it's not expected.  Systems are supposed to work correctly 
> with CONFIG_PM=n -- just not at an optimum power level.

Here's relevant part of bootlog:
[    6.466369] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.710723] ehci-omap: OMAP-EHCI Host Controller driver
[    7.027862] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.336120] ohci-platform: OHCI generic platform driver
[    7.336791] ohci-platform 48064400.ohci: Generic Platform OHCI controller
[    7.336883] ohci-platform 48064400.ohci: new USB bus registered, assigned bus number 1
[    7.357177] ohci-platform 48064400.ohci: irq 92, io mem 0x48064400
[    7.402191] omap-mailbox 48094000.mailbox: omap mailbox rev 0x40
[    7.402343] omap-mailbox: probe of 48094000.mailbox failed with error -38
[    7.608337] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    7.608367] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.608367] usb usb1: Product: Generic Platform OHCI controller
[    7.608398] usb usb1: Manufacturer: Linux 4.15.0-rc1 ohci_hcd
[    7.608398] usb usb1: SerialNumber: 48064400.ohci
[    7.623779] hub 1-0:1.0: USB hub found
[    7.627380] hub 1-0:1.0: 3 ports detected
[    7.831878] omap-sham 480c3000.sham: hw accel on OMAP rev 0.9
[    8.218322] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized TWL4030 USB module
[    8.224212] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    8.224304] musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 2
[    8.242736] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    8.242767] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.242767] usb usb2: Product: MUSB HDRC host driver
[    8.242767] usb usb2: Manufacturer: Linux 4.15.0-rc1 musb-hcd
[    8.242797] usb usb2: SerialNumber: musb-hdrc.0.auto
[    8.246093] hub 2-0:1.0: USB hub found
[    8.246673] hub 2-0:1.0: 1 port detected
[    8.461669] omap-aes 480c5000.aes: OMAP AES hw accel rev: 2.6
[    8.463500] omap-aes 480c5000.aes: will run requests pump with realtime priority
[    8.937469] input: beeper as /devices/platform/beeper/input/input1
[    9.188262] ehci-omap 48064800.ehci: EHCI Host Controller
[    9.188323] ehci-omap 48064800.ehci: new USB bus registered, assigned bus number 3
[    9.188629] ehci-omap 48064800.ehci: irq 93, io mem 0x48064800
[    9.217407] ehci-omap 48064800.ehci: USB 2.0 started, EHCI 1.00
[    9.217803] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    9.217803] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.217834] usb usb3: Product: EHCI Host Controller
[    9.217834] usb usb3: Manufacturer: Linux 4.15.0-rc1 ehci_hcd
[    9.217834] usb usb3: SerialNumber: 48064800.ehci
[    9.218841] hub 3-0:1.0: USB hub found
[    9.218963] hub 3-0:1.0: 3 ports detected

> EHCI certainly should work without CONFIG_PM.  When a device is plugged 
> in to the EHCI controller, what shows up in 
> /sys/kernel/debug/usb/ehci/*/registers (fill in the '*' with the 
> correct bus ID)?

$ ls /sys/kernel/debug/usb
devices  ohci

So no ehci.

$ cat /sys/kernel/debug/usb/ohci/48064400.ohci/registers 
bus platform, device 48064400.ohci
Generic Platform OHCI controller
ohci_hcd
OHCI 1.0, NO legacy support registers, rh state running
control 0x083 HCFS=operational CBSR=3
cmdstatus 0x00000 SOC=0
intrstatus 0x00000024 FNO SF
intrenable 0x8000005a MIE RHSC UE RD WDH
hcca frame 0xb9ae
fmintvl 0xa7782edf FIT FSMPS=0xa778 FI=0x2edf
fmremaining 0x80000857 FRT FR=0x0857
periodicstart 0x2a2f
lsthresh 0x0628
hub poll timer off
roothub.a 0a000203 POTPGT=10 NPS NDP=3(3)
roothub.b 00000000 PPCM=0000 DR=0000
roothub.status 00008000 DRWE
roothub.portstatus [0] 0x00000100 PPS
roothub.portstatus [1] 0x00000100 PPS
roothub.portstatus [2] 0x00000100 PPS

> For that matter, what does that file contain before any devices are 
> plugged in?

For ohci it is the same. Any hint why there's no ehco file?

> Alan Stern

Thank you,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
