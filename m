From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 06/10] drivers: mtd: m25p80: Add api to configure master register.
Date: Fri, 6 Dec 2013 19:54:47 +0530
Message-ID: <1386339891-32717-7-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50966 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486Ab3LFOZ4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Dec 2013 09:25:56 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

These can be used to fill information needed to configure
master controller registers.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
 instead of a u8 *val, use a struct (slave_info)  already defined 
 in the first patch of the series. This will allow us to add more
 parameters into the struct.

 drivers/mtd/devices/m25p80.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7dc2c14..b90c7e5 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -490,6 +490,24 @@ static inline int m25p80_dummy_cycles_read(struct m25p *flash)
 }
 
 /*
+ * This API can be used to transfer flash information to
+ * SPI controller which needs some of its registers to get
+ * configured on flash information.
+ */
+static void m25p80_fill_flash_information(struct m25p *flash)
+{
+	struct spi_device *spi = flash->spi;
+	struct spi_master *master = spi->master;
+
+	spi->info.read_opcode = flash->read_opcode;
+	spi->info.program_opcode = flash->program_opcode;
+	spi->info.addr_width = flash->addr_width;
+	spi->info.dummy_cycles = m25p80_dummy_cycles_read(flash);
+
+	master->configure_from_slave(flash->spi);
+}
+
+/*
  * Read an address range from the flash chip.  The address range
  * may be any size provided it is within the physical boundaries.
  */
-- 
1.7.1

