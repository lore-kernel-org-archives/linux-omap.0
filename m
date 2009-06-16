From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 16 Jun 2009 16:43:53 +0200
Message-ID: <4A37AFA9.4080403@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl>	<20090608094028.415e6ec3.jhnikula@gmail.com>	<4A2E7921.7090200@tis.icnet.pl>	<4A364B1A.5040905@tis.icnet.pl> <20090615181633.4570426f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40661 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbZFPOnz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2009 10:43:55 -0400
In-Reply-To: <20090615181633.4570426f.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Jarkko Nikula wrote:
> On Mon, 15 Jun 2009 15:22:34 +0200
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> 
>>> - original patch ported to the last l-o commit supporting omap-alsa:
>>>   - playback: works as before,
>>>   - capture: both </dev/dsp and arecord give null output,
>>>     but DMA interrupts still work.
>> Not that I would see it as a real progress, but to clarify things: I 
>> have managed to solve this particular problem with capture by
>> patching sound/arm/omap/omap-alsa.c (call omap_get_dma_dst_pos()
>> instead of omap_get_dma_src_pos() from audio_get_dma_pos() in case of
>> (stream_id == SNDRV_PCM_STREAM_CAPTURE)). The original code stopped
>> working after changes introduced to omap_get_dma_src_pos() with this
>> patch: http://marc.info/?l=linux-omap&m=121280267705523.
>>
> Nice step forward. From quick look of the patch I see that patch is
> changing how the source and destination positions are read for omap1.
> 
> While I don't have idea can this explain the ceased DMA in 1510 but
> will the playback in original code work again if you change line
> "offset = dma_read (CPC(lch));" to "offset = dma_read(CSSA_L(lch));" in
> omap_get_dma_src_pos? Or read both CSSA_L and CSSA_U at once like code
> before?

Yes, it will, and even better than before, without undesirable scraps 
repeated at the end. But that does not help in getting the new driver 
handle mcbsp/dma correctly :(.

I can confirm that the old driver can set up mcbsp in a way that keeps 
it shifting the contents of its input register, loaded with a pattern 
using omap_mcbsp_pollwrite() as Peter suggested, even if I break dma by 
commenting out all omap_start_dma() invocations. I have verified this by 
detecting averaged voltage level changes on the codec input pin with a 
simple multimeter (I still have not get access to a scope back).

Using the new driver, I am not able to detect similiar voltage changes, 
whatever I do to get the mcbsp sending data to the codec over its serial 
output. I have modified omap-mcbsp code with a hacked in probe hook that 
initializes mcbsp at boot time exactly as the old driver does it - no 
results.

After all, it is more and more likely that the problem is not dma, but 
mcbsp just not shifting any data for some mysterious reason.

Thanks,
Janusz
