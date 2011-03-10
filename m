From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/2] OMAP3: wdtimer: Fix CORE idle transition
Date: Thu, 10 Mar 2011 14:10:58 +0200
Message-ID: <1299759058-26342-3-git-send-email-kalle.jokiniemi@nokia.com>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:31036 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab1CJMMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 07:12:51 -0500
In-Reply-To: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org, wim@iguana.be, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com
Cc: jhnikula@gmail.com, ilkka.koskinen@nokia.com, Paul Walmsley <paul@pwsan.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Benoit Cousson <b-cousson@ti.com>

From: Paul Walmsley <paul@pwsan.com>

The HW superwised smart idle for wdtimer in OMAP3 prevents
CORE power domain idle transitions. Disable it by swithing
to SW supervised transitions.

This could be a hardware bug in the OMAP3 wdtimer2 block.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 196a834..ebd3309 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1293,6 +1293,11 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 	.slaves		= omap3xxx_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	/*
+	 * XXX: Use software supervised mode, HW supervised smartidle seems to
+	 * block CORE power domain idle transitions. Maybe a HW bug in wdt2?
+	 */
+	.flags		= HWMOD_SWSUP_SIDLE,
 };
 
 /* UART common */
-- 
1.7.1

