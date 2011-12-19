From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/10] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Mon, 19 Dec 2011 11:20:37 -0800
Message-ID: <20111219192036.GN6464@atomide.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
 <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
 <20111214095745.GD3072@opensource.wolfsonmicro.com>
 <3652535.KtFJC1aH5Z@barack>
 <20111217093645.GH2833@opensource.wolfsonmicro.com>
 <4EEF4485.8050809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51411 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab1LSTUn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 14:20:43 -0500
Content-Disposition: inline
In-Reply-To: <4EEF4485.8050809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111219 05:33]:
> Hi Mark, Tony,
> 
> On 12/17/2011 11:36 AM, Mark Brown wrote:
> >> Yes this is planed for the Dtree support, but the aim here is to get working 
> >> audio on PandaBoard as well with upstream kernel.
> > 
> > Just do it right to start off with, the device tree bindings should
> > normally map closely onto the platform data where platform data exists
> > already and you're going to have to have the code structured by feature
> > anyway.
> 
> I do not want to 'bloat' the board files under mach-omap2 for sdp4430,
> Panda with string arrays to pass the DAPM routing from there to the ASoC
> machine driver to construct the board specific routing.
> All of this sort of thing will go away with DT in the future (including
> the platform_data).
> 
> I planed to do this similar way as it is done for the tegra_wm8903.c
> machine driver:
> - without DT blob we support only sdp4430, Panda boards
> - with DT we will have similar mapping as tegra is planning to have.
> 
> If Tony is fine to add text array constructed under mach-omap2 which
> describes the ASoC DAPM mapping, I can do it, but AFAIK we should
> minimize the code size in that part of the kernel.
> 
> To pass the routing from the board files I need to modify the platform_data:
> 
> struct omap-abe-twl6040-connection {
> 	const char *sink;
> 	const char *source;
> };
> 
> struct omap_abe_twl6040_data {
> 	char *card_name;
> 	enum board_type board;
> 	struct omap-abe-twl6040-connection *route;
> 	int num_of_routes;
> };
> 
> In board files:
> struct omap-abe-twl6040-connection sdp4430_asoc_route[] = {
> 	{"MAINMIC", "Main Mic Bias"},
> 	{"SUBMIC", "Main Mic Bias"},
> 	{"Main Mic Bias", "Ext Mic"},
> 	...
> 	16 string pair.
> }
> 
> If this is acceptable by Tony, I can do this.

Hmm does it make sense to describe all those in DT? If you can
group things in some sane way, then maybe the routings could be
stored in the driver itself in the .data associated with the DT
compatible flag? That is of course assuming there are some sane
ways to group the routings..
 
> To describe the routing via feature flags is not really practical due to
> the possible variation I can think of.

..which may not be the case. And you need to be careful not to
misuse the compatible flag either.
 
> Tony: what do you think? Is this something that is allowed to do under
> plat-omap2?

Well if that's the way the ASoC people agree to do it, then
yes. But if it's a short term hack while waiting for the
device tree, then it might be best to keep carry it around
as an external patch until DT bindings work.

Regards,

Tony
