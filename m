From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Mon, 6 Dec 2010 17:24:53 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE3A1B4@dbde02.ent.ti.com>
References: <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
 <20101130183010.GS17222@atomide.com>
 <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39717@dbde02.ent.ti.com>
 <1291231942.15533.32.camel@eowin>
 <19F8576C6E063C45BE387C64729E739404BCE398D7@dbde02.ent.ti.com>
 <20101202082904.GH5429@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39A7E@dbde02.ent.ti.com>
 <20101203124317.GB2633@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39E0D@dbde02.ent.ti.com>
 <20101206112003.GA17432@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37199 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433Ab0LFLzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 06:55:09 -0500
In-Reply-To: <20101206112003.GA17432@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> On Fri, Dec 03, 2010 at 07:08:53PM +0530, Gupta, Ajay Kumar wrote:
> >> >We already have generic APIs so I think we can pass function pointers
> to
> >> >musb driver via "struct omap_musb_board_data",
> >> >
> >> > struct omap_musb_board_data {
> >> >+	void	(*phy_on) (void)
> >> >+	void 	(*phy_off) (void)
> >> >+	void  (*intr_clr) (void)
> >> > }
> >> >
> >> >Reset part can be done in board file itself same as Ethernet driver is
> >> doing.
> >> >
> >> >Does this look fine?
> >>
> >> so those would be "turn phy on", "turn phy off" and "clear interrupt"
> >> apis ?
> >>
> >> How about:
> >> int (*set_phy_power)(unsigned on);
> >Looks good.
> >
> >> void (*clear_phy_irq)(void);
> >This is actually musb ip interrupt clear so I will make it like,
> >
> >void (*clear_irq) (void);
> 
> Is AM35x that different ? Can't you just write to MUSB_INTRRX
> MUSB_INTRTX and MUSB_INTRUSB ??
Writing to MUSB_INTRRX/TX/USB wouldn't help. We have to clear interrupt
Bit in control register INTR_LVL_CLR.

-Ajay
> 
> --
> balbi
