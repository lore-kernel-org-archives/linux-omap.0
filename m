From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Wed, 14 Nov 2012 20:33:11 -0600
Message-ID: <50A45467.6070404@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-4-git-send-email-ricardo.neri@ti.com> <20121114032712.GQ4415@opensource.wolfsonmicro.com> <50A3CFBD.5080903@ti.com> <20121114230848.GA4536@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53526 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423500Ab2KOCeL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 21:34:11 -0500
In-Reply-To: <20121114230848.GA4536@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Mark,

On 11/14/2012 05:08 PM, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 11:07:09AM -0600, Ricardo Neri wrote:
>> On 11/13/2012 09:27 PM, Mark Brown wrote:
>
>>> Presumably this needs some other corresponding change in the resource
>>> setup to go in simultaneously...
>
>> Yes, the change in the resources setup has been submitted to the
>> OMAPDSS HDMI driver and accepted by Tomi [1].
>
> Don't do this.  With a change like this which must be made at the same
> time over multiple subsystems it is very important that you send all the
> parts of the changes together.  Otherwise there's a risk that one of
> them won't get merged and even if they do both get merged you'll break
> bisection - it's clear that nobody can be testing this on Tomi's branch.

but the changes will hit linux-next at some point and they could be 
tested there, right?

Sorry, as changes for the HDMI drivers go to several maintainers, I was 
trying to send the relevant patches to the respective maintainers and 
avoid potential merge/rebase issues.

Tomi has already taken the DSS changes. Perhaps, if you and Tomi agree, 
Tomi could also take the ASoC and the arch/arm/mach-omap2 changes. This 
way all changes come from the same tree.

>
>>>> -	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
>>>> -		+ OMAP_HDMI_AUDIO_DMA_PORT;
>>>> +	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start;
>
>>> ...both before and after versions use the resource.
>
>> This change should be present in K3.8.
>
> What is "K3.8"?

I meant that Tomi took the DSS changes in [1] on his master branch and 
he should push them upstream when the merge window for kernel v3.8 opens.

BR,

Ricardo

[1].http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79795.html
>
