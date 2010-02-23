From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP: HWMOD: Adding clockdomain check.
Date: Tue, 23 Feb 2010 22:53:19 +0530
Message-ID: <1266945800-12371-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32863 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab0BWRXd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 12:23:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch adds check for presence of clockdomain structure in the API
omap_hwmod_get_pwrdm before trying to access the powerdomain structure.
This will prevent unnecessary crashing of the system in case of a
clock node with out an associated clockdomian.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 70912d1..97fd635 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1440,6 +1440,8 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oh->slaves[oh->_mpu_port_index]->_clk;
 	}
 
+	if (!c->clkdm)
+		return NULL;
 	return c->clkdm->pwrdm.ptr;
 
 }
-- 
1.5.4.7

