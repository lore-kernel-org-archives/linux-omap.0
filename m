From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 09/14] ARM: OMAP2+: AM43x: SRAM base and size
Date: Mon, 27 May 2013 20:06:42 +0530
Message-ID: <7dd913330dbe9f364b7b27e5fd02180ce2a584c0.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sanjeev Premi <premi@ti.com>

This definition corresponds to the L3_OCMC0,
as in case of AM33XX.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 0ff0f06..4bd0968 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -119,6 +119,9 @@ static void __init omap_detect_sram(void)
 		if (soc_is_am33xx()) {
 			omap_sram_start = AM33XX_SRAM_PA;
 			omap_sram_size = 0x10000; /* 64K */
+		} else if (soc_is_am43xx()) {
+			omap_sram_start = AM33XX_SRAM_PA;
+			omap_sram_size = SZ_256K;
 		} else if (cpu_is_omap34xx()) {
 			omap_sram_start = OMAP3_SRAM_PA;
 			omap_sram_size = 0x10000; /* 64K */
-- 
1.7.12
