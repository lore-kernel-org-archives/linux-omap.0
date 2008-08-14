From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [1/2]
Date: Thu, 14 Aug 2008 10:09:52 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D6651CF@dlee01.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
	<20080813135721.GC27446@atomide.com>
 <20080814091329.bcb2755e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:60356 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbYHNPKG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 11:10:06 -0400
In-Reply-To: <20080814091329.bcb2755e.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony, Jarkko,

> > Let's rather get rid of the direct mcbsp register tinkering from
> > drivers and use following instead:
> >
> Workaround for omap_mcbsp3_aic23_clock_init not adding new McBSP API
> would be to put those registers into "struct omap_mcbsp_reg_cfg" and
> call omap_mcbsp_config.


You know I am curious which omap board this function was added for? Going back and reviewing the OMAP5912 OSK schematics the 12MHz clock for the aic23 is provided from the OMAP5912 MCLK and not the McBSP3. So my feeling is that short term this should definitely be moved from the aic23 driver to a board specific file because I am not sure that this is even necessary for OMAP5912.


> > And, really the best solution would be to add support to
> > sound/soc/omap/ for various codecs rather than try to keep
> > the old drivers working.
> >
> I propose this as well. Luckily it seems that someone is already
> developing ASoC driver for TLV320AIC23B. Then native ALSA SoC support
> for OSK require only to develope new machine driver in sound/soc/omap/.


Sounds good. Forgive me here as I am not familiar with how the organisation is planned. So my original patches were to just resolve compiler issues...quick but dirty. However, this seems much nicer long-term.

Cheers
Jon
