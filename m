From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 6/6] ARM: PRM: AM437x: Enable IO wakeup feature
Date: Tue, 14 Jul 2015 15:38:18 +0530
Message-ID: <1436868498-27019-7-git-send-email-j-keerthy@ti.com>
References: <1436868498-27019-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436868498-27019-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, galak@codeaurora.org, bcousson@baylibre.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

Enable IO wakeup feature.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 7add799..1730fc4 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -696,6 +696,7 @@ static struct omap_prcm_init_data am4_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = AM43XX_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP,
 };
 #endif
 
-- 
1.9.1
