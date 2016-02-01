From: Vignesh R <vigneshr@ti.com>
Subject: [RESEND][PATCH v5 0/3] Add memory mapped read support for ti-qspi
Date: Mon, 1 Feb 2016 12:14:22 +0530
Message-ID: <1454309065-11493-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, hramrach@gmail.com, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Resend v5:
Rebased on top of v4.5-rc1

Changes since v4:
Use syscon to access system control module register in ti-qspi driver.

Changes since v3:
Rework to introduce spi_flash_read_message struct.
Support different opcode/addr/data formats as per Brian's suggestion
here: https://lkml.org/lkml/2015/11/11/454

Changes since v2:
Remove mmap_lock_mutex.
Optimize enable/disable of mmap mode.

Changes since v1:
Introduce API in SPI core that MTD flash driver can call for mmap read
instead of directly calling spi-master driver callback. This API makes
sure that SPI core msg queue is locked during mmap transfers.
v1: https://lkml.org/lkml/2015/9/4/103


Cover letter:

This patch series adds support for memory mapped read port of ti-qspi.
ti-qspi has a special memory mapped port through which SPI flash
memories can be accessed directly via SoC specific memory region.

First patch adds a method to pass flash specific information like read
opcode, dummy bytes etc and to request mmap read. Second patch
implements mmap read method in ti-qspi driver. Patch 3 adapts m25p80 to
use mmap read method before trying normal SPI transfer. Patch 4 and 5
add memory map region DT entries for DRA7xx and AM43xx SoCs.

This patch series is based on the discussions here:
http://www.spinics.net/lists/linux-spi/msg04796.html

Tested on DRA74 EVM and AM437x-SK.
Read performance increases from ~100kB/s to ~2.5MB/s.

Vignesh R (3):
  spi: introduce accelerated read support for spi flash devices
  spi: spi-ti-qspi: add mmap mode read support
  mtd: devices: m25p80: add support for mmap read request

 drivers/mtd/devices/m25p80.c |  20 +++++++
 drivers/spi/spi-ti-qspi.c    | 139 ++++++++++++++++++++++++++++++++++---------
 drivers/spi/spi.c            |  45 ++++++++++++++
 include/linux/spi/spi.h      |  41 +++++++++++++
 4 files changed, 216 insertions(+), 29 deletions(-)

-- 
2.7.0
