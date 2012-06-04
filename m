From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Mon, 4 Jun 2012 09:11:01 -0500
Message-ID: <4FCCC1F5.80507@ti.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab2FDOLD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 10:11:03 -0400
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

I was trying to remove the set_timer_src for all omap devices, but my
series to fix this for omap1, is conflicting with Rajendra's omap2
common clock framework. So for now, I will workaround this by only using
this function pointer for omap1 devices. Then eventually if we can move
omap1 to the common clock framework we can remove it completely.
Otherwise it may take a long timer to get DT dmtimer support added for
OMAP2.

Cheers
Jon
