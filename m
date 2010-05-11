From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/5] OMAP4 clock: Support clk_set_parent
Date: Tue, 11 May 2010 12:57:06 +0530
Message-ID: <1273562830-9758-2-git-send-email-rnayak@ti.com>
References: <1273562830-9758-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757215Ab0EKH1Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 May 2010 03:27:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4B7RDpL006839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 02:27:15 -0500
In-Reply-To: <1273562830-9758-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

Remove the hack put in place while clock framework
was still not in place for OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/clock.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 5261a09..701e4ea 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -140,9 +140,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (cpu_is_omap44xx())
-	/* OMAP4 clk framework not supported yet */
-		return 0;
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 
-- 
1.7.0.rc1.33.g07cf0f

