From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ti-qspi: fix warning" to the spi tree
Date: Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
Message-ID: <applied-20200115100700.3357-1-jean.pihet@newoldbits.com>
References: <20200115100700.3357-1-jean.pihet@newoldbits.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54166 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbgAQPof (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2020 10:44:35 -0500
In-Reply-To: <20200115100700.3357-1-jean.pihet@newoldbits.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>, Conrad Ratschan <conrad.ratschan@rockwellcollins.com>, linux-omap@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Ryan Barnett <ryan.barnett@rockwellcollins.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Vignesh Raghavendra <vigneshr@ti.com>

The patch

   spi: spi-ti-qspi: fix warning

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

>From 6925212f328bf2abde0c8f0d037fddd36751d489 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Wed, 15 Jan 2020 11:07:00 +0100
Subject: [PATCH] spi: spi-ti-qspi: fix warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Link: https://lore.kernel.org/r/20200115100700.3357-1-jean.pihet@newoldbits.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
