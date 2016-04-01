From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3] ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
Date: Fri, 1 Apr 2016 17:53:06 -0500
Message-ID: <1459551187-5992-3-git-send-email-nm@ti.com>
References: <1459551187-5992-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459551187-5992-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

When commit 06c2d368fc36 ("ARM: OMAP: DRA7: Make use of omap_revision
information for soc_is* calls") introduced SoC check using
omap_revision, it missed providing DRA7 as class for initializing
the omap_version variable. Without doing this, soc_is_dra7xx() will
fail and as a result, omap4_pm_init_early never initializes the dra7
erratum for CPU power state. This causes the suspend path to fail
on DRA7 devices.

Fixes: 06c2d368fc36 ("ARM: OMAP: DRA7: Make use of omap_revision information for soc_is* calls")
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3c87e40650cf..2b86b25bcb83 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -736,7 +736,8 @@ void __init omap5_init_late(void)
 #ifdef CONFIG_SOC_DRA7XX
 void __init dra7xx_init_early(void)
 {
-	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
+	omap2_set_globals_tap(DRA7XX_CLASS,
+			      OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap2_control_base_init();
 	omap4_pm_init_early();
-- 
2.8.0
