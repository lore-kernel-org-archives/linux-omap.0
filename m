From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
Date: Tue, 23 Jul 2013 12:06:44 +0300
Message-ID: <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51447 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab3GWJHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 05:07:33 -0400
In-Reply-To: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Panda's DVI connector's DDC pins are connected to OMAP's third i2c bus.
With non-DT, the bus number was 3, and that is what is used in the
dss-common.c which contains the platform data for Panda's DVI.

However, with DT, the bus number is 2. As we now only have DT boot for
Panda, we have to change the bus number to make DVI EDID read
operational.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 393aeef..043e570 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -42,7 +42,7 @@
 
 /* Using generic display panel */
 static struct tfp410_platform_data omap4_dvi_panel = {
-	.i2c_bus_num		= 3,
+	.i2c_bus_num		= 2,
 	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 };
 
-- 
1.8.1.2

