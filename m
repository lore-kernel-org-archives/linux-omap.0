From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [RFC] ARM: OMAP4: hwmod data: add HWMOD_SWSUP_SIDLE to dss_hdmi
 to data
Date: Tue, 19 Jun 2012 10:08:56 -0500
Message-ID: <4FE09608.3090104@ti.com>
References: <1339890877-20129-1-git-send-email-ricardo.neri@ti.com> <alpine.DEB.2.00.1206181518430.11642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38315 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902Ab2FSPJg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 11:09:36 -0400
In-Reply-To: <alpine.DEB.2.00.1206181518430.11642@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, tony@atomide.com, tomi.valkeinen@ti.com, s-guiriec@ti.com, mythripk@ti.com, linux-omap@vger.kernel.org

On 06/18/2012 04:22 PM, Paul Walmsley wrote:
> Hi
>
> On Sat, 16 Jun 2012, Ricardo Neri wrote:
>
>> I would like to revive an old discussion regarding how to use a particular
>> idle mode for a specific use-case[1].
>>
>> As per the OMAP4 documentation, audio over HDMI should be transmitted in
>> no-idle mode. This patch adds the HWMOD_SWSUP_SIDLE so that omap_hwmode uses
>> no-idle/force-idle settings instead of smart-idle.
>>
>> However, if this flag is used, smart-idle nor smart-idle wakeup-capable
>> features could not be used. This would not be ideal if we want, for instance,
>> to wake up using a HDMI cable connect event.
>>
>> Ideally, the HDMI module should be set to no-idle when transmitting audio
>> and then go back to whatever mode it was (e.g., smart-idle) when audio
>> transmission is over. I am not sure how to do that, though.
>>
>> In the past, it was suggested to use an integration function through
>> platform_data[2], which didn't seem to be  suitable from the device tree
>> perspective; although there were no other alternatives[3].
>>
>> It was also suggested to add functions to allow/block smart-idle
>> momentarily[4], but how would the driver let know omap_hwmod when to
>> allow/block smart-idle without using platform_data/integration function?
>
> Yep that's indeed a good summary of the situation.
>
> Since your patch fixes a functionality problem, maybe update the inline
> comment that you add to the data file to summarize what you wrote above:
> that this is simply a temporary workaround until the device driver has the
> ability to control the idle behavior.
>
> Also if you want this patch to go in during the 3.5-rc fixes cycle, please
> document further in the patch description what specific problem this fixes
> (e.g., choppy/broken audio, etc.)

Thanks Paul! I will resend the patch with the updated comments.

Ricardo
>
>
> - Paul
>

