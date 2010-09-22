From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
Date: Wed, 22 Sep 2010 16:11:39 -0700
Message-ID: <87wrqd74r8.fsf@deeprootsystems.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
	<87r5goq7ro.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD3C16FE@dbde02.ent.ti.com>
	<87zkvbj7yc.fsf@deeprootsystems.com>
	<87k4mefz70.fsf@deeprootsystems.com>
	<87bp7qfx6g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42899 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab0IVXLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 19:11:43 -0400
Received: by pwj6 with SMTP id 6so96000pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 16:11:43 -0700 (PDT)
In-Reply-To: <87bp7qfx6g.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Tue, 21 Sep 2010 17:18:15 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

> I also just tested on n900 which has lots of GPIOs configured.  On this
> platform, suspend doesn't hit RET because both GPIO3 and GPIO4 are still
> enabled.  

OK, I found the bug on n900, and you're off the hook for this one. :)
It's an existing bug and the problem exists before applying your series.

See patch below for description, and I'll be posting/queuing this patch
in pm-next (included in pm-core)

Kevin


>From 9a0cc83c1199d802784ee2e4d249611231117fa1 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Wed, 22 Sep 2010 16:06:27 -0700
Subject: [PATCH] OMAP: GPIO: ensure debounce clocks are disabled during idle/suspend

If a GPIO bank has more than one GPIO with debounce enabled, the
debounce clock will not be fully disabled before going to
idle/suspend.

In the idle path, we just do a single clk_disable() of the bank's
debounce clock.  If there are multiple debounce-enabled GPIOs in the
bank, that clocks usage count will be > 1, so the clk_disable() will
not actually disable the clock.

So the fix is to clk_disable() for every debounce-enabled GPIO in the
bank (and an equivalent clk_enable() of course.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/gpio.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7951eef..5d38d62 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2085,8 +2085,9 @@ void omap2_gpio_prepare_for_idle(int power_state)
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1, l2;
-
-		if (bank->dbck_enable_mask)
+		int j;
+ 
+		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_disable(bank->dbck);
 
 		if (power_state > PWRDM_POWER_OFF)
@@ -2152,8 +2153,9 @@ void omap2_gpio_resume_after_idle(void)
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l, gen, gen0, gen1;
-
-		if (bank->dbck_enable_mask)
+		int j;
+ 
+		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
 		if (!workaround_enabled)
-- 
1.7.2.1

