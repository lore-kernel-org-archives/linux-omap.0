From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/2] ARM: OMAP3: Use offset definition and omap_ctrl_writel for boot mode
Date: Tue, 29 Mar 2016 21:25:16 +0200
Message-ID: <1459279517-17479-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This introduces offset definitions for scratchpad and scratchpad boot mode to
be used with omap_ctrl_writel, fixing a comment suggesting this.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-omap2/control.c | 4 +---
 arch/arm/mach-omap2/control.h | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1662071..3690d78 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -225,10 +225,8 @@ void omap3_ctrl_write_boot_mode(u8 bootmode)
 	 * describing the boot process can be stored there,
 	 * cf. OMAP34xx TRM, Initialization / Software Booting
 	 * Configuration.
-	 *
-	 * XXX This should use some omap_ctrl_writel()-type function
 	 */
-	writel_relaxed(l, OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD + 4));
+	omap_ctrl_writel(l, OMAP343X_CONTROL_SCRATCHPAD_BOOT_MODE);
 }
 
 #endif
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index ec406bc..b839ea2 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -177,6 +177,9 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+#define OMAP343X_CONTROL_SCRATCHPAD		(OMAP2_CONTROL_GENERAL + 0x06A0)
+#define OMAP343X_CONTROL_SCRATCHPAD_BOOT_MODE	(OMAP2_CONTROL_GENERAL + 0x06A4)
+
 /* OMAP3630 only CONTROL_GENERAL register offsets */
 #define OMAP3630_CONTROL_FUSE_OPP1G_VDD1        (OMAP2_CONTROL_GENERAL + 0x0110)
 #define OMAP3630_CONTROL_FUSE_OPP50_VDD1        (OMAP2_CONTROL_GENERAL + 0x0114)
-- 
2.7.4
