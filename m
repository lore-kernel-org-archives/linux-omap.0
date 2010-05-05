From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH v2 1/3] OMAP4: SPI: Fix Driver Kconfig
Date: Wed, 5 May 2010 02:09:52 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756649Ab0EEHKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 03:10:00 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Add OMAP4 data to allow McSPI driver built

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Shubhro <a0393217@ti.com>
Signed-off-by: Santosh Shilimkar <santosh shilimkar@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
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
-- 
1.5.4.3

