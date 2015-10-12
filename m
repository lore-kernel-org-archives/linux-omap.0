From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] spi: ti-qspi: Fix data corruption seen on r/w stress test
Date: Mon, 12 Oct 2015 13:22:02 +0530
Message-ID: <1444636322-6772-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Writing invalid command to QSPI_SPI_CMD_REG will terminate current
transfer and de-assert the chip select. This has to be done before
calling spi_finalize_current_message(). Because
spi_finalize_current_message() will mark the end of current message
transfer and schedule the next transfer. If the chipselect is not
de-asserted before calling spi_finalize_current_message() then the next
transfer will overlap with the previous transfer leading to data
corruption.
__spi_pump_message() can be called either from kthread worker context or
directly from the calling process's context. It is possible that these
two calls can race against each other. But race is serialized by
checking whether master->cur_msg == NULL (pointer to msg being handled
by transfer_one() at present). The master->cur_msg is set to NULL when
spi_finalize_current_message() is called on that message, which means
calling spi_finalize_current_message() allows __spi_sync() to pump next
message in calling process context.
Now if spi-ti-qspi calls spi_finalize_current_message() before we
terminate transfer at hardware side, if __spi_pump_message() is called
from process context then the successive transactions can overlap.

Fix this by moving writing invalid command to QSPI_SPI_CMD_REG to
before calling spi_finalize_current_message() call.

Cc: stable@vger.kernel.org # v3.12+
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index aa6d284131e0..81b84858cfee 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -410,11 +410,10 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	mutex_unlock(&qspi->list_lock);
 
+	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
 	m->status = status;
 	spi_finalize_current_message(master);
 
-	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
-
 	return status;
 }
 
-- 
2.6.1
