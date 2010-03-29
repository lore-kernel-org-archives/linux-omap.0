From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Mon, 29 Mar 2010 12:08:56 +0300 (EEST)
Message-ID: <20100329.120856.59654379.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E602CADC372D@dlee06.ent.ti.com>
	<20100329.094017.112623699.Hiroshi.DOYU@nokia.com>
	<20100329070145.GF28825@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34376 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0C2JJX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 05:09:23 -0400
In-Reply-To: <20100329070145.GF28825@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, tony@atomide.com
Cc: x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com, felipe.contreras@nokia.com

From: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Mon, 29 Mar 2010 09:01:45 +0200

> hi,
> 
> On Mon, Mar 29, 2010 at 08:40:17AM +0200, Doyu Hiroshi (Nokia-D/Helsinki) wrote:
>>> From 47783fc3e030d4e49d20ba412661cc1f38d8aec0 Mon Sep 17 00:00:00 2001
>>> From: Fernando Guzman Lugo <x0095840@ti.com>
>>> Date: Fri, 26 Mar 2010 13:06:32 -0600
>>> Subject: [PATCH] OMAP3: mailbox initialization for all omap versions
>>>
>>> This removes the check for omap2420, omap3430, omap44xx
>>> and initialize mailbox for all versions
>>>
>>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>>
>>It seems that I missed one point previously when I commented. I have
>>just now found that "multi omap arch support" for mailbox is broken at
>>the previous commit:454bf340c986b798cd4c2fd676caffa2c1e61482
>>
>>Considering to fix the above to keep "multi omap arch support", "omap
>>cpu type check" is necessary here. Could this be fixed as something below?
>>
>>#if defined(CONFIG_ARCH_OMAP2)
>>static struct resource omap2_mbox_resources[] = {
>>       ...
>>};
>>#endif
>>
>>#if defined(CONFIG_ARCH_OMAP3)
>>static struct resource omap3_mbox_resources[] = {
>>       ...
>>};
>>#endif
>>
>>#if defined(CONFIG_ARCH_OMAP4)
>>static struct resource omap4_mbox_resources[] = {
>>       ...
>>};
>>#endif
>>
>>static struct platform_device mbox_device = {
>>	.name		= "omap2-mailbox",
>>	.id		= -1,
>>};
>>
>>static inline void omap_init_mbox(void)
>>{
>>#if defined(CONFIG_ARCH_OMAP2)
>>	if (cpu_is_omap2420()) {
>>		mbox_device.num_resources = ARRAY_SIZE(omap2_mbox_resources);
>>		mbox_device.resource = omap2_mbox_resources;
>>	}
>>#endif
>>#if defined(CONFIG_ARCH_OMAP3)
>>	if (cpu_is_omap3430()) {
>>		mbox_device.num_resources = ARRAY_SIZE(omap3_mbox_resources);
>>		mbox_device.resource = omap3_mbox_resources;
>>	}
>>#endif
>>#if defined(CONFIG_ARCH_OMAP4)
>>	if (cpu_is_omap44xx()) {
>>		mbox_device.num_resources = ARRAY_SIZE(omap4_mbox_resources);
>>		mbox_device.resource = omap4_mbox_resources;
>>	}
>>#endif
>>	if (!mbox_device.resource) {
>>		pr_err("%s: platform not supported\n", __func__);
>>		return;
>>	}
>>	platform_device_register(&mbox_device);
>>}
> 
> in that case, wouldn't it be better to split that into 
> arch/arm/omap1/mbox.c arch/arm/omap2/mbox24xx.c 
> arch/arm/omap2/mbox34xx.c arch/arm/omap2/mbox44xx.c ??
> 
> that way we don't need ifdefs on the code and we will only compile what 
> we really need.

This is feasible.
But I'm not so sure whether adding 4 new files with around only 10
lines code is acceptable or not.

Tony, any comment on the above?

Basically there could be the case we need all resources if we want to
support omap1, 2, 3 and 4 at the same time, and the appropriate one
will be chosen at run time by CPUID. I'm not sure how mature "omap
multi arch" support is practically, but it's better to keep it as much
as possbile.
