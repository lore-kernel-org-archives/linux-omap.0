From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH] PM: Disable usb host HW save and restore
Date: Thu, 23 Apr 2009 13:58:51 +0300
Message-ID: <1240484331-18722-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:35704 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbZDWK6w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2009 06:58:52 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@deeprootsystems.com, paul@pwsan.com, linux-omap@vger.kernel.org, nm@ti.com, r-woodruff2@ti.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

The hardware SAVEANDRESTORE mechanism seems to leave
USB HOST power domain permanently into active state
after one transition from off to active state.
Disabling for now.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/powerdomains34xx.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 4dcf94b..aa557b2 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -338,7 +338,13 @@ static struct powerdomain usbhost_pwrdm = {
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
-	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBHOST ctrlr only */
+	/*
+	 * REVISIT: Enabling usb host save and restore mechanism seems to
+	 * leave the usb host domain permanently in ACTIVE mode after
+	 * changing the usb host power domain state from OFF to active once.
+	 * Disabling for now.
+	 */
+	/*.flags	  = PWRDM_HAS_HDWR_SAR,*/ /* for USBHOST ctrlr only */
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */
-- 
1.5.4.3

