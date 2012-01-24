From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2/3: HWMOD: Add missing flags for dispc class
Date: Tue, 24 Jan 2012 12:45:18 +0200
Message-ID: <1327401920-5617-2-git-send-email-tomi.valkeinen@ti.com>
References: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:34619 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755784Ab2AXKpg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:45:36 -0500
In-Reply-To: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hwmod class for dispc is missing sysc flags, which this patch adds.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 2a67297..7d1f71a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -39,7 +39,8 @@ static struct omap_hwmod_class_sysconfig omap2_dispc_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b176d44..76e6498 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1491,7 +1491,8 @@ static struct omap_hwmod_class_sysconfig omap3_dispc_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
 			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
-			   SYSC_HAS_ENAWAKEUP),
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_CLOCKACTIVITY |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
-- 
1.7.4.1

