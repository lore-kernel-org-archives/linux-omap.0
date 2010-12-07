From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] arm: plat-omap: counter_32k: Fix build error due to IS_ERR
Date: Tue,  7 Dec 2010 17:39:37 +0530
Message-ID: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43232 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab0LGMJt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 07:09:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>

Fix the following build error by including linux/err.h
arch/arm/plat-omap/counter_32k.c: In function 'omap_init_clocksource_32k':
arch/arm/plat-omap/counter_32k.c:167: error: implicit declaration of
                                      function 'IS_ERR'

The above error is due to the following commit:
subject: arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check
commit: 235fbace0334c846c21e902f330020122fc85955

Created on linux-omap-2.6 branch: omap-fixes

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Reviewed-by: Charulatha V <charu@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/counter_32k.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index c1e0d00..8722a13 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/err.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
-- 
1.7.0.4

