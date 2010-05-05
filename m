From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH] omap: gpio: Fix compilation warnings
Date: Wed,  5 May 2010 13:47:31 -0500
Message-ID: <1273085251-6883-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33466 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab0EESm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:42:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgreen <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This patch fixes following compilation warnings:

 In function 'omap2_gpio_resume_after_retention':
2096: warning: 'l' may be used uninitialized in this function
 In function 'omap2_gpio_prepare_for_retention':
2039: warning: 'l2' may be used uninitialized in this function
2039: warning: 'l1' may be used uninitialized in this function

Which got introduced in commit ID:

  commit 3f1686a9bfe74979c6ad538c78039730f665f77e
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Mon Feb 15 09:27:25 2010 -0800

      omap: Fix gpio.c for multi-omap for omap4

By making the first value assignation conditional in runtime, and
making the compiler think they could be used uninitialized.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/plat-omap/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 45a225d..f0d5c2f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2036,7 +2036,7 @@ void omap2_gpio_prepare_for_retention(void)
 	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l1, l2;
+		u32 l1 = 0, l2 = 0;
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
@@ -2093,7 +2093,7 @@ void omap2_gpio_resume_after_retention(void)
 		return;
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l, gen, gen0, gen1;
+		u32 l = 0, gen, gen0, gen1;
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-- 
1.6.3.3

