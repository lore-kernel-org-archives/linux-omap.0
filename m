From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [PATCH] ARM: OMAP4/highbank: Flush L2 cache before disabling
Date: Mon,  7 Oct 2013 13:27:01 +0300
Message-ID: <1381141621-29001-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:47391 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab3JGK1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 06:27:12 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so3107179ead.5
        for <linux-omap@vger.kernel.org>; Mon, 07 Oct 2013 03:27:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, steve.mcintyre@linaro.org, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linaro-kernel@lists.linaro.org, linux-omap@vger.kernel.org

Kexec disables outer cache before jumping to reboot code, but it doesn't
flush it explicitly. Flush is done implicitly inside of l2x0_disable().
But some SoC's override default .disable handler and don't flush cache.
This may lead to a corrupted memory during Kexec reboot on these platforms.

This patch adds cache flush inside of OMAP4 and Highbank outer_cache.disable()
handlers to make it consistent with default l2x0_disable().
Also it removes redundant outer_flush_all() call just before outer_disable().

Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
Based on v3.12-rc3

RFC v2: https://patchwork.kernel.org/patch/2990231/
        Make the fix specific to platforms that don't use l2x0_disable().
RFC v1: https://patchwork.kernel.org/patch/2974431/
---
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linaro-kernel@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-highbank/highbank.c  |    1 +
 arch/arm/mach-highbank/pm.c        |    1 -
 arch/arm/mach-omap2/omap4-common.c |    1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8e63ccd..22e6f34 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -63,6 +63,7 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 
 static void highbank_l2x0_disable(void)
 {
+	outer_flush_all();
 	/* Disable PL310 L2 Cache controller */
 	highbank_smc1(0x102, 0x0);
 }
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 04eddb4..9a5b8a7 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -28,7 +28,6 @@
 
 static int highbank_suspend_finish(unsigned long val)
 {
-	outer_flush_all();
 	outer_disable();
 
 	highbank_set_pwr_suspend();
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 2840d1e..f6ccab61 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -163,6 +163,7 @@ void __iomem *omap4_get_l2cache_base(void)
 
 static void omap4_l2x0_disable(void)
 {
+	outer_flush_all();
 	/* Disable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x0);
 }
-- 
1.7.9.5

