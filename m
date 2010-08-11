From: Charulatha V <charu@ti.com>
Subject: [PATCH 5/6 v2] OMAP4: WDT: Enable watchdog timer2 hwmod structure
Date: Wed, 11 Aug 2010 15:41:10 +0530
Message-ID: <1281521471-15802-6-git-send-email-charu@ti.com>
References: <1281521471-15802-1-git-send-email-charu@ti.com>
 <1281521471-15802-2-git-send-email-charu@ti.com>
 <1281521471-15802-3-git-send-email-charu@ti.com>
 <1281521471-15802-4-git-send-email-charu@ti.com>
 <1281521471-15802-5-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49976 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758070Ab0HKKIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:08:38 -0400
In-Reply-To: <1281521471-15802-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

This patch enables the watchdog timer2 hwmod structure

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9736a49..929d458 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5789,7 +5789,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* usb_tll_hs class */
 /*	&omap44xx_usb_tll_hs_hwmod, */
 	/* wd_timer class */
-/*	&omap44xx_wd_timer2_hwmod, */
+	&omap44xx_wd_timer2_hwmod,
 /*	&omap44xx_wd_timer3_hwmod, */
 	NULL,
 };
-- 
1.6.3.3

