From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/10] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Tue, 20 Dec 2011 00:47:31 +0000
Message-ID: <20111220004730.GH2860@opensource.wolfsonmicro.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
 <20111214095745.GD3072@opensource.wolfsonmicro.com>
 <3652535.KtFJC1aH5Z@barack>
 <20111217093645.GH2833@opensource.wolfsonmicro.com>
 <4EEF4485.8050809@ti.com>
 <20111219192036.GN6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59363 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267Ab1LTArf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 19:47:35 -0500
Content-Disposition: inline
In-Reply-To: <20111219192036.GN6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Mon, Dec 19, 2011 at 11:20:37AM -0800, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [111219 05:33]:

> > struct omap-abe-twl6040-connection sdp4430_asoc_route[] = {
> > 	{"MAINMIC", "Main Mic Bias"},
> > 	{"SUBMIC", "Main Mic Bias"},
> > 	{"Main Mic Bias", "Ext Mic"},

> Hmm does it make sense to describe all those in DT? If you can
> group things in some sane way, then maybe the routings could be
> stored in the driver itself in the .data associated with the DT
> compatible flag? That is of course assuming there are some sane
> ways to group the routings..

No, and it's not completely trivial to do so until we have a sensible
binding for the objects you find on boards, especially jacks which don't
map in any sort of straightforward fashion onto the DAPM routes which we
need internally as they'll often group a bunch of different signals into
a single connector that don't have any direct relationship at the driver
level.

The old style MICBIAS widgets that the CODEC driver is using would also
be something I'd consider a blocker to direct use in device tree - the
way they're hooked up is really Linux specific and not terribly clear
either.
