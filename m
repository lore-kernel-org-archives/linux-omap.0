From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/6] ARM: AM43xx: Add the PRM IRQ register offsets
Date: Wed, 8 Jul 2015 11:12:24 +0530
Message-ID: <1436334148-9309-3-git-send-email-j-keerthy@ti.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com, paul@pwsan.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add the PRM IRQ register offsets.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prcm43xx.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 7eebc27..d716d2e 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -25,6 +25,10 @@
 #define AM43XX_PRM_WKUP_INST				0x2000
 #define AM43XX_PRM_DEVICE_INST				0x4000
 
+/* PRM_IRQ offsets */
+#define AM43XX_PRM_IRQSTATUS_MPU_OFFSET			0x0004
+#define AM43XX_PRM_IRQENABLE_MPU_OFFSET			0x0008
+
 /* RM RSTCTRL offsets */
 #define AM43XX_RM_PER_RSTCTRL_OFFSET			0x0010
 #define AM43XX_RM_GFX_RSTCTRL_OFFSET			0x0010
@@ -146,6 +150,7 @@
 #define AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET		0x04a0
 #define AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET		0x0068
 #define AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET		0x0070
+#define AM43XX_PRM_IO_PMCTRL_OFFSET			0x0024
 #define AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET		0x0720
 
 #endif
-- 
1.9.1
