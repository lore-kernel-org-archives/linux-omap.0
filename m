From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 15 Jun 2009 18:16:33 +0300
Message-ID: <20090615181633.4570426f.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200906030924.14230.jkrzyszt@tis.icnet.pl>
	<20090605165531.7d0c4522.jhnikula@gmail.com>
	<200906060028.01600.jkrzyszt@tis.icnet.pl>
	<20090608094028.415e6ec3.jhnikula@gmail.com>
	<4A2E7921.7090200@tis.icnet.pl>
	<4A364B1A.5040905@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:57580 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761891AbZFOPQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 11:16:04 -0400
In-Reply-To: <4A364B1A.5040905@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Mon, 15 Jun 2009 15:22:34 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> > - original patch ported to the last l-o commit supporting omap-alsa:
> >   - playback: works as before,
> >   - capture: both </dev/dsp and arecord give null output,
> >     but DMA interrupts still work.
> 
> Not that I would see it as a real progress, but to clarify things: I 
> have managed to solve this particular problem with capture by
> patching sound/arm/omap/omap-alsa.c (call omap_get_dma_dst_pos()
> instead of omap_get_dma_src_pos() from audio_get_dma_pos() in case of
> (stream_id == SNDRV_PCM_STREAM_CAPTURE)). The original code stopped
> working after changes introduced to omap_get_dma_src_pos() with this
> patch: http://marc.info/?l=linux-omap&m=121280267705523.
> 
Nice step forward. From quick look of the patch I see that patch is
changing how the source and destination positions are read for omap1.

While I don't have idea can this explain the ceased DMA in 1510 but
will the playback in original code work again if you change line
"offset = dma_read (CPC(lch));" to "offset = dma_read(CSSA_L(lch));" in
omap_get_dma_src_pos? Or read both CSSA_L and CSSA_U at once like code
before?


-- 
Jarkko
