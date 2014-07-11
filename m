From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 08/10] ARM: OMAP2: hwmod_data: Remove legacy mailbox data and addrs
Date: Fri, 11 Jul 2014 16:44:41 -0500
Message-ID: <1405115083-52977-9-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51016 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaGKVp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jul 2014 17:45:59 -0400
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

OMAP2 devices are devicetree boot only, and the legacy mode
of mailbox device creation should no longer be used, so remove
the mailbox attribute data and the hwmod addr space used for
creating mailboxes in legacy mode.

Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c                 | 14 --------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c                 | 13 -------------
 .../mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c    |  9 ---------
 arch/arm/mach-omap2/omap_hwmod_common_data.h               |  1 -
 4 files changed, 37 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2f15979..65b1647 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -16,7 +16,6 @@
 #include <linux/i2c-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <linux/platform_data/mailbox-omap.h>
 #include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
@@ -163,18 +162,6 @@ static struct omap_hwmod omap2420_dma_system_hwmod = {
 };
 
 /* mailbox */
-static struct omap_mbox_dev_info omap2420_mailbox_info[] = {
-	{ .name = "dsp", .tx_id = 0, .rx_id = 1, .irq_id = 0, .usr_id = 0 },
-	{ .name = "iva", .tx_id = 2, .rx_id = 3, .irq_id = 1, .usr_id = 3 },
-};
-
-static struct omap_mbox_pdata omap2420_mailbox_attrs = {
-	.num_users	= 4,
-	.num_fifos	= 6,
-	.info_cnt	= ARRAY_SIZE(omap2420_mailbox_info),
-	.info		= omap2420_mailbox_info,
-};
-
 static struct omap_hwmod omap2420_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap2xxx_mailbox_hwmod_class,
@@ -188,7 +175,6 @@ static struct omap_hwmod omap2420_mailbox_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
 		},
 	},
-	.dev_attr	= &omap2420_mailbox_attrs,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 6d1b609..c2555cb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -17,7 +17,6 @@
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/omap-dma.h>
-#include <linux/platform_data/mailbox-omap.h>
 #include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
@@ -161,17 +160,6 @@ static struct omap_hwmod omap2430_dma_system_hwmod = {
 };
 
 /* mailbox */
-static struct omap_mbox_dev_info omap2430_mailbox_info[] = {
-	{ .name = "dsp", .tx_id = 0, .rx_id = 1 },
-};
-
-static struct omap_mbox_pdata omap2430_mailbox_attrs = {
-	.num_users	= 4,
-	.num_fifos	= 6,
-	.info_cnt	= ARRAY_SIZE(omap2430_mailbox_info),
-	.info		= omap2430_mailbox_info,
-};
-
 static struct omap_hwmod omap2430_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap2xxx_mailbox_hwmod_class,
@@ -185,7 +173,6 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
 		},
 	},
-	.dev_attr	= &omap2430_mailbox_attrs,
 };
 
 /* mcspi3 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
index 0413dab..c1e98d5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
@@ -152,15 +152,6 @@ struct omap_hwmod_addr_space omap2_dma_system_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x48094000,
-		.pa_end		= 0x48094000 + SZ_512 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_addr_space omap2_mcbsp1_addrs[] = {
 	{
 		.name		= "mpu",
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 2c38c6b..11ed5a1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -33,7 +33,6 @@ extern struct omap_hwmod_addr_space omap2_mcspi1_addr_space[];
 extern struct omap_hwmod_addr_space omap2_mcspi2_addr_space[];
 extern struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[];
 extern struct omap_hwmod_addr_space omap2_dma_system_addrs[];
-extern struct omap_hwmod_addr_space omap2_mailbox_addrs[];
 extern struct omap_hwmod_addr_space omap2_mcbsp1_addrs[];
 extern struct omap_hwmod_addr_space omap2_hdq1w_addr_space[];
 
-- 
2.0.0

