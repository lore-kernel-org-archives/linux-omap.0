From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 00/17] Add memory mapped support for ti qspi, m25p80 serial flash.
Date: Tue, 26 Nov 2013 13:04:56 +0530
Message-ID: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59109 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3KZHfy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 02:35:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>


The patch series aims to add memory mapped support for TI qspi
contoller and also add support for the same in serial flash driver(m25p80).

These feature was added as a part of the series[1]:
The series[1] add support for quad and memory mapped feature in spi and
flash driver. Based on Brian Norris suggestion on splitting the quad and 
memory mapped feature, I had sent a seperate series for quad support which 
has beed accepted by Brian.

The $subject patch series takes care of the memory mapped part.  

Overview of memory mapped support in qspi:
 TI qspi controller supports memory mapped read support, switching to which
 requires  register modifications(qspi registers, control module register for
 DRA, qspi register for am43x). Once switched, the flash data can be available
 at a soc specific memory mapped address. For operations in normal mode, we need 
 to keep memory mapped disable.

 Flow of the patch is to keep the memory mapped enable by default in the driver.
 Whenever Normal spi mode operations are desired, we switch to configuration mode
 and at the end of it memory mapped is again enabled. There are few function pointers
 added to fecilitate easy communication between the flash and spi controllers.

Major changes in the $subject patch based on discussion in [1]:

- Feature has been broken down into small meaningfl patches.
- memcpy is done in flash driver and spi framework is bypassed.
- configuration of memory mapped spi controller regsiters is done
  through function calls from flash side.

[1]: http://lists.infradead.org/pipermail/linux-mtd/2013-October/049058.html


Tested on DRA7 board with spansion S25FL256S flash along with some
internal irq crossbar patches.
Tested on AM437x epos evm with macronix MX66l51235l flash.

Testing done:
-Erase the whole flash.
-write to the flash
-read back the flash
- compare the data

Sourav Poddar (17):
  spi/spi.h: Add get_buf/put_buf support in spi master..
  spi/spi.h: Add configure from slave support.
  spi/qspi: parse register by name.
  spi/qspi: parse control module register.
  spi/qspi: parse memory map register.
  spi/qspi: Add support to switc to memory mapped operation.
  spi/qspi: configure set up register for memory map..
  spi/qspi: Add api for get_buf/put_buf.
  spi/spi.h: Add "mem" variable in spi master.
  spi/spi.h: Add mmap flag in spi master.
  spi/qspi: set "mmap" flag to true.
  spi/qspi: convert driver to enable/disable memory mapped..
  drivers: mtd: m25p80: Add api to configure master register .
  drivers: mtd: m25p80: Adapt driver to support memory mapped read.
  arm: dts: dra7: Add qspi device.
  arm: dts: am43x-epos: Add qspi device.
  Documentation: bindings: ti-qspi: update binding information.

 Documentation/devicetree/bindings/spi/ti_qspi.txt |    2 +
 arch/arm/boot/dts/am4372.dtsi                     |   12 ++
 arch/arm/boot/dts/am43x-epos-evm.dts              |   28 +++++
 arch/arm/boot/dts/dra7-evm.dts                    |   32 ++++++
 arch/arm/boot/dts/dra7.dtsi                       |   13 +++
 drivers/mtd/devices/m25p80.c                      |   30 ++++++
 drivers/spi/spi-ti-qspi.c                         |  115 ++++++++++++++++++++-
 include/linux/spi/spi.h                           |   16 +++
 8 files changed, 246 insertions(+), 2 deletions(-)

