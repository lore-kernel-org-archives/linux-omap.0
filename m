From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 2/8] OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
Date: Fri, 1 Jul 2011 22:54:01 +0200
Message-ID: <1309553647-14624-3-git-send-email-b-cousson@ti.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40831 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757034Ab1GAUyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 16:54:19 -0400
In-Reply-To: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add the flag to every IPs that support it to allow the
framework to enable it instead of the SMART_STANDBY default
mode.
Without that, an IP with busmaster capability will not
be able to wakeup the interconnect at all.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4bb12b8..5e9df34 100644
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
 
@@ -2089,7 +2090,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_hsi_sysc = {
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART),
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -2491,7 +2492,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_iss_sysc = {
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART),
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
@@ -3465,7 +3466,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_mmc_sysc = {
 			   SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART),
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
-- 
1.7.0.4

