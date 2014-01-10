From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: AM43x: hwmod data: register spinlock OCP interface
Date: Fri, 10 Jan 2014 17:44:24 -0600
Message-ID: <1389397464-13345-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56454 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbaAJXod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jan 2014 18:44:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Suman Anna <s-anna@ti.com>

AM43xx has a spinlock module which is identical to the
one present on AM33xx. Register the spinlock ocp_if link
so that the spinlock hwmod and associated omap_device can
be instantiated, and the runtime pm API could be used by
the OMAP hwspinlock driver.

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 9002fca..5c2cc80 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -719,6 +719,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_ls__uart4,
 	&am33xx_l4_ls__uart5,
 	&am33xx_l4_ls__uart6,
+	&am33xx_l4_ls__spinlock,
 	&am33xx_l4_ls__elm,
 	&am33xx_l4_ls__epwmss0,
 	&am33xx_epwmss0__ecap0,
-- 
1.8.4.3

