From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Fri, 5 Jun 2009 23:45:34 +0100
Message-ID: <20090605224532.GA12995@sirena.org.uk>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906030924.14230.jkrzyszt@tis.icnet.pl> <20090605165531.7d0c4522.jhnikula@gmail.com> <200906060028.01600.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:58988 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZFEWpj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 18:45:39 -0400
Content-Disposition: inline
In-Reply-To: <200906060028.01600.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Sat, Jun 06, 2009 at 12:28:00AM +0200, Janusz Krzysztofik wrote:

> On the codec frame sync output, I can see ~10kHz symmetric square wave (filled 
> by 50%), the same on modem frame sync input, mcbsp1 status unknown. This 
> shape suggests I2S protocol, not DSP_B as we deduced from the original driver 
> code.

Not that this seems like an unreasonable conclusion but it's worth
pointing out that the DSP modes only require the leading edge of the
frame clock and that the falling edge can occur at any point before the
next rising edge is due.

> Anyway, we still have at least two potential reasons for my driver not 
> working: wrong mcbsp clocks setup or broken mcbsp dma handling. My last idea 
> was to create a generic test driver that would not use any external clocks, 
> ie configured with OMAP_MCBSP_SYSCLK_CLK and SND_SOC_DAIFMT_CBS_CFS, right? 
> That way, it should just work without any hardware support except for mcbsp 
> and maybe we could then definitelly verify if current mcbsp and dma code 
> works on omap1510 or not. Trying to select a template driver to base the test 
> driver on, I felt into these troubles with more and more questions coming on 
> mind. If you think my idea is worth of trying, could you please look at this 
> and give me some hints?

That approach is one I use all the time in driver development - isolate
the device as much as possible and confirm that it can at least
interoperate with itself.
