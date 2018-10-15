From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] omap2-mcspi: Add slave mode support
Date: Mon, 15 Oct 2018 12:08:26 +0530
Message-ID: <20181015063829.26978-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

This series add slave mode support for TI's McSPI controller.

Slave mode tested on Beagle Bone Black with SPI0 in master mode
connected to SPI1 in slave mode. Tested with slave-time,
slave-system-control and spidev as slave clients.

Master mode tested on AM335x ICEv2 with a SPI flash for regression.

Vignesh R (3):
  spi: omap2-mcspi: Switch to readl_poll_timeout()
  spi: omap2-mcspi: Set FIFO DMA trigger level to word length
  spi: omap2-mcspi: Add slave mode support

 drivers/spi/spi-omap2-mcspi.c | 177 +++++++++++++++++++++++++---------
 1 file changed, 131 insertions(+), 46 deletions(-)

-- 
2.19.1
