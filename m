From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 6/6] OMAP: hwmod: Temp fixes to get hwmod registers work
Date: Fri,  7 May 2010 18:07:04 +0200
Message-ID: <1273248424-15943-7-git-send-email-b-cousson@ti.com>
References: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59907 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756918Ab0EGQHV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 12:07:21 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o47G7KBi007587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 7 May 2010 11:07:21 -0500
In-Reply-To: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Do not disable any clocks yet since not all drivers are adapted
and rely on bootloader to enable clocks

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 302f2c8..9f7cb9f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -524,6 +524,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
+	return 0;
+
 	if (oh->_clk)
 		clk_disable(oh->_clk);
 
-- 
1.6.1.3

