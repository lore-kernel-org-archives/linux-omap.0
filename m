From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Thu, 15 Nov 2012 19:39:47 -0600
Message-ID: <50A59963.3080603@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-4-git-send-email-ricardo.neri@ti.com> <20121114032712.GQ4415@opensource.wolfsonmicro.com> <50A3CFBD.5080903@ti.com> <20121114230848.GA4536@opensource.wolfsonmicro.com> <50A45467.6070404@ti.com> <50A4B9A6.5070806@ti.com> <50A4E1C1.7080609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52026 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab2KPBkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 20:40:47 -0500
In-Reply-To: <50A4E1C1.7080609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Tomi,

On 11/15/2012 06:36 AM, Tomi Valkeinen wrote:
> On 2012-11-15 11:45, Tomi Valkeinen wrote:
>> On 2012-11-15 04:33, Ricardo Neri wrote:
>>> Hi Mark,
>>>
>>> On 11/14/2012 05:08 PM, Mark Brown wrote:
>>>> On Wed, Nov 14, 2012 at 11:07:09AM -0600, Ricardo Neri wrote:
>>>>> On 11/13/2012 09:27 PM, Mark Brown wrote:
>>>>
>>>>>> Presumably this needs some other corresponding change in the resource
>>>>>> setup to go in simultaneously...
>>>>
>>>>> Yes, the change in the resources setup has been submitted to the
>>>>> OMAPDSS HDMI driver and accepted by Tomi [1].
>>>>
>>>> Don't do this.  With a change like this which must be made at the same
>>>> time over multiple subsystems it is very important that you send all the
>>>> parts of the changes together.  Otherwise there's a risk that one of
>>>> them won't get merged and even if they do both get merged you'll break
>>>> bisection - it's clear that nobody can be testing this on Tomi's branch.
>>>
>>> but the changes will hit linux-next at some point and they could be
>>> tested there, right?
>>>
>>> Sorry, as changes for the HDMI drivers go to several maintainers, I was
>>> trying to send the relevant patches to the respective maintainers and
>>> avoid potential merge/rebase issues.
>>>
>>> Tomi has already taken the DSS changes. Perhaps, if you and Tomi agree,
>>> Tomi could also take the ASoC and the arch/arm/mach-omap2 changes. This
>>> way all changes come from the same tree.
>>
>> Hmm, ok, I'm a bit confused here.
>>
>> I though the omap_hdmi_audio device was a new thing, and thus it was ok
>> to add to omapdss. But now I see omap_hdmi_audio is already registered
>> in arch/arm/mach-omap2/devices.c, meaning the same platform device is
>> registered twice now. Well, with the exception of the device id, which
>> is -1 for the one from devices.c, and 0 for the one in omapdss.
>>
>> Mark is right, this is not right. The kernel should work fine after each
>> patch, which means that sometimes a patch will touch multiple different
>> areas of kernel.
>>
>> omapdss master branch is a stable branch, so I don't want to rebase it.
>> But I guess I can "reset" it by merging a mainline using some merge
>> strategy. I haven't done that before, but I guess it'll work.
>>
>> Can you look at all the HDMI patches related to this hdmi-device change,
>> and rewrite them so that they'll keep the kernel working after each patch?
>
> After some testing I think resetting my master branch with merge is not
> a very good option.
>
> However, the HDMI audio platform device patch is almost on top of the
> branch, so reverting it would only create a few steps where the HDMI
> audio may be broken.
>
> So I can revert the patch and apply a new series with the patches
> organized so that things will work.

Thanks! I just resubmitted a new series to complement the creation of 
the audio device for HDMI with code to remove it from 
arch/arm/mach-omap2/devices.c. HDMI audio works correctly in every patch 
of that series.

Thanks Mark and Tomi for pointing out these issues and I apologize for 
the inconvenience.

BR,

Ricardo
>
>   Tomi
>
>
