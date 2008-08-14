From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [1/2]
Date: Thu, 14 Aug 2008 09:13:29 +0300
Message-ID: <20080814091329.bcb2755e.jarkko.nikula@nokia.com>
References: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
	<20080813135721.GC27446@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35800 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYHNGOQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 02:14:16 -0400
In-Reply-To: <20080813135721.GC27446@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 13 Aug 2008 16:57:25 +0300
"ext Tony Lindgren" <tony@atomide.com> wrote:

> * Hunter, Jon <jon-hunter@ti.com> [080813 06:08]:
> > Move OMAP_MCBSP_READ and OMAP_MCBSP_WRITE macro definitions from
> > arch/arm/plat-omap/mcbsp.c to include/asm-arm/arch-omap/mcbsp.h.
> 
> Let's rather get rid of the direct mcbsp register tinkering from
> drivers and use following instead:
> 
Workaround for omap_mcbsp3_aic23_clock_init not adding new McBSP API
would be to put those registers into "struct omap_mcbsp_reg_cfg" and
call omap_mcbsp_config.

> And, really the best solution would be to add support to
> sound/soc/omap/ for various codecs rather than try to keep
> the old drivers working.
> 
I propose this as well. Luckily it seems that someone is already
developing ASoC driver for TLV320AIC23B. Then native ALSA SoC support
for OSK require only to develope new machine driver in sound/soc/omap/.

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-August/009826.html

I'm also curious to know how well my OMAP ASoC drivers work on
OMAP1's :-)


Jarkko
