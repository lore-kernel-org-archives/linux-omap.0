From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1
 compilation problem
Date: Wed, 03 Nov 2010 14:16:32 +0000
Message-ID: <1288793792.3277.51.camel@odin>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
	 <alpine.DEB.2.00.1011021058380.22589@utopia.booyaka.com>
	 <20101103102028.8ff19cac.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44466 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab0KCOQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 10:16:38 -0400
Received: by wyf28 with SMTP id 28so640519wyf.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 07:16:37 -0700 (PDT)
In-Reply-To: <20101103102028.8ff19cac.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-11-03 at 10:20 +0200, Jarkko Nikula wrote:
> On Tue, 2 Nov 2010 10:58:59 -0600 (MDT)
> Paul Walmsley <paul@pwsan.com> wrote:
> 
> > On Tue, 2 Nov 2010, Janusz Krzysztofik wrote:
> > 
> > > In the new code introduced with commit cf4c87abe238ec17cd0255b4e21abd949d7f811e,
> > > "OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c",
> > > the way omap1 build is supposed to bypass omap2 specific functionality doesn't 
> > > optimize out all omap2 specific stuff. This breaks linking phase for omap1 
> > > machines, giving "undefined reference to `omap2_mcbsp1_mux_clkr_src'" 
> > > and "undefined reference to `omap2_mcbsp1_mux_fsr_src'" errors. Fix it.
> > > 
> > > Created and tested against linux-2.6.37-rc1.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > Thanks Janusz.
> > 
> Yep, this must go to 2.6.37.
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>


Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

