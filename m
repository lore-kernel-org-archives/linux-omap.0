From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 3/7] OMAP: mailbox: use OMAP's naming convention for devices
Date: Fri, 24 Jun 2011 20:17:39 -0500
Message-ID: <1308964663-5669-4-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47591 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232Ab1FYBSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 21:18:15 -0400
Received: by gwb17 with SMTP id 17so2122539gwb.15
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 18:18:14 -0700 (PDT)
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Use "omap_XXX" as the OMAP device naming convention.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap1/mailbox.c |    2 +-
 arch/arm/mach-omap2/devices.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index c0e1f48..2845652 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -175,7 +175,7 @@ static struct platform_driver omap1_mbox_driver = {
 	.probe	= omap1_mbox_probe,
 	.remove	= __devexit_p(omap1_mbox_remove),
 	.driver	= {
-		.name	= "omap-mailbox",
+		.name	= "omap_mailbox",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e1110f2..779b2f3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -287,7 +287,7 @@ static inline void omap_init_mbox(void)
 	mb_attr = oh->dev_attr;
 	pdata.nr_mbox = mb_attr->nr_mbox;
 
-	od = omap_device_build("omap-mailbox", -1, oh, &pdata, sizeof(pdata),
+	od = omap_device_build("omap_mailbox", -1, oh, &pdata, sizeof(pdata),
 				mbox_latencies, ARRAY_SIZE(mbox_latencies), 0);
 	WARN(IS_ERR(od), "%s: could not build device, err %ld\n",
 						__func__, PTR_ERR(od));
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 86d564a..946a70a 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -397,7 +397,7 @@ static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
 	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
-		.name = "omap-mailbox",
+		.name = "omap_mailbox",
 	},
 };
 
-- 
1.7.0.4

