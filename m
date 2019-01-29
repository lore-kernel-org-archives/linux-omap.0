From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: ti-qspi: Fix mmap read when more than one CS in use" to the spi tree
Date: Tue, 29 Jan 2019 12:14:22 +0000 (GMT)
Message-ID: <20190129121422.0C02F1127D50@debutante.sirena.org.uk>
References: <20190129074422.10025-1-vigneshr@ti.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190129074422.10025-1-vigneshr@ti.com>
Sender: stable-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: stable@vger.kernel.org, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.orglinux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: ti-qspi: Fix mmap read when more than one CS in use

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 673c865efbdc5fec3cc525c46d71844d42c60072 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Tue, 29 Jan 2019 13:14:22 +0530
Subject: [PATCH] spi: ti-qspi: Fix mmap read when more than one CS in use

Commit 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support") has
has got order of parameter wrong when calling regmap_update_bits() to
select CS for mmap access. Mask and value arguments are interchanged.
Code will work on a system with single slave, but fails when more than
one CS is in use. Fix this by correcting the order of parameters when
calling regmap_update_bits().

Fixes: 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
