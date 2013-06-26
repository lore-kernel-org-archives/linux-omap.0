From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] spi/mtd generic framework,
	ti qspi controller and spansion driver
Date: Wed, 26 Jun 2013 13:11:09 +0530
Message-ID: <1372232472-2641-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, manonuevo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org, tqnguyen-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series add support for the generic spi based flash
framework(spinand_mtd), which can be used used by any spi based flash device to
attach itself to mtd framework. 

The first patch of this series includes both the generic framework and the
the micron device(spinand_lld) making use of the framework.
I picked the first patch as a standalone patch. Can split the generic and
the lld part based on community suggestions.

The second patch is the ti qspi controller driver.
The third patch is the spansion s25fl256s driver, making use of the the
generic spinand_mtd frameowrk.

Test info:
Tested the generic framework(spinand_mtd.c) along with patch(2&3) on my dra7xx board 
for write/erase/read using nand utils.

Compile tested(spinand_lld.c).

Mona Anonuevo (1):
  drivers: mtd: spinand: Add generic spinand frameowrk and micron
    driver.

Sourav Poddar (2):
  drivers: spi: Add qspi flash controller
  drivers: mtd: spinand: Add qspi spansion flash controller

 drivers/mtd/Kconfig                 |    2 +
 drivers/mtd/Makefile                |    2 +
 drivers/mtd/spinand/Kconfig         |   31 ++
 drivers/mtd/spinand/Makefile        |   10 +
 drivers/mtd/spinand/spinand_lld.c   |  776 +++++++++++++++++++++++++++++++++++
 drivers/mtd/spinand/spinand_mtd.c   |  690 +++++++++++++++++++++++++++++++
 drivers/mtd/spinand/ti-qspi-flash.c |  373 +++++++++++++++++
 drivers/spi/Kconfig                 |    6 +
 drivers/spi/Makefile                |    1 +
 drivers/spi/ti-qspi.c               |  352 ++++++++++++++++
 include/linux/mtd/spinand.h         |  155 +++++++
 11 files changed, 2398 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/spinand/Kconfig
 create mode 100644 drivers/mtd/spinand/Makefile
 create mode 100644 drivers/mtd/spinand/spinand_lld.c
 create mode 100644 drivers/mtd/spinand/spinand_mtd.c
 create mode 100644 drivers/mtd/spinand/ti-qspi-flash.c
 create mode 100644 drivers/spi/ti-qspi.c
 create mode 100644 include/linux/mtd/spinand.h


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
