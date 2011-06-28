From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/7] OMAP4: hwmod data: TEMP: Fix timer1 main_clk
Date: Tue, 28 Jun 2011 11:27:42 +0200
Message-ID: <4E099E8E.7070802@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>	<1309192391-12410-7-git-send-email-b-cousson@ti.com> <877h864xki.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab1F1J1r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 05:27:47 -0400
In-Reply-To: <877h864xki.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/28/2011 2:19 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
> 
>> Since the timer is still not pm_runtime adapted, it is still
>> using directly the physical clock nodes at init time.
>>
>> Replace the clock node by the original one in the clock data
>> file.
>>
>> Keep the original name until the driver is fixed.
> 
> Is this still needed when used with Tony's devel-timer branch?

I didn't follow what Tony did, but I'm not sure he is fixing that part.
 
> I assume not.

After checking the new timer.c file, we still have the problematic part. Only the migration to hwmod will fix that:

static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
						int gptimer_id,
						const char *fck_source)
{

[...]

	/* After the dmtimer is using hwmod these clocks won't be needed */
	sprintf(name, "gpt%d_fck", gptimer_id);
	timer->fclk = clk_get(NULL, name);
	if (IS_ERR(timer->fclk))
		return -ENODEV;

	sprintf(name, "gpt%d_ick", gptimer_id);
	timer->iclk = clk_get(NULL, name);
	if (IS_ERR(timer->iclk)) {
		clk_put(timer->fclk);
		return -ENODEV;
	}

There is even a comment that confirm the issue:-)

Regards,
Benoit
