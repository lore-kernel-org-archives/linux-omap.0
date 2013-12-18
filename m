From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Tue, 17 Dec 2013 16:30:56 -0800
Message-ID: <20131218003055.GC27438@atomide.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1703598.NbqXAMAFOI@avalon>
 <52AADBE0.3030203@ti.com>
 <3426377.keoaFgiZkl@avalon>
 <52AB2C25.6000507@ti.com>
 <20131213172234.GD28184@atomide.com>
 <52AC0A18.30405@ti.com>
 <20131214140913.GA12324@atomide.com>
 <52AEAAB7.7010308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42140 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752007Ab3LRAbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 19:31:07 -0500
Content-Disposition: inline
In-Reply-To: <52AEAAB7.7010308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131215 23:26]:
> On 2013-12-14 16:09, Tony Lindgren wrote:
> 
> >> Why was e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 merged into -rc2? It's
> >> not a fix, just a cleanup.
> > 
> > Hmm OK sorry looks like I removed some non-legacy mux framework code
> > by accident. The omap_mux_* parts clearly are dead code for omap4 as
> > it's been DT only since v3.10, but the omap4_dsi_mux_pads() is not
> > using omap_mux_* functions.
> > 
> > Yes, let's revert e30b06f4d5f0 except for the dead code parts, which
> > seems to be omap4_tpd12s015_mux_pads(), right?
> 
> Yes. I tested the below patch on 4430SDP, both DSI and HDMI works.

OK thanks applying for the -rc cycle.

Tony
