From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] spi: spi-omap2-mcspi: Add DMA support for AM65x
Date: Tue, 4 Feb 2020 18:18:14 +0530
Message-ID: <20200204124816.16735-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds DMA support for McSPI on AM65x.
First patch addresses a limitationn on AM65x where transfers have to be
<4K per DMA request and second patch handles possible EPROBE_DEFER when
requesting DMA channels

Vignesh Raghavendra (2):
  spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x
  spi: spi-omap2-mcspi: Support probe deferral for DMA channels

 drivers/spi/spi-omap2-mcspi.c                 | 103 +++++++++++-------
 include/linux/platform_data/spi-omap2-mcspi.h |   1 +
 2 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.25.0
