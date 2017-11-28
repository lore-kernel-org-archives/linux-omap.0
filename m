From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 14:59:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1711281452520.1467-100000@iolanthe.rowland.org>
References: <20171128192758.GA31498@lenoch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171128192758.GA31498@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Nov 2017, Ladislav Michl wrote:

> On Tue, Nov 28, 2017 at 01:09:45PM -0500, Alan Stern wrote:
> > The EHCI debugging files require CONFIG_DYNAMIC_DEBUG to be enabled.  
> > Oddly enough, the OHCI debugging files do not have the same 
> > requirement.  I don't know the reason for this difference.
> 
> I see, thanks for suggestion.
> 
> USB cable unplugged:
> $ cat /sys/kernel/debug/usb/ehci/48064800.ehci/registers 
> bus platform, device 48064800.ehci
> EHCI Host Controller
> EHCI 1.00, rh state running
> structural params 0x00001313
> capability params 0x00000016
> status 0000
> command 0010005 (park)=0 ithresh=1 period=512 RUN
> intrenable 37 IAA FATAL PCD ERR INT
> uframe 0000
> port:1 status 001000 0  ACK POWER sig=se0
> port:2 status 001000 0  ACK POWER sig=se0
> port:3 status 001000 0  ACK POWER sig=se0
> irq normal 0 err 0 iaa 0 (lost 0)
> complete 0 unlink 0
> 
> Plugged:
> $ cat /sys/kernel/debug/usb/ehci/48064800.ehci/registers 
> bus platform, device 48064800.ehci
> EHCI Host Controller
> EHCI 1.00, rh state running
> structural params 0x00001313
> capability params 0x00000016
> status 0000
> command 0010005 (park)=0 ithresh=1 period=512 RUN
> intrenable 37 IAA FATAL PCD ERR INT
> uframe 0000
> port:1 status 001000 0  ACK POWER sig=se0
> port:2 status 001000 0  ACK POWER sig=se0
> port:3 status 001000 0  ACK POWER sig=se0
> irq normal 0 err 0 iaa 0 (lost 0)
> complete 0 unlink 0

So no change at all.  In particular, no change to the port statuses.  
This suggests the hardware isn't configured properly; maybe a phy isn't
detecting the new connection.

I don't know anything about the phy drivers, however.  You should bring 
this to the attention of the maintainer for whichever phy is on your 
board.

By the way, the behavior when you plug in a device with CONFIG_PM=n
should be just about the same as the behavior with CONFIG_PM=y when you
plug in a _second_ device.  Have you tried doing that, say with two 
flash drives?  (I'm assuming your board has more than one EHCI port 
available.)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
