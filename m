From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Tue, 23 Oct 2012 12:21:04 -0500
Message-ID: <5086D200.7000008@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com> <5086BB01.1080802@ti.com> <5086C333.9000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34089 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304Ab2JWRXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 13:23:15 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NHNF9v026229
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 12:23:15 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NHNFnf000751
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 12:23:15 -0500
In-Reply-To: <5086C333.9000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org



On 10/23/2012 11:17 AM, Tomi Valkeinen wrote:
> On 2012-10-23 18:42, Ricardo Neri wrote:
>
>>> What registers does the audio side need to access?
>>
>> It only needs access to the DMA audio data port. All other operations
>> that the audio driver needs are done through the omapdss audio interface.
>
> Hmm, so the audio side only needs the address of one register, for the
> audio data, and this address is given to sDMA? You have
> OMAP_HDMI_AUDIO_DMA_PORT in the audio code, is it the HDMI_WP_AUDIO_DATA
> register?
Yes, that is the register it needs.
>
> If so, you could pass only that one address, instead of the whole HDMI
> register space?
Yes, that could work. I thought about that but the common HDMI driver 
would have to know the the IP-specific register, which it should not. 
Perhaps the IP-specific register address can be passed by a IP-specific 
function such as hdmi_get_audio_dma_port for the common HDMI driver to 
populate the resource.

Btw, could this be another reason to convert the IP-specific libraries 
to drivers?
>
> My point here is that we should make it very clear what the audio side
> can access. If we pass the whole HDMI register space, we should, in
> theory, be prepared to cope with the audio driver changing any register
> there. But if we pass only one register (or certain small ranges), we
> know the rest of the registers are safe.

True.
>
>>> Why are part of the
>>> registers accessed via the hdmi driver API, and some directly? I imagine
>>> it'd be better to do either one of those, but not both.
>>
>> This is because in the current omapdss audio interface we have no
>> functionality to handle the DMA transfers for audio. Do you think it
>> would be good to explore implementing support for that? At this point it
>> is not clear for me how to do it without duplicating the functionality
>> that ASoC provides for that.
>
> No, if the common ASoC code provides functionality for this, we should
> at least try to use it.
>
> I was looking at the ti_hdmi_4xxx_ip.h, searching for audio related
> registers by searching "AUD" string. I don't know if it makes any sense
> (you're better to have a say on that), but I think we could pass some of
> the audio registers ranges to the audio driver for use.
>
> For example, the HDMI_WP_AUDIO_* registers are together, we could give
> those to the audio driver if it makes sense. HDMI_CORE_AV_AUD* registers
> are a bit scattered, but... I guess it wouldn't be difficult to pass
> those also, there's still only a couple separate ranges.

Even though this would allow our HDMI drivers to be more inline with 
what other HDMI drivers do, things like power management and interrupts 
are still handled by DSS, unlike x86, for instance [1][2]. So the audio 
drivers will still depend on DSS. Also, the register layout is different 
for OMAP5 and audio registers are even more scattered. Furthermore, the 
common HDMI driver would have to know the IP-specific layout to know 
what register spaces expose to the audio driver (another reason to have 
IP-specific drivers?). So I would vote for continuing using the omapdss 
audio interface.

>
> But I also have no problem with having the hdmi audio API in the hdmi
> video driver, as we do now. And I think we in any case need a few
> functions, even if we would give the audio driver access to the AUD
> registers.
Yes, interrupt handling, for instance.

BR,

Ricardo


[1].http://www.spinics.net/lists/linux-omap/msg75969.html
[2]. http://www.spinics.net/lists/linux-omap/msg75968.html

>
>   Tomi
>
>
