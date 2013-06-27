From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: omap4 ehci sporadic resume issue
Date: Thu, 27 Jun 2013 22:22:58 +0200
Message-ID: <20130627202257.GB14115@panicking>
References: <51CC2755.2030505@amarulasolutions.com>
 <51CC454A.1040104@ti.com>
 <20130627141704.GF12956@panicking>
 <51CC5105.4070301@ti.com>
 <20130627175623.GB21364@panicking>
 <CAB=otbQXVqFKOTtgvif=FZnWgDpbovAB6naPKTrsEHUJb21xTw@mail.gmail.com>
 <20130627192413.GA14115@panicking>
 <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:45642 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab3F0UXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 16:23:06 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so631605eaj.5
        for <linux-omap@vger.kernel.org>; Thu, 27 Jun 2013 13:23:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB=otbT-BcJg5tNZ=7jd1jvoK8N1Hd_skScuxczaeP=tagdcSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, USB list <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi

On Thu, Jun 27, 2013 at 11:07:11PM +0300, Ruslan Bilovol wrote:
> On Thu, Jun 27, 2013 at 10:24 PM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> > Hi
> >
> > On Thu, Jun 27, 2013 at 09:59:35PM +0300, Ruslan Bilovol wrote:
> >> Hello guys,
> >>
> >> On Thu, Jun 27, 2013 at 8:56 PM, Michael Trimarchi
> >> <michael@amarulasolutions.com> wrote:
> >> > Hi Roger
> >> >
> >> > On Thu, Jun 27, 2013 at 05:49:41PM +0300, Roger Quadros wrote:
> >> >> +Ruslan
> >> >>
> >> >> On 06/27/2013 05:17 PM, Michael Trimarchi wrote:
> >> >> > Hi Roger
> >> >> >
> >> >> > On Thu, Jun 27, 2013 at 04:59:38PM +0300, Roger Quadros wrote:
> >> >> >> Hi Michael,
> >> >> >>
> >> >> >> On 06/27/2013 02:51 PM, Michael Trimarchi wrote:
> >> >> >>> Hi
> >> >> >>>
> >> >> >>> I'm working on omap4460 with two ulpi connected to (SMSC3320 -> HUB SMSC2514) or (TUSB1210 -> HUB SMSC2514).
> >> >> >>> The problem only happen when both port are used and after few suspend resume are triggered.
> >> >> >>> If I use just one port there is no issue on suspend resume. I already covered all TI
> >> >> >>> errata that I know and I'm working on TI kernel.
> >> >> >>>
> >> >> >>> The problem is here
> >> >> >>>
> >> >> >>> [   77.701934] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
> >> >> >>>
> >> >> >>> Both ports change status from 001005 to 001009 (you have a log just after).
> >> >> >>> So from host point of view both hub connected are not working in HS mode.
> >> >> >>> After that the omap ehci has gone because the bus can not work in FS and LS and I can not recover from here.
> >> >> >>> Status of transceivers are dumped and they are ok after resume.
> >> >> >>>
> >> >> >>> Do you have any suggestion?
> >> >> >>
> >> >> >> I'm not very sure but both ports suddenly changing state like that look like
> >> >> >> a hardware issue. Also, it is strange that you can reproduce it only when two
> >> >> >> ports are simultaneously in use. Unfortunately, I can't match your setup with 2 ULPI
> >> >> >
> >> >> > Yes I know that TI doesn't have any setup like that.
> >> >> >
> >> >> >> ports.
> >> >> >>
> >> >> >> I have a OMAP5 uEVM that uses 2 ports but it won't be identical to your setup as
> >> >> >> they are on HSIC and not ULPI.
> >> >> >>
> >> >> >> Did you try errata i693?
> >> >> >
> >> >> > Yes I have it. It's not clear if I need to wait after
> >> >> > ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
> >> >> > polling the suspendM of the SMSC or the suspend status of the PORT or I can
> >> >> > switch just after this instruction. Because TI kernel use an msleep of 4 mseconds and then switch. It could be a timing issue on how errata is implemented when I have two ports? How this internal count works?
> >> >>
> >> >>
> >> >> The OMAP EHCI controller transparently sets the suspendM bit of the PHY when you
> >> >> set the PORT_SUSPEND feature on the EHCI port. So you don't need to poll for anything.
> >> >>
> >> >
> >> > A delay is necessary. If we apply the errata to the port before a delay the errata
> >> > doesn't work.
> >> >
> >> > /* Use internal 60Mhz clock ULPIBx */
> >> > temp_reg = omap_readl(L3INIT_HSUSBHOST_CLKCTRL);
> >> > temp_reg |= 1 << (8 + port);
> >> > temp_reg &= ~(1 << (24 + port));
> >> > omap_writel(temp_reg, L3INIT_HSUSBHOST_CLKCTRL);
> >> >
> >> > /* Wait 2ms to have transceiver transaction */
> >> > mdelay(2);
> >> >
> >> > /* Use external clock ULPIBx */
> >> > temp_reg &= ~(1 << (8 + port));
> >> > temp_reg |= 1 << (24 + port);
> >> > omap_writel(temp_reg, L3INIT_HSUSBHOST_CLKCTRL);
> >> >
> >> > Now it's not clear to me what happen if I apply this clock too early (transeceiver still
> >> > driver the clock) or too late. Any clue?
> >>
> >> We need to wait 3ms for entire USB bus to go into suspend after
> >> setting the PORT_SUSPEND bit. During this time, internal OMAP EHCI logic
> >> will communicate with PHY so it is not safe to switch the clocks to
> >> internal source.
> >> That's why with 2ms delay it fails. 4ms delay (3ms + 1ms for safety)
> >> is enough here
> >> and is successfully used last few years for production devices.
> >
> > Well this mdelay is the switch of the clock and not the delay after
> > PORT_SUSPEND. So after writing PORT_SUSPEND I need to wait
> > 4ms and then in 2ms you have a lot of clock to reach the 18 count. Correct?
> 
> Yes, sorry for confusing :)
> Moreover, 2ms is more than enough, errata document says about 1ms delay
> (and probably may be decreased up to few useconds)
> 
> >
> > Anyway I understand, but why both hub connected to the smsc3320 move from
> > HS to FS? So it's not important if there is a drift of delay but it must
> > be >= 4ms. Correct?
> >
> > The code works if I just use one port or remove one hub ;)
> >
> > Now the code is like this:
> >
> > temp &= ~(PORT_WKCONN_E | PORT_RWC_BITS);
> > temp |= PORT_WKDISC_E | PORT_WKOC_E;
> > ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
> >
> > mdelay(4);
> > omap_ehci_erratum_i693(ehci, ((wIndex & 0xff) - 1));
> >
> > The code of the function is up on this email.
> 
> Do you have locks around this software workaround?
> The patch I did against 3.4 linux kernel may be helpful for
> you in such case: http://review.omapzoom.org/28515
> Another patch extends this WA for all OMAP4 SoCs:
> http://review.omapzoom.org/31108

