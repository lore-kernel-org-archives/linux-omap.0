From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] spi-ti-qspi: Handle vmalloc'd buffers
Date: Fri, 31 Mar 2017 17:19:48 +0530
Message-ID: <20170331114950.21489-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

First patch, adds can_dma() like interface for spi_flash_read() interface,
this will enable controller drivers to selectively use DMA based on
buffer type, alignment, size or other limitations.
Second patch implements bounce buffer support for ti-qspi driver to
handle buffers that are not DMA'able, like vmalloc'd buffers that belong
to LPAE region. This is required to work with UBIFS 

Vignesh R (2):
  spi: Add can_dma like interface for spi_flash_read
  spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble

 drivers/spi/spi-ti-qspi.c | 64 +++++++++++++++++++++++++++++++++++++++++------
 drivers/spi/spi.c         |  2 +-
 include/linux/spi/spi.h   |  4 +++
 3 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
