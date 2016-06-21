From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] ARM: AM33xx: PRM: Remove wrongly defined RSTST offset for PER Domain
Date: Tue, 21 Jun 2016 15:38:26 +0530
Message-ID: <1466503706-5292-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rnayak@codeaurora.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, afzal@ti.com, d-gerlach@ti.com, s-anna@ti.com, paul@pwsan.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

As per the TRM: http://www.ti.com/lit/ug/spruh73m/spruh73m.pdf
offset 0x4 is reserved for PRM_PER. Hence removing the wrongly
defined address offset.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm33xx.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 2bc4ec5..66302c6 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -52,8 +52,6 @@
 /* PRM.PER_PRM register offsets */
 #define AM33XX_RM_PER_RSTCTRL_OFFSET		0x0000
 #define AM33XX_RM_PER_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0000)
-#define AM33XX_RM_PER_RSTST_OFFSET		0x0004
-#define AM33XX_RM_PER_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0004)
 #define AM33XX_PM_PER_PWRSTST_OFFSET		0x0008
 #define AM33XX_PM_PER_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0008)
 #define AM33XX_PM_PER_PWRSTCTRL_OFFSET		0x000c
-- 
1.9.1
