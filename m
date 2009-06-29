From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] [RFC] ASoC: OMAP: fix OMAP1510 broken PCM pointer
 callback
Date: Mon, 29 Jun 2009 09:04:03 +0300
Message-ID: <20090629090403.5bfd35c8.jhnikula@gmail.com>
References: <200906280021.05931.jkrzyszt@tis.icnet.pl>
	<20090628223732.53954402.jhnikula@gmail.com>
	<200906290008.59640.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:38256 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbZF2GDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 02:03:21 -0400
In-Reply-To: <200906290008.59640.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com

On Mon, 29 Jun 2009 00:08:59 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> AFAIK, both CSSA_L and CDSA_L DMA registers are static. Loaded by CPU
> with 16 LSB of initial source and destination port addresses
> respectively, they are never updated by the DMA engine itself. That's
> why they can't be used for transfer progress indication unless
> updated by CPU.
> 
> The old omap-alsa driver was just updating them, intentionally or
> not, by reprogramming and restarting DMA every PCM period. That's why
> calculating PCM pointers from CSSA_L/CDSA_L worked.
> 
Thanks for finding out this. Good to know that OMAP low-level DMA code
now in this respect is as good as HW allows it.

> ASoC OMAP driver transfers whole PCM buffer with single DMA transfer,
> so it doesn't need to update DMA source/destination port address
> after initial playback/capture setup, even if restarting DMA, and
> actually never does this. Calculating PCM pointers from CSSA_L/CDSA_L
> registers without updating them every period would then be wrong.
> 
> For capture, reading CPC, that follows destination port address
> progress, just works fine (for both old and new driver). For
> playback, similar hardware functionality seems to be missing, so it
> has to be emulated in software if required.
> 
Kind an odd HW behaviour but that can happen. Probably it would be good
to explain this also in function omap_get_dma_src_pos.

Mark, I think this is fair to queue a fix for 2.6.31.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
