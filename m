From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 12/18] GPIO: OMAP: Clean omap_gpio_mod_init function
Date: Mon, 27 Jun 2011 16:06:00 -0700
Message-ID: <8762nq7u3r.fsf@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-3-git-send-email-tarun.kanti@ti.com>
	<87fwn9mzu0.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037BC15847@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:43444 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755203Ab1F0XGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 19:06:05 -0400
Received: by pwi1 with SMTP id 1so4537562pwi.34
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 16:06:03 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037BC15847@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Mon, 27 Jun 2011 16:18:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> Kevin,
> [...]
>> >
>> > With register offsets now defined for respective OMAP versions we can
>> get rid
>> > of cpu_class_* checks. In addition, organized common initialization for
>> the
>> > different OMAP silicon versions.
>> >
>> > Signed-off-by: Charulatha V <charu@ti.com>
>> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> 
>> Since the SYSCONFIG register settings are OMAP1-only and init-time only,
>> they could be done in the OMAP1-specific init functions.
> BTW, I needed some more clarifications here...
> The omap_gpio_mod_init() is called only once from _probe().
> So, does it make sense to have a separate init function?
> If yes, I have to call __init omap1_gpio_mod_init() from _probe() again.
> This is because I need the bank information supplied to it.

What I was thinking is something like the patch below (16xx only for
example, but would need to be done for other OMAP1 also).  This patch
will obviously not work, but read the comment in the patch to make it work.

Kevin

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index c69b3b1..1d34a4c 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -218,8 +218,12 @@ static int __init omap16xx_gpio_init(void)
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
+	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
+		u32 base = 0; /* get base from device's struct resource */
+
+		__raw_writew(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
 		platform_device_register(omap16xx_gpio_dev[i]);
+	}
 
 	gpio_bank_count = ARRAY_SIZE(omap16xx_gpio_dev);
