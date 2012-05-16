From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Wed, 16 May 2012 15:14:45 -0500
Message-ID: <4FB40AB5.10302@ti.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48996 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965355Ab2EPUOl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 16:14:41 -0400
In-Reply-To: <4FB37356.9040001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

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

I have been looking into this and in order to get rid for the above
function pointer we would need to move at a minimum the following
functions from omap-mach2/clkt_clksel.c into the platform code.

_get_clksel_by_parent()
_get_div_and_fieldval()
_write_clksel_reg()
omap2_init_clksel_parent()
omap2_clksel_set_parent()

However, it may be simpler just to move the clkt_clksel.c file
completely. I have tested the above functions on omap1 and they are
working well. However, before doing this we would need to get Paul's
buy-in that this is the right thing to do.

Paul, do you have any thoughts on this? We were trying to see if we
could eliminate the dmtimer function pointer for setting the timer clock
source.

Also, the only other minor issue I see is that for omap1 devices instead
of having "sys_ck" as the name the clock name is "armxor_ck". We cannot
rename armxor_ck as it is used by many peripherals but we could use a
#define to workaround this or add a dummy clock node.

Cheers
Jon
