From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80 serial flash.
Date: Fri, 6 Dec 2013 19:54:41 +0530
Message-ID: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

v1->v2:
 Mentioned on individual patches.
Overall change is the squashing of few patches.


v1:
https://patchwork.kernel.org/patch/3237091/

Tested on DRA7 board with spansion S25FL256S flash along with some
internal irq crossbar patches.
Tested on AM437x epos evm with macronix MX66l51235l flash.

Testing done:
-Erase the whole flash.
-write to the flash
-read back the flash
- compare the data


Sourav Poddar (10):
  spi/spi.h: Add get_buf/put_buf support in spi master..
  spi/qspi: parse register by name.
  spi/qspi: Add support to switc to memory mapped operation.
  spi/qspi: configure set up register for memory map..
  spi/qspi: Add api for get_buf/put_buf.
  drivers: mtd: m25p80: Add api to configure master register.
  drivers: mtd: m25p80: Adapt driver to support memory mapped read.
  Documentation: bindings: ti-qspi: update binding information.
  arm: dts: dra7: Add qspi device.
  arm: dts: am43x-epos: Add qspi device.

 Documentation/devicetree/bindings/spi/ti_qspi.txt |    8 +-
 arch/arm/boot/dts/am4372.dtsi                     |   12 ++
 arch/arm/boot/dts/am43x-epos-evm.dts              |   28 +++++
 arch/arm/boot/dts/dra7-evm.dts                    |   32 +++++
 arch/arm/boot/dts/dra7.dtsi                       |   13 ++
 drivers/mtd/devices/m25p80.c                      |   38 ++++++
 drivers/spi/spi-ti-qspi.c                         |  130 ++++++++++++++++++++-
 include/linux/spi/spi.h                           |   22 ++++
 8 files changed, 280 insertions(+), 3 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
