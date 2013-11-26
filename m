From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory mapped.
Date: Tue, 26 Nov 2013 13:05:08 +0530
Message-ID: <1385451313-1875-13-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Idea is to enable memory mapped by default at the end of the probe,
if the control reaches the "transfer" api, then the operation is
not a memory mapped one. Hence, we switch to Normal mode and at the
end of the "transfer" function. switch back to memory mapped mode.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d21d40d..ba95d64 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -415,6 +415,8 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	int status = 0, ret;
 	int frame_length;
 
+	disable_qspi_memory_mapped(qspi);
+
 	/* setup device control reg */
 	qspi->dc = 0;
 
@@ -460,6 +462,8 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
 
+	enable_qspi_memory_mapped(qspi);
+
 	return status;
 }
 
@@ -613,6 +617,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_master;
 
+	enable_qspi_memory_mapped(qspi);
+
 	return 0;
 
 free_master:
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
