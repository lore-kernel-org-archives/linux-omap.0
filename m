From: Charulatha V <charu@ti.com>
Subject: [PATCH 5/6] OMAP4: WDT: Enable watchdog timer2 hwmod structure
Date: Sat, 22 May 2010 18:26:05 +0530
Message-ID: <1274532966-19916-6-git-send-email-charu@ti.com>
References: <1274532966-19916-1-git-send-email-charu@ti.com>
 <1274532966-19916-2-git-send-email-charu@ti.com>
 <1274532966-19916-3-git-send-email-charu@ti.com>
 <1274532966-19916-4-git-send-email-charu@ti.com>
 <1274532966-19916-5-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48447 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab0EVMyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 08:54:33 -0400
In-Reply-To: <1274532966-19916-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, rnayak@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

This patch enables the watchdog timer2 hwmod structure

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 20f5f8c..87ff332 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4888,7 +4888,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
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

