From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 0/2] spi: Add DMA support for ti-qspi
Date: Wed, 17 Aug 2016 15:22:35 +0530
Message-ID: <20160817095237.13101-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


This series adds support for DMA during QSPI flash read using memory
mapped mode.

Tested on DRA74 EVM, DRA72 EVM and AM437x SK on linux-next.

Vignesh R (2):
  spi: Add support to handle kmap'd buffers in spi_map_buf()
  spi: spi-ti-qspi: Add DMA support for QSPI mmap read

 drivers/spi/spi-ti-qspi.c | 139 ++++++++++++++++++++++++++++++++++++++++------
 drivers/spi/spi.c         |  17 +++++-
 2 files changed, 136 insertions(+), 20 deletions(-)

-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
