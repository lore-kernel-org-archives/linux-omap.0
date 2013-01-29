From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v2 6/9] ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset status bit
Date: Tue, 29 Jan 2013 12:29:19 +0530
Message-ID: <1359442762-13697-7-git-send-email-vaibhav.bedia@ti.com>
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53153 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab3A2G7n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 01:59:43 -0500
In-Reply-To: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
Update the WKUP-M3 hwmod data to reflect the same.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
v2: No change

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 40bfde3..9e34d4c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -269,6 +269,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
+			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.8.1

