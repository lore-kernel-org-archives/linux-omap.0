From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ARM: OMAP3: vc: Remove unused macros
Date: Thu, 17 Sep 2015 15:24:14 +0200
Message-ID: <1442496254-29028-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

The PRM_POLCTRL_TWL_MASK and PRM_POLCTRL_TWL_MASK
macros are not used so they can be deleted.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/mach-omap2/vc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index d44d311704ba..2028167fff31 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -280,10 +280,6 @@ void omap3_vc_set_pmic_signaling(int core_next_state)
 	}
 }
 
-#define PRM_POLCTRL_TWL_MASK	(OMAP3430_PRM_POLCTRL_CLKREQ_POL | \
-					OMAP3430_PRM_POLCTRL_CLKREQ_POL)
-#define PRM_POLCTRL_TWL_VAL	OMAP3430_PRM_POLCTRL_CLKREQ_POL
-
 /*
  * Configure signal polarity for sys_clkreq and sys_off_mode pins
  * as the default values are wrong and can cause the system to hang
-- 
2.4.3
