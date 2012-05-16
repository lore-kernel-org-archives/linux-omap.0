From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Wed, 16 May 2012 08:34:06 -0500
Message-ID: <4FB3ACCE.1050103@ti.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59613 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758846Ab2EPNeD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 09:34:03 -0400
In-Reply-To: <4FB37356.9040001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Benoit,

On 05/16/2012 04:28 AM, Cousson, Benoit wrote:
> Hi Jon,
> 
> On 5/16/2012 1:35 AM, Jon Hunter wrote:
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> In order to migrate the dmtimer driver to support device-tree I found
>> that it
>> was first necessary to clean-up the timer platform data. The goal of this
>> series is to simplify the timer platform data structure from ...
>>
>> struct dmtimer_platform_data {
>>     int (*set_timer_src)(struct platform_device *pdev, int source);
>>     int timer_ip_version;
>>     u32 needs_manual_reset:1;
>>     bool reserved;
>>     bool loses_context;
>>     int (*get_context_loss_count)(struct device *dev);
>> };
>>
>> to ...
>>
>> struct dmtimer_platform_data {
>>     int (*set_timer_src)(struct platform_device *pdev, int source);
> 
> I guess that custom set_timer_src should not be there at all anymore.
> Well at least for OMAP2+.
> We should just use the regular clock API to change the parent. I do not
> see why we should add that wrapper on top of the clock API and thus
> store some internal clock name inside the timer device init code.

Yes I really wanted to eliminate that function pointer too, but it was a
little trickier. The OMAP2+ code does use the clock framework to switch
the parent already, but the problem is that the OMAP1 code does not. So
we cannot have a common function for OMAP1 and OMAP2+.

One option would be to move the OMAP2+ function into the dmtimer because
it already uses the clock framework and then only populate the function
pointer for OMAP1. However, I admit this is ugly.

Let me look at this some more to see what I can do. I can at least test
on my old omap1 board now for prototyping :-)

Did you look at the rest of the series? Let me know if you are ok with
the approach and have any concerns on my hwmod changes/fix-ups ;-)

Cheers
Jon
