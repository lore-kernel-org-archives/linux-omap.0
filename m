From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 2/7] OMAP2+: devices: get the number of supported mailboxes
Date: Fri, 24 Jun 2011 20:17:38 -0500
Message-ID: <1308964663-5669-3-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35237 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753163Ab1FYBSN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 21:18:13 -0400
Received: by mail-yx0-f173.google.com with SMTP id 7so1688341yxs.4
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 18:18:13 -0700 (PDT)
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Use hwmod data attributes to get the defined number of mailboxes on
our current chip, and pass it through platform data.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/devices.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b8ca68..e1110f2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,6 +25,7 @@
 
 #include <plat/tc.h>
 #include <plat/board.h>
+#include <plat/mailbox.h>
 #include <plat/mcbsp.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
@@ -274,6 +275,8 @@ static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
 	struct omap_device *od;
+	struct omap_mailbox_dev_attr *mb_attr;
+	struct omap_mailbox_platform_data pdata;
 
 	oh = omap_hwmod_lookup("mailbox");
 	if (!oh) {
@@ -281,7 +284,10 @@ static inline void omap_init_mbox(void)
 		return;
 	}
 
-	od = omap_device_build("omap-mailbox", -1, oh, NULL, 0,
+	mb_attr = oh->dev_attr;
+	pdata.nr_mbox = mb_attr->nr_mbox;
+
+	od = omap_device_build("omap-mailbox", -1, oh, &pdata, sizeof(pdata),
 				mbox_latencies, ARRAY_SIZE(mbox_latencies), 0);
 	WARN(IS_ERR(od), "%s: could not build device, err %ld\n",
 						__func__, PTR_ERR(od));
-- 
1.7.0.4

