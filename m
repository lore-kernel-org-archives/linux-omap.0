From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCH 3/4] OMAP: Remove inclusion of PMIC specific header file in generic opp layer.
Date: Tue, 13 Jul 2010 11:17:05 +0530
Message-ID: <1279000026-24042-4-git-send-email-thara@ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com>
 <1279000026-24042-2-git-send-email-thara@ti.com>
 <1279000026-24042-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab0GMFrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jul 2010 01:47:24 -0400
In-Reply-To: <1279000026-24042-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, b-cousson@ti.com, sawant@ti.com, vishwanath.bs@ti.com, premi@ti.com, Thara Gopinath <thara@ti.com>

This patch removes the inclusion of plat/opp_twl_tps.h in opp.c.
This header file is included unnecessarily and creats unwanted
dependency between the generic opp layer and TWL4030/5030 PMIC
dependent code.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index d88a2e0..1aea69e 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/list.h>
 
-#include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
 #include <plat/omap_device.h>
 
-- 
1.7.0.rc1.33.g07cf0f

