From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] spi: spi-ti-qspi: fix warning
Date: Wed, 15 Jan 2020 11:07:00 +0100
Message-ID: <20200115100700.3357-1-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41314 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgAOKHM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2020 05:07:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so15118992wrw.8
        for <linux-omap@vger.kernel.org>; Wed, 15 Jan 2020 02:07:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, linux-omap@vger.kernel.org, linux-spi@vger.kernel.org, Ryan Barnett <ryan.barnett@rockwellcollins.com>, Conrad Ratschan <conrad.ratschan@rockwellcollins.com>, Arnout Vandecappelle <arnout.vandecappelle@essensium.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Jean Pihet <jean.pihet@newoldbits.com>

drivers/spi/spi-ti-qspi.c: In function ‘ti_qspi_start_transfer_one’:
drivers/spi/spi-ti-qspi.c:392:8: warning: ‘rx_wlen’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  392 |     if (rx_wlen >= 32)
      |        ^
drivers/spi/spi-ti-qspi.c:318:12: note: ‘rx_wlen’ was declared here
  318 |  u8 rxlen, rx_wlen;
      |            ^~~~~~~

The warning is a false positive; it is not thrown by all compiler versions, e.g.
Red Hat Cross 9.2.1-1 but not Linaro GCC 7.5-2019.12.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 858fda8ac73e..366a3e5cca6b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -332,6 +332,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 		break;
 	}
 	wlen = t->bits_per_word >> 3;	/* in bytes */
+	rx_wlen = wlen;
 
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
-- 
2.24.1
