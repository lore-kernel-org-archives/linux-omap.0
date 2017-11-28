From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 20:27:58 +0100
Message-ID: <20171128192758.GA31498@lenoch>
References: <20171128160517.GA9691@lenoch>
 <Pine.LNX.4.44L0.1711281307250.1467-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1711281307250.1467-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 01:09:45PM -0500, Alan Stern wrote:
> The EHCI debugging files require CONFIG_DYNAMIC_DEBUG to be enabled.  
> Oddly enough, the OHCI debugging files do not have the same 
> requirement.  I don't know the reason for this difference.

I see, thanks for suggestion.

USB cable unplugged:
$ cat /sys/kernel/debug/usb/ehci/48064800.ehci/registers 
bus platform, device 48064800.ehci
EHCI Host Controller
EHCI 1.00, rh state running
structural params 0x00001313
capability params 0x00000016
status 0000
command 0010005 (park)=0 ithresh=1 period=512 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 0000
port:1 status 001000 0  ACK POWER sig=se0
port:2 status 001000 0  ACK POWER sig=se0
port:3 status 001000 0  ACK POWER sig=se0
irq normal 0 err 0 iaa 0 (lost 0)
complete 0 unlink 0

Plugged:
$ cat /sys/kernel/debug/usb/ehci/48064800.ehci/registers 
bus platform, device 48064800.ehci
EHCI Host Controller
EHCI 1.00, rh state running
structural params 0x00001313
capability params 0x00000016
status 0000
command 0010005 (park)=0 ithresh=1 period=512 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 0000
port:1 status 001000 0  ACK POWER sig=se0
port:2 status 001000 0  ACK POWER sig=se0
port:3 status 001000 0  ACK POWER sig=se0
irq normal 0 err 0 iaa 0 (lost 0)
complete 0 unlink 0

$ lsusb -t
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ehci-omap/3p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ohci-platform/3p, 12M

	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
