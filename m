From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Tue, 23 Nov 2010 09:26:30 +0200
Message-ID: <20101123092630.7267a7ab.jhnikula@gmail.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
	<alpine.DEB.2.00.1011221745490.20215@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40514 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0KWH0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 02:26:22 -0500
Received: by eye27 with SMTP id 27so4483910eye.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 23:26:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011221745490.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, tony@atomide.com, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

On Mon, 22 Nov 2010 17:48:24 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> Thanks for fixing this.  What do you think about the following patch 
> instead?  It should avoid any compiler issues.
> 
Hmm.. looks like Janusz's patch is still in Liam's for-2.6.37
branch only.

> +/*
> + * The following functions are only required on an OMAP1-only build.
> + * mach-omap2/mcbsp.c contains the real functions
> + */
> +#ifndef CONFIG_ARCH_OMAP2PLUS
> +int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
> +{

Would that create a new problem if we are able to compile some day
omap1 and omap2 support into same kernel? I agree with you that passing
these via platform_data sounds the right solution.


-- 
Jarkko
