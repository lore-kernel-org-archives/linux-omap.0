From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 03/10] ARM: DRA7: hwmod: set DSS submodule parent hwmods
Date: Tue, 24 Mar 2015 16:55:03 +0200
Message-ID: <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46191 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbbCXO4G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 10:56:06 -0400
In-Reply-To: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Set DSS core hwmod as the parent for all the DSS submodules.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index c236ea9bb940..0411b838b4fa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -521,6 +521,7 @@ static struct omap_hwmod dra7xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &dss_dispc_dev_attr,
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
@@ -562,6 +563,7 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
-- 
2.3.3

