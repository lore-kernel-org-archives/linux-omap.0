From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/12] ARM: OMAP2: PRM: add support for OMAP2 specific clock providers
Date: Fri, 28 Feb 2014 11:23:03 +0200
Message-ID: <1393579384-23440-12-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43801 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbaB1JYh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 04:24:37 -0500
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for initializing also omap2-prcm and omap2-scrm
through DT.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm_common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b4c4ab9..878ae9f 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -475,6 +475,8 @@ static struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm" },
 	{ .compatible = "ti,am4-prcm" },
 	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,omap2-prcm" },
+	{ .compatible = "ti,omap2-scrm" },
 	{ .compatible = "ti,omap3-prm" },
 	{ .compatible = "ti,omap3-cm" },
 	{ .compatible = "ti,omap3-scrm" },
-- 
1.7.9.5

