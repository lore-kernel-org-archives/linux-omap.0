From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Mon, 9 Dec 2013 10:04:25 -0800
Message-ID: <20131209180424.GE12527@atomide.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1386160133-24026-14-git-send-email-tomi.valkeinen@ti.com>
 <20131205170514.GY26766@atomide.com>
 <52A5BB65.5050109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19786 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760412Ab3LISE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 13:04:27 -0500
Content-Disposition: inline
In-Reply-To: <52A5BB65.5050109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131209 04:46]:
> On 2013-12-05 19:05, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131204 04:31]:
> > 
> > Description missing.. But other than that can you please check that
> > the latest patch I posted in thread "[PATCH] ARM: OMAP2+: Fix populating
> > the hwmod data from device" works with this?
> >
> > The test to do is to remove the related reg, interrupt and dma entries
> > from omap_hwmod_*_data.c, and make sure the related hwmod data is initialized
> > from DT properly.
> 
> I made a quick test with panda, by applying your patch and reverting
> b38911f3472be89551bfca740adf0009562b9873. That only effectively tests
> the DISPC IRQ, but that worked fine.

OK I've finally pushed a real branch for the mach-omap2 board-*.c file
removal patches at omap-for-v3.14/omap3-board-removal so you can use
that as a base for testing. I did not apply the dpi panel pdata-quirks.c
patch as we discussed earlier.
 
> > I don't know if it makes sense to have them as children of dss_core, they
> > really all seem to be completely independent devices?
> 
> The DSS subdevices depend on the dss_core. dss_core has to be powered up
> for any of the subdevices to work. This is done automatically by the
> runtime PM when the subdevices are children of the dss_core.

OK thanks. Care to also check that it plays along nicely with the comments
starting at line 3222 in omap_hwmod_3xxx_data.c? We should set up things
so we can eventually remove those kind of hwmod workarounds.
 
> > BTW, for v3.15, I'm hoping to do patches where we deprecate ti,hwmods
> > property and do the lookup based on the compatible property instead ;)
> > So from that point of view we need to get the device mapping right in
> > the .dtsi files, and don't want to start mixing up separate devices into
> > single .dtsi entry.
> 
> Hmm, was that just a general comment, or something that affects the DSS
> DT data I have in my patch? As far as I understand, the DSS nodes
> reflect the current hwmods correctly.

Yes that's what we want if there is a dependency to the dss_core at the
hardware level and the children cannot be used independently. However,
if the children can be enabled and clocked independently, then they
should not be children of the dss_core.
 
> With the exception that DPI and SDI do not have a matching hwmod, as
> they are really part of dss_core/dispc. They are separate nodes as they
> are "video outputs" the same way as the other subnodes.
> 
> I could perhaps remove the DPI and SDI nodes, and have them as direct
> video ports from DISPC, but... That's easier said than done.

If you need a dev entry created for those where the phandle of that dev
is used to select the output for a board, then it makes sense to have
them. I guess you could also set them as a pinctrl mux controller and
then the board specific .dts file could request those outputs. But there
may be more than just mux involved like regulators.

Regards,

Tony
