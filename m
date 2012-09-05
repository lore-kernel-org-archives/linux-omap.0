From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 04/10] ARM: OMAP2/3: Define HWMOD software reset status for DMTIMERs
Date: Wed, 5 Sep 2012 14:04:26 -0500
Message-ID: <1346871872-24413-5-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33123 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759005Ab2IETEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 15:04:50 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

For OMAP2/3 devices, the HWMOD data does not define a software reset status
field for the DMTIMERs. Therefore, when HWMOD performs a soft-reset of the
DMTIMER we don't check and wait for the reset to complete. For OMAP2/3 devices,
the software reset status for a DMTIMER can be read from bit 0 of the DMTIMER
TISTAT register (referred to as the SYSS register in HWMOD). Add the
appropriate HWMOD definitions so that HWMOD will check the software reset
status when performing a software reset of the DMTIMER.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..d094285 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -60,7 +60,7 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 659f7c4..5f0b2ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -121,7 +121,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
-- 
1.7.9.5

