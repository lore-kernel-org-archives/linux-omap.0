From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ti-qspi: support large flash devices" to the spi tree
Date: Tue, 14 Jan 2020 16:09:25 +0000 (GMT)
Message-ID: <applied-20200114124125.361429-2-jean.pihet@newoldbits.com>
References: <20200114124125.361429-2-jean.pihet@newoldbits.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgANQJd (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2020 11:09:33 -0500
In-Reply-To: <20200114124125.361429-2-jean.pihet@newoldbits.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>, Conrad Ratschan <conrad.ratschan@rockwellcollins.com>, linux-omap@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Ryan Barnett <ryan.barnett@rockwellcollins.com>, Tony Lindgren <tony@atomide.com>, Vignesh Raghavendra <vigneshr@ti.com>

The patch

   spi: spi-ti-qspi: support large flash devices

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From e97f491450805fe6cbfd482b97b5427b21dec575 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Tue, 14 Jan 2020 13:41:24 +0100
Subject: [PATCH] spi: spi-ti-qspi: support large flash devices

The TI QSPI IP has limitations:
- the MMIO region is 64MB in size
- in non-MMIO mode, the transfer can handle 4096 words max.

Add support for bigger devices.
Use MMIO and DMA transfers below the 64MB boundary, use
software generated transfers above.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ryan Barnett <ryan.barnett@rockwellcollins.com>
Cc: Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Link: https://lore.kernel.org/r/20200114124125.361429-2-jean.pihet@newoldbits.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ad2942b3d0a9..0334e2926998 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -525,6 +525,35 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
 
+static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	size_t max_len;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (op->addr.val < qspi->mmap_size) {
+			/* Limit MMIO to the mmaped region */
+			if (op->addr.val + op->data.nbytes > qspi->mmap_size) {
+				max_len = qspi->mmap_size - op->addr.val;
+				op->data.nbytes = min((size_t) op->data.nbytes,
+						      max_len);
+			}
+		} else {
+			/*
+			 * Use fallback mode (SW generated transfers) above the
+			 * mmaped region.
+			 * Adjust size to comply with the QSPI max frame length.
+			 */
+			max_len = QSPI_FRAME;
+			max_len -= 1 + op->addr.nbytes + op->dummy.nbytes;
+			op->data.nbytes = min((size_t) op->data.nbytes,
+					      max_len);
+		}
+	}
+
+	return 0;
+}
+
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -575,6 +604,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.exec_op = ti_qspi_exec_mem_op,
+	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
 static int ti_qspi_start_transfer_one(struct spi_master *master,
-- 
2.20.1
