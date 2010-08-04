From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] omap: 3630: disable TLL SAR on 3630 ES1
Date: Wed, 04 Aug 2010 14:33:12 +0300
Message-ID: <20100804113312.25027.93983.stgit@baageli.muru.com>
References: <20100804112916.25027.94640.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61256 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab0HDLco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 07:32:44 -0400
In-Reply-To: <20100804112916.25027.94640.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

USBTLL Save-and-Restore is broken in 3630 ES1.0. Having it
enabled could result in incorrect register restores as
the OMAP exits off-mode. This could potentially result in
unexpected wakeup events.

(Refer 3630 errata ID i579)

This is fixed in ES1.1. So disable it for ES1.0s.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/powerdomains34xx.h |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index bd87112..fa90486 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -75,12 +75,19 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	},
 };
 
+/*
+ * The USBTLL Save-and-Restore mechanism is broken on
+ * 3430s upto ES3.0 and 3630ES1.0. Hence this feature
+ * needs to be disabled on these chips.
+ * Refer: 3430 errata ID i459 and 3630 errata ID i579
+ */
 static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
 					   CHIP_IS_OMAP3430ES2 |
-					   CHIP_IS_OMAP3430ES3_0),
+					   CHIP_IS_OMAP3430ES3_0 |
+					   CHIP_IS_OMAP3630ES1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -97,7 +104,8 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
+					  CHIP_GE_OMAP3630ES1_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */

