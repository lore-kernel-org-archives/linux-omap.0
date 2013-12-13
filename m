From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Fri, 13 Dec 2013 09:22:35 -0800
Message-ID: <20131213172234.GD28184@atomide.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1703598.NbqXAMAFOI@avalon>
 <52AADBE0.3030203@ti.com>
 <3426377.keoaFgiZkl@avalon>
 <52AB2C25.6000507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40847 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752746Ab3LMRWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 12:22:39 -0500
Content-Disposition: inline
In-Reply-To: <52AB2C25.6000507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131213 07:49]:
> Hi Laurent, Tony,
> 
> On 2013-12-13 16:37, Laurent Pinchart wrote:
> 
> >>> - dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in
> >>> mainline. What's their purpose, and how are they implemented on platforms
> >>> that make use of them ? Is the pinmux API an option ?
> >>
> >> They are used in mainline, grep again =).
> > 
> > The only implementations I can find in arch/arm/mach-omap2/display.c are
> > 
> > static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
> > {
> >         return 0;
> > }
> > 
> > static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
> > {
> > }
> 
> Yep. It seems Tony removed the muxing for -rc2 in
> e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 ARM: OMAP2+: Remove legacy mux
> code for display.c
> 
> Tony, that patch removes DSI muxing, which is not done via DT. I can't
> test right now, but I presume DSI displays don't work at all after -rc2.

Hmm I suggest you test against commit adfe9361b236 (ARM: dts: Add basic
devices on am3517-evm) as it does not yet remove the legacy data and
that's what's heading to linux next soonish.

With the DT configured displays that muxing needs to be done in the
DSS driver(s) using pinctrl-single.

BTW, I suspect quite a few of the DSI using boards have been broken a
while before 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl gpio
output) as at least the following have been using TWL GPIO to enable
the panel:

board-3430sdp.c
board-devkit8000.c
board-ldp.c
board-omap3stalker.c

This was the case at least for LDP.

Regards,

Tony
