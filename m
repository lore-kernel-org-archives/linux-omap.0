From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Thu, 25 Oct 2012 09:31:27 -0500
Message-ID: <50894D3F.6000701@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com> <50866569.8010409@ti.com> <5086BB01.1080802@ti.com> <5086C333.9000801@ti.com> <5086D200.7000008@ti.com> <50876E9F.5010305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41210 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450Ab2JYOdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 10:33:42 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9PEXgDk010475
	for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:33:42 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9PEXfnP003221
	for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:33:42 -0500
In-Reply-To: <50876E9F.5010305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org



On 10/23/2012 11:29 PM, Tomi Valkeinen wrote:
> On 2012-10-23 20:21, Ricardo Neri wrote:
>
>>> If so, you could pass only that one address, instead of the whole HDMI
>>> register space?
>> Yes, that could work. I thought about that but the common HDMI driver
>> would have to know the the IP-specific register, which it should not.
>
> Argh, of course...
>
>> Perhaps the IP-specific register address can be passed by a IP-specific
>> function such as hdmi_get_audio_dma_port for the common HDMI driver to
>> populate the resource.
>>
>> Btw, could this be another reason to convert the IP-specific libraries
>> to drivers?
>
> Yes, I think it makes more and more sense to do that.
>
>> Even though this would allow our HDMI drivers to be more inline with
>> what other HDMI drivers do, things like power management and interrupts
>> are still handled by DSS, unlike x86, for instance [1][2]. So the audio
>> drivers will still depend on DSS. Also, the register layout is different
>> for OMAP5 and audio registers are even more scattered. Furthermore, the
>> common HDMI driver would have to know the IP-specific layout to know
>> what register spaces expose to the audio driver (another reason to have
>> IP-specific drivers?). So I would vote for continuing using the omapdss
>> audio interface.
>
> Okay.
>
> I think your approach is ok for the time being. I don't like passing the
> whole register space to the audio driver, but that's the best we can do
> with the current driver.

What about for now having a function in the IP library to be called from 
the common driver to determine the address of the port? Something like[1]:

	res = platform_get_resource_byname(hdmi.pdev,
					   IORESOURCE_MEM, "hdmi_wp");

	aud_offset = hdmi.ip_data.ops->audio_get_dma_port_off();
	aud_res[0].start = res->start + aud_offset;
	aud_res[0].end = res->start + aud_offset + 3;


>
> Have you looked at converting to IP specific drivers? Any idea of the
> effort? I'd like it to be done with the omap4 hdmi driver first, before
> merging omap5 hdmi into the mainline, if at all possible.
>
As a first step, I have started implementing a separate driver for the 
TPD12S015 as you suggested in the past. For converting the IP libraries 
into drivers, I still don't see how to keep them independent of omapdss 
to be reusable by DaVinci platforms (but afaik they are not using our 
libraries anyways). Maybe, a thin compatibility layer for omapdss (the 
hdmi_panel)? I still don't  have a clear idea. :/

BR,

Ricardo

[1]. 
http://gitorious.org/omap-audio/linux-audio/blobs/ricardon/topic/3.7-hdmi-clean/drivers/video/omap2/dss/hdmi.c#line1098

>   Tomi
>
>
