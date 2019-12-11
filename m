From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] spi: spi-ti-qspi: Fix a bug when accessing non default CS
Date: Wed, 11 Dec 2019 21:22:16 +0530
Message-ID: <20191211155216.30212-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, dannenberg@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When switching ChipSelect from default CS0 to any other CS, driver fails
to update the bits in system control module register that control which
CS is mapped for MMIO access. This causes reads to fail when driver
tries to access QSPI flash on CS1/2/3.

Fix this by updating appropriate bits whenever active CS changes.

Reported-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 3cb65371ae3b..66dcb6128539 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -62,6 +62,7 @@ struct ti_qspi {
 	u32 dc;
 
 	bool mmap_enabled;
+	int current_cs;
 };
 
 #define QSPI_PID			(0x0)
@@ -487,6 +488,7 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
 				   MEM_CS_EN(spi->chip_select));
 	}
 	qspi->mmap_enabled = true;
+	qspi->current_cs = spi->chip_select;
 }
 
 static void ti_qspi_disable_memory_map(struct spi_device *spi)
@@ -498,6 +500,7 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
 				   MEM_CS_MASK, 0);
 	qspi->mmap_enabled = false;
+	qspi->current_cs = -1;
 }
 
 static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
@@ -543,7 +546,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 	mutex_lock(&qspi->list_lock);
 
-	if (!qspi->mmap_enabled)
+	if (!qspi->mmap_enabled || qspi->current_cs != mem->spi->chip_select)
 		ti_qspi_enable_memory_map(mem->spi);
 	ti_qspi_setup_mmap_read(mem->spi, op->cmd.opcode, op->data.buswidth,
 				op->addr.nbytes, op->dummy.nbytes);
@@ -799,6 +802,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		}
 	}
 	qspi->mmap_enabled = false;
+	qspi->current_cs = -1;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (!ret)
-- 
2.24.0
