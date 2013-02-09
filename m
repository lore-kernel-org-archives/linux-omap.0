From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH RFC 5/7] ARM: OMAP: gpmc: add support for gpmc-smsc911x child nodes
Date: Sat,  9 Feb 2013 21:44:29 +0100
Message-ID: <1360442671-15216-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40091 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab3BIUpC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 15:45:02 -0500
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Besides being used to interface with external memory devices,
the General-Purpose Memory Controller can be used to connect
Pseudo-SRAM devices to the OMAP processor that use the GPMC
as a data bus. One of these devices is the smsc911x LAN chip.

This patch allows an smsc911x LAN pheripheral to be defined
as an GPMC child node an call its corresponding setup function.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f55b504..fd22c62 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -40,6 +40,7 @@
 #include "gpmc.h"
 #include "gpmc-nand.h"
 #include "gpmc-onenand.h"
+#include "gpmc-smsc911x.h"
 
 #define	DEVICE_NAME		"omap-gpmc"
 
@@ -1320,6 +1321,14 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			return ret;
 		}
 	}
+
+	for_each_node_by_name(child, "gpmc_smsc911x") {
+		ret = gpmc_smsc911x_init_dt(child);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+	}
 	return 0;
 }
 #else
-- 
1.7.7.6

