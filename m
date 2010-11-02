From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Tue, 2 Nov 2010 10:56:18 -0400
Message-ID: <20101102145617.GK21476@opensource.wolfsonmicro.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49769 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752994Ab0KBO4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 10:56:12 -0400
Content-Disposition: inline
In-Reply-To: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Paul Walmsley <paul@pwsan.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

On Tue, Nov 02, 2010 at 03:50:32PM +0100, Janusz Krzysztofik wrote:
> In the new code introduced with commit cf4c87abe238ec17cd0255b4e21abd949d7f811e,
> "OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c",
> the way omap1 build is supposed to bypass omap2 specific functionality doesn't 
> optimize out all omap2 specific stuff. This breaks linking phase for omap1 
> machines, giving "undefined reference to `omap2_mcbsp1_mux_clkr_src'" 
> and "undefined reference to `omap2_mcbsp1_mux_fsr_src'" errors. Fix it.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

>  	case OMAP_MCBSP_CLKR_SRC_CLKR:
> +		if (cpu_class_is_omap1())
> +			break;
>  		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKR);

I guess this will still fail with optimisation diabled, but I'm not sure
anyone ever builds the kernel like that.
