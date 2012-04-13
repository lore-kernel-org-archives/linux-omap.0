From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface
Date: Fri, 13 Apr 2012 13:31:55 +0530
Message-ID: <1334304116-18872-2-git-send-email-archit@ti.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52942 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab2DMICi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 04:02:38 -0400
In-Reply-To: <1334304116-18872-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

The clocks for all DSS slave interfaces were recently changed to "dss_ick" on
OMAP2 and OMAP3, this clock can be autoidled by PRCM. The VENC interface
previously had "dss_54m_fck" as it's clock which couldn't be autoidled, and
hence the OCPIF_SWSUP_IDLE flag was needed.

Remove the OCPIF_SWSUP_IDLE flag from VENC interfaces as it's clock is now
"dss_ick".

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a5409ce..a6bde34 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1000,7 +1000,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
 			.flags	= OMAP_FIREWALL_L4,
 		}
 	},
-	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c4f56cb..04a3885 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1049,7 +1049,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
 	.slave		= &omap2430_dss_venc_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
-	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 34b9766d..db86ce9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1676,7 +1676,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
 			.flags	= OMAP_FIREWALL_L4,
 		}
 	},
-	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
1.7.5.4

