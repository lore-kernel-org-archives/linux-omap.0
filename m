From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] OMAP4: SPI: Fix Driver Kconfig
Date: Fri, 14 May 2010 14:28:00 -0700
Message-ID: <20100514212800.25599.65298.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63279 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab0ENV2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:28:01 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>, Abraham Arce <x0066660@ti.com>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Change dependency to ARCH_OMAP2PLUS to allow systems based on
omap24xx, omap34xx or omap44xx

Cc: spi-devel-general@lists.sourceforge.net
Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/spi/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a191fa2..f950b63 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -180,10 +180,10 @@ config SPI_OMAP_UWIRE
 	  This hooks up to the MicroWire controller on OMAP1 chips.
 
 config SPI_OMAP24XX
-	tristate "McSPI driver for OMAP24xx/OMAP34xx"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
+	tristate "McSPI driver for OMAP"
+	depends on ARCH_OMAP2PLUS
 	help
-	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
+	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.
 
 config SPI_OMAP_100K

