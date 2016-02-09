From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
Date: Tue, 9 Feb 2016 14:35:43 +0530
Message-ID: <1455008743-21660-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

OCP2SCP doesn't support smart idle wakeup according to
Table 26-22. OCP2SCP_SYSCONFIG in AM572x TRM [1] and
Table 26-22. OCP2SCP_SYSCONFIG in AM571x TRM [2].
Remove SIDLE_SMART_WKUP from the list of supported SIDLE modes
in hwmod data.

[1] -> http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf
[2] -> http://www.ti.com/lit/ug/spruhz7a/spruhz7a.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
*) Updated commit log to use public TRM links.

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 848356e..84c2699 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1482,8 +1482,7 @@ static struct omap_hwmod_class_sysconfig dra7xx_ocp2scp_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.9.5
