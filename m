From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Wed, 24 Nov 2010 15:35:11 -0800
Message-ID: <20101124233511.GZ31536@atomide.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
 <alpine.DEB.2.00.1011221745490.20215@utopia.booyaka.com>
 <20101123092630.7267a7ab.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62990 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab0KXXf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 18:35:26 -0500
Content-Disposition: inline
In-Reply-To: <20101123092630.7267a7ab.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Jarkko Nikula <jhnikula@gmail.com> [101122 23:16]:
> On Mon, 22 Nov 2010 17:48:24 -0700 (MST)
> Paul Walmsley <paul@pwsan.com> wrote:
> 
> > > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > 
> > Thanks for fixing this.  What do you think about the following patch 
> > instead?  It should avoid any compiler issues.
> > 
> Hmm.. looks like Janusz's patch is still in Liam's for-2.6.37
> branch only.
> 
> > +/*
> > + * The following functions are only required on an OMAP1-only build.
> > + * mach-omap2/mcbsp.c contains the real functions
> > + */
> > +#ifndef CONFIG_ARCH_OMAP2PLUS
> > +int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
> > +{
> 
> Would that create a new problem if we are able to compile some day
> omap1 and omap2 support into same kernel? I agree with you that passing
> these via platform_data sounds the right solution.

This should not be a problem because there's no ifdef else and
in that case the functions would be there.

In general, the way to avoid problems like this is to make all
code under drivers arch independent and pass the platform data
from arch specific code.

In this case the ASoC platform data should be passed from
arch/arm/*omap*/ board-*.c files to make the drivers generic.

We are going to get rid of cpu_is_omapxxxx macros in the drivers,
so please consider this when patching the ASoC drivers.

Anyways, Paul's patch should be merged during the -rc cycle
because it is currently blocking Amstrad delta being built:

http://armlinux.simtec.co.uk/kautobuild/

Acked-by: Tony Lindgren <tony@atomide.com>
