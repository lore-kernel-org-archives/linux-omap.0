From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Mon, 29 Mar 2010 09:40:17 +0300 (EEST)
Message-ID: <20100329.094017.112623699.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E602CADC372D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43107 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab0C2Gk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 02:40:29 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CADC372D@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org, ameya.palande@nokia.com, felipe.contreras@nokia.com

Hi Fernando,

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Fri, 26 Mar 2010 20:30:34 +0100

> From 47783fc3e030d4e49d20ba412661cc1f38d8aec0 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Fri, 26 Mar 2010 13:06:32 -0600
> Subject: [PATCH] OMAP3: mailbox initialization for all omap versions
> 
> This removes the check for omap2420, omap3430, omap44xx
> and initialize mailbox for all versions
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

It seems that I missed one point previously when I commented. I have
just now found that "multi omap arch support" for mailbox is broken at
the previous commit:454bf340c986b798cd4c2fd676caffa2c1e61482

Considering to fix the above to keep "multi omap arch support", "omap
cpu type check" is necessary here. Could this be fixed as something below?

#if defined(CONFIG_ARCH_OMAP2)
static struct resource omap2_mbox_resources[] = {
       ...
};
#endif

#if defined(CONFIG_ARCH_OMAP3)
static struct resource omap3_mbox_resources[] = {
       ...
};
#endif

#if defined(CONFIG_ARCH_OMAP4)
static struct resource omap4_mbox_resources[] = {
       ...
};
#endif

static struct platform_device mbox_device = {
	.name		= "omap2-mailbox",
	.id		= -1,
};

static inline void omap_init_mbox(void)
{
#if defined(CONFIG_ARCH_OMAP2)
	if (cpu_is_omap2420()) {
		mbox_device.num_resources = ARRAY_SIZE(omap2_mbox_resources);
		mbox_device.resource = omap2_mbox_resources;
	}
#endif
#if defined(CONFIG_ARCH_OMAP3)
	if (cpu_is_omap3430()) {
		mbox_device.num_resources = ARRAY_SIZE(omap3_mbox_resources);
		mbox_device.resource = omap3_mbox_resources;
	}
#endif
#if defined(CONFIG_ARCH_OMAP4)
	if (cpu_is_omap44xx()) {
		mbox_device.num_resources = ARRAY_SIZE(omap4_mbox_resources);
		mbox_device.resource = omap4_mbox_resources;
	}
#endif
	if (!mbox_device.resource) {
		pr_err("%s: platform not supported\n", __func__);
		return;
	}
	platform_device_register(&mbox_device);
}

Then resource registration could be done at runtime. I'm not so sure
if the above cpu types are correct from h/w perspective, which should
be fixed appropriately.
