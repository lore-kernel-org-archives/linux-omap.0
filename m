From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 6/9] ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset status bit
Date: Fri, 18 Jan 2013 12:49:26 +0530
Message-ID: <1358493569-17142-7-git-send-email-vaibhav.bedia@ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab3ARHTw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 02:19:52 -0500
In-Reply-To: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
Update the WKUP-M3 hwmod data to reflect the same.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
Change from RFC version:
	No change

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 34a67e4..78929a4 100644
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
1.7.0.4

