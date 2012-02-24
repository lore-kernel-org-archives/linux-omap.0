From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: OMAP2+: Fix OMAP_HDQ_BASE build error
Date: Thu, 23 Feb 2012 16:54:07 -0800
Message-ID: <20120224005406.16794.76522.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63299 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2BXAyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:08 -0500
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

If CONFIG_SOC_OMAP3430 is not set and CONFIG_HDQ_MASTER_OMAP
is selected for w1 driver we get the following error:

arch/arm/mach-omap2/devices.c:662:13: error:
'OMAP_HDQ_BASE' undeclared here (not in a function)

Looks like OMAP_HDQ_BASE is valid for all omaps except
2420, so we can remove the ifdef and not register
the device on 2420.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..3ffefe2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -654,9 +654,7 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
-#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430)
 #define OMAP_HDQ_BASE	0x480B2000
-#endif
 static struct resource omap_hdq_resources[] = {
 	{
 		.start		= OMAP_HDQ_BASE,
@@ -679,7 +677,10 @@ static struct platform_device omap_hdq_dev = {
 };
 static inline void omap_hdq_init(void)
 {
-	(void) platform_device_register(&omap_hdq_dev);
+	if (cpu_is_omap2420())
+		return;
+
+	platform_device_register(&omap_hdq_dev);
 }
 #else
 static inline void omap_hdq_init(void) {}

