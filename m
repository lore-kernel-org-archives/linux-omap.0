From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP5: Add HYP mode entry support for secondary CPUs
Date: Sat, 23 Nov 2013 19:07:46 -0500
Message-ID: <1385251666-27532-3-git-send-email-santosh.shilimkar@ti.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3KXAIT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Nov 2013 19:08:19 -0500
In-Reply-To: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Tony Lindgren <tony@atomide.com>

Boot-CPU entry into the HYP mode is managed in boot-loader but
the secondary CPUs directly jumps to kernel during boot. Same
path is also used for CPU hotplug as well during suspend for
secondary CPU.

Hence patch the secondary CPU boot path for hyp mode etry.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 75e9295..4844dd8 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -22,6 +22,7 @@
 
 /* Physical address needed since MMU not enabled yet on secondary core */
 #define AUX_CORE_BOOT0_PA			0x48281800
+#define API_HYP_ENTRY				0x102
 
 /*
  * OMAP5 specific entry point for secondary CPU to jump from ROM
@@ -38,6 +39,12 @@ wait:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
 	and	r4, r4, #0x0f
 	cmp	r0, r4
 	bne	wait
+#ifdef CONFIG_KVM_ARM_HOST
+	ldr	r12, =API_HYP_ENTRY
+	adr	r0, hyp_boot
+	smc	#0
+hyp_boot:
+#endif
 	b	secondary_startup
 END(omap5_secondary_startup)
 /*
-- 
1.7.9.5

