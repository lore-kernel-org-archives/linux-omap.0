From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Fri, 02 Dec 2011 10:16:45 +0530
Message-ID: <4ED85835.7080108@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57237 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756533Ab1LBEqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 23:46:52 -0500
Received: by mail-yw0-f42.google.com with SMTP id 2so2608058ywt.15
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 20:46:51 -0800 (PST)
In-Reply-To: <4ED52007.8010804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday 29 November 2011 11:40 PM, Cousson, Benoit wrote:
> Hi Rajendra,
>
> Sorry for the delay, I kind of forgot your series :-(
>
> On 11/3/2011 11:54 AM, Nayak, Rajendra wrote:
>> Now that OMAP4 has hwmod/module level context lost counters, make
>> omap_hwmod_get_context_loss_count() return them on platforms where they
>> exist, else fall back on the pwrdm level counters for older platforms.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>> arch/arm/mach-omap2/omap_hwmod.c | 11 ++++++++---
>> 1 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index ac17748..9d140c4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2658,9 +2658,14 @@ u32 omap_hwmod_get_context_loss_count(struct
>> omap_hwmod *oh)
>> struct powerdomain *pwrdm;
>> int ret = 0;
>>
>> - pwrdm = omap_hwmod_get_pwrdm(oh);
>> - if (pwrdm)
>> - ret = pwrdm_get_context_loss_count(pwrdm);
>> + if (oh->prcm.omap4.context_offs) {
>
> I don't think it is safe to use that, since this is an union.
> You do know what OMAP2 & 3 will put in that location.
> It might be zero, but who knows?

Thats true, I need to figure out a better way to identify
when a module level context count is supported and when its
at the pwrdm level. Will repost with a fix.

Thanks for the review.

>
>> + /* Support for per-hwmod context register */
>> + ret = oh->prcm.omap4.context_lost_counter;
>> + } else {
>> + pwrdm = omap_hwmod_get_pwrdm(oh);
>> + if (pwrdm)
>> + ret = pwrdm_get_context_loss_count(pwrdm);
>> + }
>>
>> return ret;
>> }
>
> Regards,
> Benoit

