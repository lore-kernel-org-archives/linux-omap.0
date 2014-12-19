From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent hwmods
Date: Fri, 19 Dec 2014 12:45:14 +0200
Message-ID: <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40314 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbaLSKp5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 05:45:57 -0500
In-Reply-To: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Set DSS core hwmod as the parent for all the DSS submodules. This fixes
the boot time DSS reset, removing the following warnings:

omap_hwmod: dss_dispc: cannot be enabled for reset (3)
omap_hwmod: dss_hdmi: cannot be enabled for reset (3)

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ffd6604cd546..41238d509cb5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -500,6 +500,7 @@ static struct omap_hwmod dra7xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &dss_dispc_dev_attr,
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
@@ -541,6 +542,7 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
-- 
2.2.0