Yes, I'm using this code already applied to p-android-3.4 tree.
So the code is fine because it works when I use just one port
but for some reason I have problem when both ulpibx are active.

The scenario is this one:

GOOD ONE

[   23.389892] ehci-omap ehci-omap.0: GetStatus port:1 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   23.389923] usb 1-1: usb resume
[   23.390014] ehci-omap ehci-omap.0: GetStatus port:2 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   23.390045] usb 1-2: usb resume
[   23.428497] dump_tranceiver -----------> on port 1
[   23.428527] ULPI_FUNC_CTRL 0x40
[   23.428558] ULPI_IFC_CTRL 0x00
[   23.428558] ULPI_OTG_CTRL 0x06
[   23.428588] ULPI_DEBUG 0x00
[   23.428588] ULPI_USB_INT_STS 0x14
[   23.428619] dump_tranceiver <---------- on port 1
[   23.428649] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   23.428710] dump_tranceiver -----------> on port 2
[   23.428741] ULPI_FUNC_CTRL 0x40
[   23.428771] ULPI_IFC_CTRL 0x00
[   23.428771] ULPI_OTG_CTRL 0x06
[   23.428802] ULPI_DEBUG 0x00
[   23.428802] ULPI_USB_INT_STS 0x14
[   23.428802] dump_tranceiver <---------- on port 2
[   23.428863] ehci-omap ehci-omap.0: GetStatus port:2 status 001005 0  ACK POWER sig=se0 PE CONNECT

BAD ONE

