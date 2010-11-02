From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Tue, 2 Nov 2010 10:58:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1011021058380.22589@utopia.booyaka.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38296 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0KBQ7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 12:59:00 -0400
In-Reply-To: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

On Tue, 2 Nov 2010, Janusz Krzysztofik wrote:

> In the new code introduced with commit cf4c87abe238ec17cd0255b4e21abd949d7f811e,
> "OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c",
> the way omap1 build is supposed to bypass omap2 specific functionality doesn't 
> optimize out all omap2 specific stuff. This breaks linking phase for omap1 
> machines, giving "undefined reference to `omap2_mcbsp1_mux_clkr_src'" 
> and "undefined reference to `omap2_mcbsp1_mux_fsr_src'" errors. Fix it.
> 
> Created and tested against linux-2.6.37-rc1.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Acked-by: Paul Walmsley <paul@pwsan.com>

Thanks Janusz.


- Paul
