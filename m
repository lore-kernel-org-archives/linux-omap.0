From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/2] spi-ti-qspi: Handle vmalloc'd buffers
Date: Tue, 11 Apr 2017 17:22:23 +0530
Message-ID: <20170411115225.31709-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

First patch, adds can_dma() like interface for spi_flash_read()
interface,
this will enable controller drivers to selectively use DMA based on
buffer type, alignment, size or other limitations.
Second patch implements bounce buffer support for ti-qspi driver to
handle buffers that are not DMA'able, like vmalloc'd buffers that belong
to LPAE region. This is required to work with UBIFS.

Vignesh R (2):
  spi: Add can_dma like interface for spi_flash_read
  spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble

 drivers/spi/spi-ti-qspi.c | 66 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi.c         |  2 +-
 include/linux/spi/spi.h   |  4 +++
 3 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.11.0
