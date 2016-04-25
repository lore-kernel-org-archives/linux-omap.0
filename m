From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/3] spi: Add DMA support for ti-qspi
Date: Mon, 25 Apr 2016 15:13:59 +0530
Message-ID: <1461577442-8853-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org



This series adds support for DMA during QSPI flash read via memory
mapped mode.
The first patch adds a check to spi_map_buf() API to return error when
kmap'd buffers are passed for DMA mapping. Second patch adds support for
using DMA on top of spi_flash_read() API using  DMA sg_table mapping
support in SPI core. Third map adds DMA support for TI QSPI in memory
mapped read mode.

Tested on DRA74 EVM and DRA72 EVM on linux-next.

v1: https://lkml.org/lkml/2016/4/4/855



Vignesh R (3):
  spi: return error if kmap'd buffers passed to spi_map_buf()
  spi: Add DMA support for spi_flash_read()
  spi: spi-ti-qspi: Add DMA support for QSPI mmap read

 drivers/spi/spi-ti-qspi.c | 196 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi.c         |  18 ++++-
 include/linux/spi/spi.h   |   4 +
 3 files changed, 204 insertions(+), 14 deletions(-)

-- 
2.8.1
