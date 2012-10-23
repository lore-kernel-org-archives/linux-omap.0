From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Tue, 23 Oct 2012 10:42:57 -0500
Message-ID: <5086BB01.1080802@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932938Ab2JWPpI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 11:45:08 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NFj8Za004504
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 10:45:08 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NFj7Rx009027
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 10:45:08 -0500
In-Reply-To: <50866569.8010409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org



On 10/23/2012 04:37 AM, Tomi Valkeinen wrote:
> On 2012-10-23 03:48, Ricardo Neri wrote:
>
>>>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>>>> +#define HDMI_AUDIO_MEM_RESOURCE 0
>>>> +#define HDMI_AUDIO_DMA_RESOURCE 1
>>>
>>> I don't see much point with these definitions. They are hdmi.c internal,
>>> so the audio driver can't use them, and so they aren't really fixed.
>>
>> I just thought it could make the code more readable; but if the
>> resources array is going to be local, then they are not helpful.
>
> My point was that if the defines as hdmi.c internal, you need to add the
> same defines into the audio code also in order to use them. And then
> we'd have the same defines in two places.
>
> Or, if audio code doesn't need them to parse the resources, then they
> aren't really relevant here either, as you are just adding two resources
> to the array, and their order is not important.

Oh OK. So they are not needed at all.
>
>>> So, how will this work? All the audio related functions will be removed
>>> from the (video) hdmi driver, and the audio driver will access the
>>> registers independently? The audio driver will still need to access the
>>> video parts, right?
>> That could be a new approach, but the idea here is to continue having an
>> omapdss audio interface for audio drivers to use.
>
> Ok. Do you have a git tree with the audio code working with this
> approach? Or can you just copy paste a few lines showing how the audio
> driver uses this. It'd be easier to understand by seeing that side of
> the code also.

Here is the code:

static __devinit int omap_hdmi_probe(struct platform_device *pdev)
{
	...

	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!hdmi_rsrc) {
		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM");
		return -ENODEV;
	}

	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
		+ OMAP_HDMI_AUDIO_DMA_PORT;

	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
	if (!hdmi_rsrc) {
		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_DMA");
		return -ENODEV;
	}

	hdmi_data->dma_params.dma_req =  hdmi_rsrc->start;
	hdmi_data->dma_params.name = "HDMI playback";

	...
}

You can also take a look here:
git://gitorious.org/omap-audio/linux-audio.git 
ricardon/topic/for-3.8-hdmi_rename_devs

at sound/soc/omap/omap-hdmi.c

or directly here:

http://gitorious.org/omap-audio/linux-audio/blobs/ricardon/topic/for-3.8-hdmi_rename_devs/sound/soc/omap/omap-hdmi.c
>
> The audio uses sDMA for the transfer?

Yes, it does.
>
>> The root problem that I am trying to address is that the omapdss audio
>> interface does not have functionality for DMA transfer of audio samples
>> to the HDMI IP. Also, I am not sure how that could be done without
>> duplicating the functionality that ASoC already provides.
>
> Ok. But the audio driver still needs access to the HDMI registers? I'm
> not worried about passing the DMA resource. Video side doesn't use that.

Audio driver does not access the HDMI registers nor ioremaps them. The 
audio driver relies solely on the OMAPDSS audio interface for audio 
configuration, start and stop.

> But video side uses the registers, and both having the same ioremapped
> area could possibly lead both writing to the same register. Or perhaps
> not the same register, but still doing conflicting things at the hw
> level at the same time.
Also, for things like display enable/disable, the audio driver relies 
the the display driver. If the display is disable or the current timing 
does not support audio, audio will just not play.
>
>>> I feel a bit uneasy about giving the same ioremapped register space to
>>> two independent drivers... If we could split the registers to video and
>>> audio parts, each driver only ioremapping their respective registers,
>>> it'd be much better.
>>
>> Fwiw, the audio drivers (at least my audio drivers) will not ioremap.
>> They will just take the DMA request number and port. Maybe spliting the
>> register space into audio and video is not practical as we would endup
>> having many tiny address spaces.
>
> Yes, if there's no clear HDMI block division for video and audio, then
> it doesn't sound good to split them up if we'd have lots of small
> address spaces.
>
> What registers does the audio side need to access?

It only needs access to the DMA audio data port. All other operations 
that the audio driver needs are done through the omapdss audio interface.

> Why are part of the
> registers accessed via the hdmi driver API, and some directly? I imagine
> it'd be better to do either one of those, but not both.

This is because in the current omapdss audio interface we have no 
functionality to handle the DMA transfers for audio. Do you think it 
would be good to explore implementing support for that? At this point it 
is not clear for me how to do it without duplicating the functionality 
that ASoC provides for that.

BR,

Ricardo
>
>   Tomi
>
>
