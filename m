From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/6] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
Date: Thu, 23 Jun 2011 23:00:38 +0200
Message-ID: <1308862842-3933-3-git-send-email-b-cousson@ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55035 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab1FWVBK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:01:10 -0400
In-Reply-To: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Add the flag to every IPs that support it to allow the
framework to enable it instead of the SMART_STANDBY default
mode.
Without that, an IP with busmaster capability will not
be able to wakeup the interconnect at all.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f7f4840..c531611 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -661,7 +661,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_aess_sysc = {
 	.sysc_offs	= 0x0010,
 	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART |
+			   MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
@@ -2045,7 +2046,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_hsi_sysc = {
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART),
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -2447,7 +2448,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_iss_sysc = {
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART),
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
@@ -3421,7 +3422,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_mmc_sysc = {
 			   SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART),
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
-- 
1.7.0.4

