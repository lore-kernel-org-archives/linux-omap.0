From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: Re: HS USB support for 2.6.14 V4 kernel
Date: Thu, 20 Sep 2007 21:11:47 +0530
Message-ID: <c04186510709200841n1dd2d18ate1b49cca5e8c1a3d@mail.gmail.com>
References: <c04186510709190826x7d5d5c0fwf934f52b30c0136@mail.gmail.com>
	<6E3DC4E6E09EF440B55B7AD683608D6D01E342CE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <6E3DC4E6E09EF440B55B7AD683608D6D01E342CE@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I have tested the MUSB host as following:
1.  I have connected mouse to the ISP1504 OTG port of SDP, through a self
powered hub. and I booted 2.6.14 v4 kernel, I have  increased the verbosity
of output, and enabled enumeration:
                  echo D3 > /proc/driver/musb_hdrc
                  echo S > /proc/drivers/musb_hdrc

I could receive the musb_hdrc interrupts whenever I inserted the self
powered hub. But, inserting the device ( to the Hub) has not generated any
interrupt or event.

Captured log:
-------------------

#echo D3 > /proc/driver/musb_hdrc
#echo S > /proc/driver/musb_hdrc
musb_proc_write 827: debug level 3
musb_stage0_irq 305: <== Power=e0, DevCtl=80, bIntrUSB=0x40
musb_stage0_irq 410: SESSION_REQUEST (a_idle)
omap_set_vbus 118: VBUS a_wait_vrise, devctl 81
musb_stage0_irq 305: <== Power=e0, DevCtl=80, bIntrUSB=0x40
musb_stage0_irq 410: SESSION_REQUEST (a_wait_vrise)
omap_set_vbus 118: VBUS a_wait_vrise, devctl 81

#cat /proc/interrupts
           CPU0
 12:          0   OMAP24XX DMA IRQ demux
 25:          0   OMAP2 Display
 38:      18940   OMAP2 gptimer
 39:          0   OMAP2 gptimer
 56:          0   i2c-omap243x-1
 57:        130   i2c-omap243x-2
 58:          0   OMAP HDQ
 65:          0   mcspi_master_isr
 66:          0   mcspi_master_isr
 72:        245   serial
 83:          9   omap2430-mmc1
 86:          9   omap2430-mmc2
 91:          0   mcspi_master_isr
 92:          2   musb_hdrc.0
 93:          0   musb_hdrc.0
120:          0   omap_tsc2046_ts
245:       2155   eth0
258:          0   TWL4030 Keypad
262:          0   omap-twl4030rtc
265:          0   omap2430-mmc1
266:          0   omap2430-mmc2
Err:          0

#cat /proc/driver/musb_hdrc
Status: MHDRC, Mode=Host (Power=f0, DevCtl=81)
OTG state: a_wait_vrise; active
Options: musb-dma, host, debug=3 [eps=16]
Root port status: 00000100

#dmesg | grep usb
musb_hdrc: hw_ep 4tx, max 512
musb_hdrc: hw_ep 4rx, max 512
musb_hdrc: hw_ep 5tx, max 512
musb_hdrc: hw_ep 5rx, max 512
musb_hdrc: hw_ep 6tx, max 512
musb_hdrc: hw_ep 6rx, max 512
musb_hdrc: hw_ep 7tx, max 512
musb_hdrc: hw_ep 7rx, max 512
musb_hdrc: hw_ep 8tx, max 512
musb_hdrc: hw_ep 8rx, max 512
musb_hdrc: hw_ep 9tx, max 512
musb_hdrc: hw_ep 9rx, max 512
musb_hdrc: hw_ep 10tx, max 512
musb_hdrc: hw_ep 10rx, max 512
musb_hdrc: hw_ep 11tx, max 512
musb_hdrc: hw_ep 11rx, max 512
musb_hdrc: hw_ep 12tx, max 512
musb_hdrc: hw_ep 12rx, max 512
musb_hdrc: hw_ep 13tx, max 512
musb_hdrc: hw_ep 13rx, max 512
musb_hdrc: hw_ep 14shared, max 1024
musb_hdrc: hw_ep 15shared, max 1024
musb_hdrc: USB Host mode controller at c8800000 using DMA, IRQ 92
musb_hdrc musb_hdrc.0: MUSB HDRC host driver
musb_hdrc musb_hdrc.0: new USB bus registered, assigned bus number 1
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.14.7-arm1-omap2 musb-hcd
usb usb1: SerialNumber: musb_hdrc.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
musb_start 747: <== devctl 80
musb_init_controller 1924: HOST mode, status 0, devctl 88 B
Registered /proc/driver/musb_hdrc
Registered /proc/driver/musb_HSET
usbmon: debugfs is not available
usbcore: registered new driver usb-storage
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver hset
musb_proc_write 827: debug level 3
musb_stage0_irq 305: <== Power=e0, DevCtl=80, bIntrUSB=0x40
musb_stage0_irq 410: SESSION_REQUEST (a_idle)
musb_stage0_irq 305: <== Power=e0, DevCtl=80, bIntrUSB=0x40
musb_stage0_irq 410: SESSION_REQUEST (a_wait_vrise)

Am I missing out anything ? please suggest,

Warm Regards,
Sandeep

On 9/19/07, Kamat, Nishant <nskamat@ti.com> wrote:
>
> Sandeep,
>
> > -----Original Message-----
> > From: sandeep prabhu
> > Sent: Wednesday, September 19, 2007 10:27 AM
> >
> > Hello all,
> >
> > I am using 2.6.14 V4 kernel on 2430SDP board, trying to bring
> > up the High Speed USB (Inventra core) on ISP1504 OTG.
> > I could able to configure and detect the SDP board as
> > ethernet Gadget device, but I could not use ISP1504 as USB-Host.
> >
> > I am using the following DIP switch settings:
> >
> > S6 - 2 ------> ON
> > S6 - 6 ------> OFF
> > S6 - 7 ------> OFF
> >
> > I am getting "musb_hdrc.0" interrupts when I plug an USB Hub,
> > but  no interrupts are generated when I insert a device like
> > mouse or memory stick.
> >
>
> If you are using the 2.6.14 kernel from linux.omap.com, you will need to
> issue the following command on the prompt in order to enumerate the device:
>         echo S > /proc/drivers/musb_hdrc
>
> This will start the host session. Otherwise the session (and VBUS) is kept
> off.
>
> > Could anyone able to use ISP1504 as USB host ? is there any
> > other kernel version where the High Speed USB on ISP1504 OTG
> > is working ?
>
> Yes, I think the latest kernel from git works.
>
> Regards,
> Nishant
>
> >
> > --
> > Thanks in Advance,
> > Sandeep
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>



-- 
Warm Regards,
Sandeep
