From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 0/5] Add memory mapped read support for TI QSPI.
Date: Tue, 28 Jul 2015 14:11:11 +0530
Message-ID: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


This patch series adds support for memory mapped reads for TI QSPI
driver.

TI QSPI controller has memory mapped port (SFI translator interface [1])
through which SPI flash memories can be read using memcpy call. SFI
translator takes care of generating appropriate SPI signals to read data
from flash. This interface works only with SPI flash memories and cannot
be used with other SPI devices. To use memory mapped port, the
controller is switched to memory mapped interface by writing to
QSPI_SPI_SWITCH_REG. The read_opcode, read mode, dummy bytes are set in
QSPI_SPI_SETUPx_REG. Once switched, the SPI flash is available to SoC to
read at specific address. This interface is disabled once memory mapped
read is complete. For write, erase and interaction with non-flash SPI
devices normal SPI interface is used. 

The m25p80 driver sets use_mmap_read flag in spi-message struct passed
to spi-ti-qspi so as to indicate the read request is from mtd layer.
spi-ti-qspi driver switches to memory mapped mode and does memcpy based
on use_mmap_read flag.

The read performace increased from ~100kB/s to ~2.5MB/s on DRA74 EVM.

Tested on DRA74 EVM with spansion S25FL256S flash.
Tested on AM437x sk evm with macronix MX66l51235l flash.

[1] http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf Section 24.5.4 QSPI
Functional Description

Vignesh R (5):
  spi: introduce flag for memory mapped read
  spi: spi-ti-qspi: Add memory mapped read support
  mtd: devices: m25p80: set flag to request memory mapped read
  ARM: dts: DRA7: Add memory map region entries for qspi
  ARM: dts: AM4372: Add memory map region entries for qspi

 arch/arm/boot/dts/am4372.dtsi |   4 +-
 arch/arm/boot/dts/dra7.dtsi   |   6 +-
 drivers/mtd/devices/m25p80.c  |   3 +
 drivers/spi/spi-ti-qspi.c     | 129 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/spi/spi.h       |   3 +
 5 files changed, 138 insertions(+), 7 deletions(-)

-- 
2.4.6
