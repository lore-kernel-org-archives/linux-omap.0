From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Fri, 5 Jun 2009 16:55:31 +0300
Message-ID: <20090605165531.7d0c4522.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<4A252A8E.9060602@tis.icnet.pl>
	<20090602203214.9edb786d.jhnikula@gmail.com>
	<200906030924.14230.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:14417 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbZFENzQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 09:55:16 -0400
In-Reply-To: <200906030924.14230.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Wed, 3 Jun 2009 09:24:12 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Thanks! The origial driver with commented out clk_enable(vc_clk) and 
> clk_disable(vc_clk) still works for me, so MCLK is not required! If I
> only knew what to do with this finding...
> 
Optimize out one needless clock :-)

> > Just hack the same "static struct omap_mcbsp_reg_cfg mcbsp_regs =
> > { ..." in omap-mcbsp.c and pass that structure instead of
> > &mcbsp_data->regs to omap_mcbsp_config in omap_mcbsp_dai_hw_params.
> 
> Done. Did not help. Again, I really don't know how to make use of
> this finding except for looking in a different place.
> 
Ok, so looks that McBSP settings have nothing to do.

I got one another idea, quite far also, but omap_set_dma_params helper
function calls omap_set_dma_xxx_params functions in different order
than older sound/arm/omap/omap-alsa-dma.c: audio_set_dma_params_play.

While I don't believe that call order has something to do on 1510
versus other omaps, it's easy to try by changing call order in
arch/arm/plat-omap/dma.c: omap_set_dma_params.

Of course you could try to also copy transfer setup from
audio_set_dma_params_play into omap_pcm_prepare. Use prtd->dma_ch as
channel, runtime->dma_addr as a dma_ptr and
snd_pcm_lib_period_bytes(substream) as a dma_size. That should make the
DMA setup same than older implementation.

Hopefully these speculations would help you to find out at least one DMA
interrupt.


-- 
Jarkko
