From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Thu, 27 Jun 2013 21:24:13 +0200
Message-ID: <20130627192413.GA14115@panicking>
References: <51CC2755.2030505@amarulasolutions.com>
 <51CC454A.1040104@ti.com>
 <20130627141704.GF12956@panicking>
 <51CC5105.4070301@ti.com>
 <20130627175623.GB21364@panicking>
 <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:57935 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab3F0TYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 15:24:20 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so598573eek.24
        for <linux-omap@vger.kernel.org>; Thu, 27 Jun 2013 12:24:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi

On Thu, Jun 27, 2013 at 09:59:35PM +0300, Ruslan Bilovol wrote:
> Hello guys,
> 
> On Thu, Jun 27, 2013 at 8:56 PM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> > Hi Roger
> >
> > On Thu, Jun 27, 2013 at 05:49:41PM +0300, Roger Quadros wrote:
> >> +Ruslan
> >>
> >> On 06/27/2013 05:17 PM, Michael Trimarchi wrote:
> >> > Hi Roger
> >> >
> >> > On Thu, Jun 27, 2013 at 04:59:38PM +0300, Roger Quadros wrote:
> >> >> Hi Michael,
> >> >>
> >> >> On 06/27/2013 02:51 PM, Michael Trimarchi wrote:
> >> >>> Hi
> >> >>>
> >> >>> I'm working on omap4460 with two ulpi connected to (SMSC3320 -> HUB SMSC2514) or (TUSB1210 -> HUB SMSC2514).
> >> >>> The problem only happen when both port are used and after few suspend resume are triggered.
> >> >>> If I use just one port there is no issue on suspend resume. I already covered all TI
> >> >>> errata that I know and I'm working on TI kernel.
> >> >>>
> >> >>> The problem is here
> >> >>>
> >> >>> [   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
> >> >>>
> >> >>> Both ports change status from 001005 to 001009 (you have a log just after).
> >> >>> So from host point of view both hub connected are not working in HS mode.
> >> >>> After that the omap ehci has gone because the bus can not work in FS and LS and I can not recover from here.
> >> >>> Status of transceivers are dumped and they are ok after resume.
> >> >>>
> >> >>> Do you have any suggestion?
> >> >>
> >> >> I'm not very sure but both ports suddenly changing state like that look like
> >> >> a hardware issue. Also, it is strange that you can reproduce it only when two
> >> >> ports are simultaneously in use. Unfortunately, I can't match your setup with 2 ULPI
> >> >
> >> > Yes I know that TI doesn't have any setup like that.
> >> >
> >> >> ports.
> >> >>
> >> >> I have a OMAP5 uEVM that uses 2 ports but it won't be identical to your setup as
> >> >> they are on HSIC and not ULPI.
> >> >>
> >> >> Did you try errata i693?
> >> >
> >> > Yes I have it. It's not clear if I need to wait after
> >> > ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
> >> > polling the suspendM of the SMSC or the suspend status of the PORT or I can
> >> > switch just after this instruction. Because TI kernel use an msleep of 4 mseconds and then switch. It could be a timing issue on how errata is implemented when I have two ports? How this internal count works?
> >>
> >>
> >> The OMAP EHCI controller transparently sets the suspendM bit of the PHY when you
> >> set the PORT_SUSPEND feature on the EHCI port. So you don't need to poll for anything.
> >>
> >
> > A delay is necessary. If we apply the errata to the port before a delay the errata
> > doesn't work.
> >
> > /* Use internal 60Mhz clock ULPIBx */
> > temp_reg = omap_readl(L3INIT_HSUSBHOST_CLKCTRL);
> > temp_reg |= 1 << (8 + port);
> > temp_reg &= ~(1 << (24 + port));
> > omap_writel(temp_reg, L3INIT_HSUSBHOST_CLKCTRL);
> >
> > /* Wait 2ms to have transceiver transaction */
> > mdelay(2);
> >
> > /* Use external clock ULPIBx */
> > temp_reg &= ~(1 << (8 + port));
> > temp_reg |= 1 << (24 + port);
> > omap_writel(temp_reg, L3INIT_HSUSBHOST_CLKCTRL);
> >
> > Now it's not clear to me what happen if I apply this clock too early (transeceiver still
> > driver the clock) or too late. Any clue?
> 
> We need to wait 3ms for entire USB bus to go into suspend after
> setting the PORT_SUSPEND bit. During this time, internal OMAP EHCI logic
> will communicate with PHY so it is not safe to switch the clocks to
> internal source.
> That's why with 2ms delay it fails. 4ms delay (3ms + 1ms for safety)
> is enough here
> and is successfully used last few years for production devices.

Well this mdelay is the switch of the clock and not the delay after
PORT_SUSPEND. So after writing PORT_SUSPEND I need to wait
4ms and then in 2ms you have a lot of clock to reach the 18 count. Correct?

Anyway I understand, but why both hub connected to the smsc3320 move from
HS to FS? So it's not important if there is a drift of delay but it must
be >= 4ms. Correct?

The code works if I just use one port or remove one hub ;)

Now the code is like this:

temp &= ~(PORT_WKCONN_E | PORT_RWC_BITS);
temp |= PORT_WKDISC_E | PORT_WKOC_E;
ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);

mdelay(4);
omap_ehci_erratum_i693(ehci, ((wIndex & 0xff) - 1));

The code of the function is up on this email.

Michael

> 
> -- 
> Best regards,
> Ruslan Bilvol
> 
> >
> >
> >> What the errata says is that once software sets the PORT_SUSPEND feature, the PHY will
> >> got into suspend and cut the PHY clock sooner than required for the EHCI controller to
> >> complete its suspend operations. (NOTE: this is only applicable when the PHY is providing the
> >> ulpi_clk).
> >>
> >
> > Yes this is the case
> >
> >> What the workaround does is to just wait for a while (don't know why 4ms), and remux the
> >> ulpi_clock to an internal 60MHz clock for a while so that it can complete its suspend operations.
> >
> > What happen if I apply a big delay after PORT_SUSPEND. Will the internal state machine of the omap
> > continue to wait the clock?
> >
> > Michael
> >
> >>
> >> >
> >> > First time is 18, and then?
> >> >
> >> I think it is 18 for every port suspend.
> >>
> >> >>
> >> >> Also, are you suspending and resuming only the USB or the entire system?
> >> >>
> >> >
> >> > Whole system. Right the only susbsytem that doens't go to suspend is the FSUSB
> >> > but this depends on the bootloader.
> >>
> >> OK.
> >>
> >> cheers,
> >> -roger
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
