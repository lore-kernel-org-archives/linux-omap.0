From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Thu, 15 Nov 2012 10:22:05 -0600
Message-ID: <50A516AD.8000702@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-4-git-send-email-ricardo.neri@ti.com> <20121114032712.GQ4415@opensource.wolfsonmicro.com> <50A3CFBD.5080903@ti.com> <20121114230848.GA4536@opensource.wolfsonmicro.com> <50A45467.6070404@ti.com> <20121115040141.GC7599@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992633Ab2KOQXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 11:23:05 -0500
In-Reply-To: <20121115040141.GC7599@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Mark,

On 11/14/2012 10:10 PM, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 08:33:11PM -0600, Ricardo Neri wrote:
>> On 11/14/2012 05:08 PM, Mark Brown wrote:
>
>>> Don't do this.  With a change like this which must be made at the same
>>> time over multiple subsystems it is very important that you send all the
>
>> but the changes will hit linux-next at some point and they could be
>> tested there, right?
>
> This isn't much fun for anyone doing git bisect, it means the device
> will be unusuable for large periods of history.
>
>> Sorry, as changes for the HDMI drivers go to several maintainers, I
>> was trying to send the relevant patches to the respective
>> maintainers and avoid potential merge/rebase issues.
>
> You need to make sure everyone involved knows what's going on - review
> should really turn up the sort of issue I just highlighted.
>
>> Tomi has already taken the DSS changes. Perhaps, if you and Tomi
>> agree, Tomi could also take the ASoC and the arch/arm/mach-omap2
>> changes. This way all changes come from the same tree.
>
> Yes, we're going to need to do that.  Ideally all the changes would be
> squashed into a single commit.

OK. Tomi has offered to revert the patch that create the platform 
device. I will resubmit a new series with all the required changes 
squashing all the platform devices into a single one.

>
>>>> This change should be present in K3.8.
>
>>> What is "K3.8"?
>
>> I meant that Tomi took the DSS changes in [1] on his master branch
>> and he should push them upstream when the merge window for kernel
>> v3.8 opens.
>
> Do you mean that "K3.8" is "v3.8"?

Yes, that is what I mean.

BR,

Ricardo
>
