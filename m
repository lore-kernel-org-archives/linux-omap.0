From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Mon, 29 Mar 2010 10:01:45 +0300
Message-ID: <20100329070145.GF28825@nokia.com>
References: <496565EC904933469F292DDA3F1663E602CADC372D@dlee06.ent.ti.com>
 <20100329.094017.112623699.Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49182 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab0C2HCl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 03:02:41 -0400
Content-Disposition: inline
In-Reply-To: <20100329.094017.112623699.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Cc: "x0095840@ti.com" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

hi,

On Mon, Mar 29, 2010 at 08:40:17AM +0200, Doyu Hiroshi (Nokia-D/Helsinki) wrote:
>> From 47783fc3e030d4e49d20ba412661cc1f38d8aec0 Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>> Date: Fri, 26 Mar 2010 13:06:32 -0600
>> Subject: [PATCH] OMAP3: mailbox initialization for all omap versions
>>
>> This removes the check for omap2420, omap3430, omap44xx
>> and initialize mailbox for all versions
>>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>
>It seems that I missed one point previously when I commented. I have
>just now found that "multi omap arch support" for mailbox is broken at
>the previous commit:454bf340c986b798cd4c2fd676caffa2c1e61482
>
>Considering to fix the above to keep "multi omap arch support", "omap
>cpu type check" is necessary here. Could this be fixed as something below?
>
>#if defined(CONFIG_ARCH_OMAP2)
>static struct resource omap2_mbox_resources[] = {
>       ...
>};
>#endif
>
>#if defined(CONFIG_ARCH_OMAP3)
>static struct resource omap3_mbox_resources[] = {
>       ...
>};
>#endif
>
>#if defined(CONFIG_ARCH_OMAP4)
>static struct resource omap4_mbox_resources[] = {
>       ...
>};
>#endif
>
>static struct platform_device mbox_device = {
>	.name		= "omap2-mailbox",
>	.id		= -1,
>};
>
>static inline void omap_init_mbox(void)
>{
>#if defined(CONFIG_ARCH_OMAP2)
>	if (cpu_is_omap2420()) {
>		mbox_device.num_resources = ARRAY_SIZE(omap2_mbox_resources);
>		mbox_device.resource = omap2_mbox_resources;
>	}
>#endif
>#if defined(CONFIG_ARCH_OMAP3)
>	if (cpu_is_omap3430()) {
>		mbox_device.num_resources = ARRAY_SIZE(omap3_mbox_resources);
>		mbox_device.resource = omap3_mbox_resources;
>	}
>#endif
>#if defined(CONFIG_ARCH_OMAP4)
>	if (cpu_is_omap44xx()) {
>		mbox_device.num_resources = ARRAY_SIZE(omap4_mbox_resources);
>		mbox_device.resource = omap4_mbox_resources;
>	}
>#endif
>	if (!mbox_device.resource) {
>		pr_err("%s: platform not supported\n", __func__);
>		return;
>	}
>	platform_device_register(&mbox_device);
>}

in that case, wouldn't it be better to split that into 
arch/arm/omap1/mbox.c arch/arm/omap2/mbox24xx.c 
arch/arm/omap2/mbox34xx.c arch/arm/omap2/mbox44xx.c ??

that way we don't need ifdefs on the code and we will only compile what 
we really need.

just my 2 cents.

-- 
balbi
