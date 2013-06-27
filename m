From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: omap4 ehci sporadic resume issue
Date: Thu, 27 Jun 2013 16:17:04 +0200
Message-ID: <20130627141704.GF12956@panicking>
References: <51CC2755.2030505@amarulasolutions.com>
 <51CC454A.1040104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51CC454A.1040104-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger

On Thu, Jun 27, 2013 at 04:59:38PM +0300, Roger Quadros wrote:
> Hi Michael,
> 
> On 06/27/2013 02:51 PM, Michael Trimarchi wrote:
> > Hi
> > 
> > I'm working on omap4460 with two ulpi connected to (SMSC3320 -> HUB SMSC2514) or (TUSB1210 -> HUB SMSC2514). 
> > The problem only happen when both port are used and after few suspend resume are triggered.
> > If I use just one port there is no issue on suspend resume. I already covered all TI
> > errata that I know and I'm working on TI kernel.
> > 
> > The problem is here
> > 
> > [   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
> > 
> > Both ports change status from 001005 to 001009 (you have a log just after). 
> > So from host point of view both hub connected are not working in HS mode. 
> > After that the omap ehci has gone because the bus can not work in FS and LS and I can not recover from here.
> > Status of transceivers are dumped and they are ok after resume.
> > 
> > Do you have any suggestion?
> 
> I'm not very sure but both ports suddenly changing state like that look like
> a hardware issue. Also, it is strange that you can reproduce it only when two
> ports are simultaneously in use. Unfortunately, I can't match your setup with 2 ULPI

Yes I know that TI doesn't have any setup like that.

> ports.
> 
> I have a OMAP5 uEVM that uses 2 ports but it won't be identical to your setup as
> they are on HSIC and not ULPI.
> 
> Did you try errata i693?

Yes I have it. It's not clear if I need to wait after
ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
polling the suspendM of the SMSC or the suspend status of the PORT or I can
switch just after this instruction. Because TI kernel use an msleep of 4 mseconds and then switch. It could be a timing issue on how errata is implemented when I have two ports? How this internal count works?

First time is 18, and then?

> 
> Also, are you suspending and resuming only the USB or the entire system?
> 

Whole system. Right the only susbsytem that doens't go to suspend is the FSUSB
but this depends on the bootloader.

Michael


> cheers,
> -roger

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