[   32.741638] ehci-omap ehci-omap.0: GetStatus port:3 status 001000 0  ACK POWER sig=se0
[   32.741851] ehci-omap ehci-omap.0: GetStatus port:1 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   32.741912] usb 1-1: usb resume
[   32.741973] ehci-omap ehci-omap.0: GetStatus port:2 status 001885 0  ACK POWER sig=j SUSPEND PE CONNECT
[   32.742034] usb 1-2: usb resume
[   32.780395] dump_tranceiver -----------> on port 1
[   32.780426] ULPI_FUNC_CTRL 0x40
[   32.780456] ULPI_IFC_CTRL 0x00
[   32.780456] ULPI_OTG_CTRL 0x06
[   32.780487] ULPI_DEBUG 0x00
[   32.780487] ULPI_USB_INT_STS 0x14
[   32.780517] dump_tranceiver <---------- on port 1
[   32.780578] ehci-omap ehci-omap.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   32.780639] dump_tranceiver -----------> on port 2
[   32.780670] ULPI_FUNC_CTRL 0x40
[   32.780670] ULPI_IFC_CTRL 0x00
[   32.780700] ULPI_OTG_CTRL 0x06
[   32.780700] ULPI_DEBUG 0x00
[   32.780731] ULPI_USB_INT_STS 0x14
[   32.780731] dump_tranceiver <---------- on port 2
[   32.780792] ehci-omap ehci-omap.0: GetStatus port:2 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   32.803894] usb 1-2: finish resume
[   32.803985] usb 1-1: finish resume
[   32.804046] ehci-omap ehci-omap.0: irq status a004 Async Recl PCD
[   32.804046] Port 2 Status 0x1000
[   32.804077] Port 1 Status 0x1009
[   32.804077] Port 0 Status 0x1009

So status 1005 was good HS
1009 switch move to FS/LS device

[   37.819274] ehci-omap ehci-omap.0: IAA watchdog: status a008 cmd 10065
[   37.819427] usb 1-2: kworker/u:0 timed out on ep0in len=0/2
[   37.819458] usb 1-2: retry with reset-resume
[   37.819519] ehci-omap ehci-omap.0: port 2 reset
[   37.834899] ehci-omap ehci-omap.0: IAA watchdog: status a008 cmd 10065
[   37.835021] usb 1-1: kworker/u:3 timed out on ep0in len=0/2
[   37.835021] usb 1-1: retry with reset-resume
[   37.882049] ehci-omap ehci-omap.0: port 2 full speed --> companion
[   37.882110] ehci-omap ehci-omap.0: GetStatus port:2 status 003001 0  ACK POWER OWNER sig=se0 CONNECT
[   37.882141] ehci-omap ehci-omap.0: irq status 200c Recl FLR PCD
[   37.882171] Port 2 Status 0x1000
[   37.882202] Port 1 Status 0x300a
[   37.882202] Port 0 Status 0x1809
[   37.882263] hub 1-0:1.0: port 2 not reset yet, waiting 50ms
[   37.944396] ehci-omap ehci-omap.0: GetStatus port:2 status 00300a 0  ACK POWER OWNER sig=se0 PEC CSC
[   37.944488] hub 1-0:1.0: logical disconnect on port 2
[   37.944549] usb 1-2: gone after usb resume? status -19
[   37.944580] usb 1-2: can't resume, status -19
[   37.944580] hub 1-0:1.0: logical disconnect on port 2
[   37.944763] ehci-omap ehci-omap.0: port 1 reset
[   38.007171] ehci-omap ehci-omap.0: port 1 full speed --> companion
[   38.007232] ehci-omap ehci-omap.0: GetStatus port:1 status 003001 0  ACK POWER OWNER sig=se0 CONNECT
[   38.007263] ehci-omap ehci-omap.0: irq status 2004 Recl PCD


Michael

> 
> Regards
> Ruslan
> 
> >
> > Michael
> >
> >>
> >> --
> >> Best regards,
> >> Ruslan Bilvol
> >>
> >> >
> >> >
> >> >> What the errata says is that once software sets the PORT_SUSPEND feature, the PHY will
> >> >> got into suspend and cut the PHY clock sooner than required for the EHCI controller to
> >> >> complete its suspend operations. (NOTE: this is only applicable when the PHY is providing the
> >> >> ulpi_clk).
> >> >>
> >> >
> >> > Yes this is the case
> >> >
> >> >> What the workaround does is to just wait for a while (don't know why 4ms), and remux the
> >> >> ulpi_clock to an internal 60MHz clock for a while so that it can complete its suspend operations.
> >> >
> >> > What happen if I apply a big delay after PORT_SUSPEND. Will the internal state machine of the omap
> >> > continue to wait the clock?
> >> >
> >> > Michael
> >> >
> >> >>
> >> >> >
> >> >> > First time is 18, and then?
> >> >> >
> >> >> I think it is 18 for every port suspend.
> >> >>
> >> >> >>
> >> >> >> Also, are you suspending and resuming only the USB or the entire system?
> >> >> >>
> >> >> >
> >> >> > Whole system. Right the only susbsytem that doens't go to suspend is the FSUSB
> >> >> > but this depends on the bootloader.
> >> >>
> >> >> OK.
> >> >>
> >> >> cheers,
> >> >> -roger
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
