From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] ARM: AM43xx: hwmod: set DSS submodule parent hwmods
Date: Fri, 19 Dec 2014 12:45:13 +0200
Message-ID: <1418985914-9027-2-git-send-email-tomi.valkeinen@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58351 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaLSKpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2014 05:45:54 -0500
In-Reply-To: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Set DSS core hwmod as the parent for all the DSS submodules. This fixes
the boot time DSS reset, removing the following warnings:

omap_hwmod: dss_dispc: cannot be enabled for reset (3)
omap_hwmod: dss_rfbi: cannot be enabled for reset (3)

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 5c6c8410160e..8eb85925e444 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -498,6 +498,7 @@ static struct omap_hwmod am43xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &am43xx_dss_dispc_dev_attr,
+	.parent_hwmod	= &am43xx_dss_core_hwmod,
 };
 
 /* rfbi */
@@ -512,6 +513,7 @@ static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
 			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
 		},
 	},
+	.parent_hwmod	= &am43xx_dss_core_hwmod,
 };
 
 /* Interfaces */
-- 
2.2.0

