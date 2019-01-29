From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] spi: ti-qspi: Fix mmap read when more than one CS in use
Date: Tue, 29 Jan 2019 13:14:22 +0530
Message-ID: <20190129074422.10025-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support") has
has got order of parameter wrong when calling regmap_update_bits() to
select CS for mmap access. Mask and value arguments are interchanged.
Code will work on a system with single slave, but fails when more than
one CS is in use. Fix this by correcting the order of parameters when
calling regmap_update_bits().

Fixes: 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 5f19016bbf10..b9fb6493cd6b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -490,8 +490,8 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
 	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base) {
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-				   MEM_CS_EN(spi->chip_select),
-				   MEM_CS_MASK);
+				   MEM_CS_MASK,
+				   MEM_CS_EN(spi->chip_select));
 	}
 	qspi->mmap_enabled = true;
 }
@@ -503,7 +503,7 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
 	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base)
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-				   0, MEM_CS_MASK);
+				   MEM_CS_MASK, 0);
 	qspi->mmap_enabled = false;
 }
 
-- 
2.20.1
