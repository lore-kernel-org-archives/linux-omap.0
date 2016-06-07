From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] spi: Add DMA support for ti-qspi
Date: Tue, 7 Jun 2016 13:48:08 +0530
Message-ID: <20160607081810.6640-1-vigneshr@ti.com>
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

v2: https://lkml.org/lkml/2016/4/25/187
v1: https://lkml.org/lkml/2016/4/4/855


Vignesh R (2):
  spi: Add DMA support for spi_flash_read()
  spi: spi-ti-qspi: Add DMA support for QSPI mmap read

 drivers/spi/spi-ti-qspi.c | 189 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi.c         |  14 ++++
 include/linux/spi/spi.h   |   4 +
 3 files changed, 194 insertions(+), 13 deletions(-)

-- 
2.8.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
