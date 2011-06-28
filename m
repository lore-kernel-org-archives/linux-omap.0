From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 6/7] OMAP4: hwmod data: TEMP: Fix timer1 main_clk
Date: Tue, 28 Jun 2011 08:17:40 -0700
Message-ID: <871uye2dez.fsf@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
	<1309192391-12410-7-git-send-email-b-cousson@ti.com>
	<877h864xki.fsf@ti.com> <4E099E8E.7070802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57328 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754757Ab1F1PRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 11:17:44 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so141435pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 08:17:43 -0700 (PDT)
In-Reply-To: <4E099E8E.7070802@ti.com> (Benoit Cousson's message of "Tue, 28
	Jun 2011 11:27:42 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 6/28/2011 2:19 AM, Hilman, Kevin wrote:
>> Benoit Cousson<b-cousson@ti.com>  writes:
>> 
>>> Since the timer is still not pm_runtime adapted, it is still
>>> using directly the physical clock nodes at init time.
>>>
>>> Replace the clock node by the original one in the clock data
>>> file.
>>>
>>> Keep the original name until the driver is fixed.
>> 
>> Is this still needed when used with Tony's devel-timer branch?
>
> I didn't follow what Tony did, but I'm not sure he is fixing that part.
>  
>> I assume not.
>
> After checking the new timer.c file, we still have the problematic part. Only the migration to hwmod will fix that:
>
> static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
> 						int gptimer_id,
> 						const char *fck_source)
> {
>
> [...]
>
> 	/* After the dmtimer is using hwmod these clocks won't be needed */
> 	sprintf(name, "gpt%d_fck", gptimer_id);
> 	timer->fclk = clk_get(NULL, name);
> 	if (IS_ERR(timer->fclk))
> 		return -ENODEV;
>
> 	sprintf(name, "gpt%d_ick", gptimer_id);
> 	timer->iclk = clk_get(NULL, name);
> 	if (IS_ERR(timer->iclk)) {
> 		clk_put(timer->fclk);
> 		return -ENODEV;
> 	}
>
> There is even a comment that confirm the issue:-)

Well, I'm not sure that comment is correct either.

Tony's series converts the driver to use hwmod.  The problem is the
clocks are still needed for changing the parent, so there is still
a clk_disable, clk_set_parent, clk_enable sequence used.

Kevin
