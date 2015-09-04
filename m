From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/5] Add memory mapped read support for ti-qspi
Date: Fri, 4 Sep 2015 13:59:57 +0530
Message-ID: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, hramrach@gmail.com
Cc: devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Hi,

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


Vignesh R (5):
  spi: introduce mmap read support for spi flash devices
  spi: spi-ti-qspi: add mmap mode read support
  mtd: devices: m25p80: add support for mmap read request
  ARM: dts: DRA7: add entry for qspi mmap region
  ARM: dts: AM4372: add entry for qspi mmap region

 Documentation/devicetree/bindings/spi/ti_qspi.txt |  18 +++-
 arch/arm/boot/dts/am4372.dtsi                     |   4 +-
 arch/arm/boot/dts/dra7.dtsi                       |   6 +-
 drivers/mtd/devices/m25p80.c                      |   8 ++
 drivers/spi/spi-ti-qspi.c                         | 106 +++++++++++++++++++++-
 include/linux/spi/spi.h                           |  21 +++++
 6 files changed, 154 insertions(+), 9 deletions(-)

-- 
2.5.1
