From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH 4/4] AM3517: Fix suspend-resume sequence
Date: Fri, 19 Aug 2011 17:25:27 +0530
Message-ID: <1313754927-11992-5-git-send-email-abhilash.kv@ti.com>
References: <1313754927-11992-1-git-send-email-abhilash.kv@ti.com>
 <1313754927-11992-2-git-send-email-abhilash.kv@ti.com>
 <1313754927-11992-3-git-send-email-abhilash.kv@ti.com>
 <1313754927-11992-4-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313754927-11992-4-git-send-email-abhilash.kv@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, Abhilash K V <abhilash.kv@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the crash seen while resuming with i2c devices
enabled. This crash was happening because the interface-clocks
were disabled in the suspend sequence, and not re-enabled on
resumption.
The current patch saves the value of the CM_ICLKEN1_CORE register
before zeroing it out, and restores upon resumption. In AM3517 the
interface clocks are enabled by the clock module ONLY during
initialization, so the suspend sequence (in arch/arm/mach-omap2/
sleep3517.S) has to manually turn it off before executing wfi
and then back on again on returning from wfi, to ensure that all
interface clocks are enabled when control returns to omap_sram_idle()
after waking up from idle.

Reviewed-by: Vaibhav Hiremath <hvaibhav@ti.com>
Reviewed-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
---
 arch/arm/mach-omap2/sleep3517.S |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep3517.S b/arch/arm/mach-omap2/sleep3517.S
index 3fceefc..070a943 100644
--- a/arch/arm/mach-omap2/sleep3517.S
+++ b/arch/arm/mach-omap2/sleep3517.S
@@ -55,6 +55,9 @@ loop:
 
 	/* Disable SDRC and Control Module */
 	ldr     r4, cm_iclken1_core
+	ldr     r5, [r4]
+	str     r5, iclk_core_enable
+	ldr     r4, cm_iclken1_core
 	ldr     r5, clk_core_disable
 	str     r5, [r4]
 wait_sdrc_ok:
@@ -108,7 +111,7 @@ wait_sdrc_ok:
 clk_core_disable:
 	.word   0x0
 iclk_core_enable:
-	.word   0x42
+	.word   0x0
 emif_phy_gate:
 	.word   0x2620
 emif_phy_enable:
-- 
1.7.1
