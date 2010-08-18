From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 03/10] OMAP4: Add the new voltage to vsel calculation formula
Date: Wed, 18 Aug 2010 16:46:24 +0530
Message-ID: <1282130191-9062-4-git-send-email-thara@ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51676 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab0HRLQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:16:44 -0400
In-Reply-To: <1282130191-9062-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

TWL6030 the power IC used along with OMAP4 in OMAP4 SDPs,
blaze boards and panda boards has a different formula
from that of TWL4030 for voltage to vsel and
vsel to voltage calculation. This patch implements the new
formula depending on the PMIC type.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp_twl_tps.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index 112f106..9445733 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -13,6 +13,8 @@
  * XXX This code should be part of some other TWL/TPS code.
  */
 
+#include <linux/i2c/twl.h>
+
 #include <plat/opp_twl_tps.h>
 
 /**
@@ -24,6 +26,9 @@
  */
 unsigned long omap_twl_vsel_to_uv(const u8 vsel)
 {
+	if (twl_class_is_6030())
+		return ((((vsel - 1) * 125) + 7000)) * 100;
+
 	return (((vsel * 125) + 6000)) * 100;
 }
 
@@ -37,5 +42,8 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
 	/* Round up to higher voltage */
+	if (twl_class_is_6030())
+		return DIV_ROUND_UP(uv - 700000, 12500) + 1;
+
 	return DIV_ROUND_UP(uv - 600000, 12500);
 }
-- 
1.7.1.GIT

