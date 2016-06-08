From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 0/2] spi: Add DMA support for ti-qspi
Date: Wed, 8 Jun 2016 12:18:30 +0530
Message-ID: <20160608064832.18496-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org


This series adds support for DMA during QSPI flash read using memory
mapped mode.

Tested on DRA74 EVM, DRA72 EVM and AM437x SK on linux-next.

v3: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1160792.html
v2: https://lkml.org/lkml/2016/4/25/187
v1: https://lkml.org/lkml/2016/4/4/855


Vignesh R (2):
  spi: Add DMA support for spi_flash_read()
  spi: spi-ti-qspi: Add DMA support for QSPI mmap read

 drivers/spi/spi-ti-qspi.c | 188 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi.c         |  28 +++++++
 include/linux/spi/spi.h   |   4 +
 3 files changed, 207 insertions(+), 13 deletions(-)

-- 
2.8.3
