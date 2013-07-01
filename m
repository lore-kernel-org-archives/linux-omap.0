From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/3] spi/mtd generic framework,ti qspi controller and
 spansion driver
Date: Mon, 1 Jul 2013 10:47:16 +0530
Message-ID: <51D110DC.2050107@ti.com>
References: <1372232472-2641-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1372232472-2641-1-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>, artem.bityutskiy@linux.intel.com
Cc: rnayak@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, broonie@kernel.org, linux-mtd@lists.infradead.org, tqnguyen@micron.com, grant.likely@linaro.org, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dwmw2@infradead.org, manonuevo@micron.com
List-Id: linux-omap@vger.kernel.org

+ Artem
On Wednesday 26 June 2013 01:11 PM, Sourav Poddar wrote:
> This patch series add support for the generic spi based flash
> framework(spinand_mtd), which can be used used by any spi based flash device to
> attach itself to mtd framework.
>
> The first patch of this series includes both the generic framework and the
> the micron device(spinand_lld) making use of the framework.
> I picked the first patch as a standalone patch. Can split the generic and
> the lld part based on community suggestions.
>
> The second patch is the ti qspi controller driver.
> The third patch is the spansion s25fl256s driver, making use of the the
> generic spinand_mtd frameowrk.
>
> Test info:
> Tested the generic framework(spinand_mtd.c) along with patch(2&3) on my dra7xx board
> for write/erase/read using nand utils.
>
> Compile tested(spinand_lld.c).
>
> Mona Anonuevo (1):
>    drivers: mtd: spinand: Add generic spinand frameowrk and micron
>      driver.
>
> Sourav Poddar (2):
>    drivers: spi: Add qspi flash controller
>    drivers: mtd: spinand: Add qspi spansion flash controller
>
>   drivers/mtd/Kconfig                 |    2 +
>   drivers/mtd/Makefile                |    2 +
>   drivers/mtd/spinand/Kconfig         |   31 ++
>   drivers/mtd/spinand/Makefile        |   10 +
>   drivers/mtd/spinand/spinand_lld.c   |  776 +++++++++++++++++++++++++++++++++++
>   drivers/mtd/spinand/spinand_mtd.c   |  690 +++++++++++++++++++++++++++++++
>   drivers/mtd/spinand/ti-qspi-flash.c |  373 +++++++++++++++++
>   drivers/spi/Kconfig                 |    6 +
>   drivers/spi/Makefile                |    1 +
>   drivers/spi/ti-qspi.c               |  352 ++++++++++++++++
>   include/linux/mtd/spinand.h         |  155 +++++++
>   11 files changed, 2398 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/mtd/spinand/Kconfig
>   create mode 100644 drivers/mtd/spinand/Makefile
>   create mode 100644 drivers/mtd/spinand/spinand_lld.c
>   create mode 100644 drivers/mtd/spinand/spinand_mtd.c
>   create mode 100644 drivers/mtd/spinand/ti-qspi-flash.c
>   create mode 100644 drivers/spi/ti-qspi.c
>   create mode 100644 include/linux/mtd/spinand.h
>


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
