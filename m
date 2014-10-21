From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/5] ARM: OMAP2+: gpmc: Always enable A26-A11 for non NAND devices
Date: Tue, 21 Oct 2014 15:41:47 +0300
Message-ID: <1413895309-9152-4-git-send-email-rogerq@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45071 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402AbaJUMmB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 08:42:01 -0400
In-Reply-To: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>

Although RESET state of LIMITEDADDRESS bit in GPMC_CONFIG register
is 0 (i.e. A26-A11 enabled), faulty bootloaders might accidentally
set this bit. e.g. u-boot 2014.07 with CONFIG_NOR disabled.

Explicity disable LIMITEDADDRESS bit for non NAND devices so that
they can always work.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f5d9dd2..0ba95d3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -85,6 +85,8 @@
 #define GPMC_ECC_CTRL_ECCREG8		0x008
 #define GPMC_ECC_CTRL_ECCREG9		0x009
 
+#define GPMC_CONFIG_LIMITEDADDRESS		BIT(1)
+
 #define	GPMC_CONFIG2_CSEXTRADELAY		BIT(7)
 #define	GPMC_CONFIG3_ADVEXTRADELAY		BIT(7)
 #define	GPMC_CONFIG4_OEEXTRADELAY		BIT(7)
@@ -1501,6 +1503,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	struct resource res;
 	unsigned long base;
 	int ret, cs;
+	u32 val;
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%s has no 'reg' property\n",
@@ -1569,6 +1572,11 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 	}
 
+	/* Clear limited address i.e. enable A26-A11 */
+	val = gpmc_read_reg(GPMC_CONFIG);
+	val &= ~GPMC_CONFIG_LIMITEDADDRESS;
+	gpmc_write_reg(GPMC_CONFIG, val);
+
 no_timings:
 	if (of_platform_device_create(child, NULL, &pdev->dev))
 		return 0;
-- 
1.8.3.2

