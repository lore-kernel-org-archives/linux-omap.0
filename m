From: "Arun KS" <getarunks@gmail.com>
Subject: [PATCH] OMAP2EVM TWL4030 keypad update
Date: Tue, 19 Aug 2008 14:30:54 +0530
Message-ID: <dfeb90390808190200m200eb292q194b648236ba0f0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:40854 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYHSJA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 05:00:56 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1158432tic.23
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 02:00:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Now we are passing irq number via platform_data

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index 9bb8fba..4188222 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/input.h>
+#include <linux/i2c/twl4030.h>

 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -99,6 +100,7 @@ static struct omap_kp_platform_data omap2evm_kp_data = {
 	.keymap 	= omap2evm_keymap,
 	.keymapsize	= ARRAY_SIZE(omap2evm_keymap),
 	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
 };

 static struct platform_device omap2evm_kp_device = {
-- 
1.5.3.4
