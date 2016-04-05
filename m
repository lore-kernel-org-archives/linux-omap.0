From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] spi: Add DMA support for ti-qspi
Date: Tue, 5 Apr 2016 09:19:50 +0530
Message-ID: <1459828192-5531-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org



This series adds support for DMA during QSPI flash read via memory
mapped mode.

Tested on DRA74 EVM on linux-next with patch for mtd support[1] applied.
Also tested with series[2] from Boris refractoring spi_map_buf().
[1]http://lists.infradead.org/pipermail/linux-mtd/2016-March/066335.html
[2]http://www.spinics.net/lists/linux-mm/msg104694.html



Vignesh R (2):
  spi: Add DMA support for spi_flash_read()
  spi: spi-ti-qspi: Add DMA support for QSPI mmap read

 drivers/spi/spi-ti-qspi.c | 132 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi.c         |  15 ++++++
 include/linux/spi/spi.h   |   2 +
 3 files changed, 137 insertions(+), 12 deletions(-)

-- 
2.8.0
