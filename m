From: Archit Taneja <archit@ti.com>
Subject: [RFC 1/4] ARM: OMAP2+: Add CTRL_MODULE_CORE as a master clock provider for DRA7
Date: Wed, 16 Apr 2014 18:44:20 +0530
Message-ID: <1397654063-8055-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39554 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbaDPNPs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 09:15:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

The control module isn't actually a clock management module, but there are a few
register bits which perform gating and muxing of clocks.

Add CTRL_MODULE_CORE sub block as a clock provider for DRA7. The control module
has 2 sub modules: CTRL_MODULE_CORE, and CTRL_MODULE_WKUP. Out of these, only
the CORE sub module has clock related register fields. We ignore the WKUP sub
module.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/prm_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b4c4ab9..f86029a 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -489,6 +489,7 @@ static struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,dra7-prm" },
 	{ .compatible = "ti,dra7-cm-core-aon" },
 	{ .compatible = "ti,dra7-cm-core" },
+	{ .compatible = "ti,dra7-ctrl-core" },
 	{ }
 };
 
-- 
1.8.3.2

