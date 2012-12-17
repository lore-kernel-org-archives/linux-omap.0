From: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Subject: [PATCH 1/2] ARM: OMAP3: PRCM: Fix incorrect read of reset sources
Date: Mon, 17 Dec 2012 19:26:30 +0200
Message-ID: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
List-Id: linux-omap@vger.kernel.org

The flag mask are incorrect, so fix it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 0f51e03..dc45156 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -48,9 +48,10 @@ void __iomem *prcm_mpu_base;
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+	if (cpu_is_omap34xx())
+		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7ff;
 	if (cpu_is_omap44xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
 
-- 
1.7.9.5
