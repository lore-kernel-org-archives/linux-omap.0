From: Frode Isaksen <fisaksen@baylibre.com>
Subject: Re: [RFC PATCH 0/2] mtd: spi-nor: Handle vmalloc'd buffers
Date: Mon, 27 Feb 2017 15:03:57 +0100
Message-ID: <884efafc-6b34-0cb6-4c9f-e3a926114130@baylibre.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170227120839.16545-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 27/02/2017 13:08, Vignesh R wrote:
> This series implements bounce buffer support to handle vmalloc'd buffers
> in case of drivers use DMA, similar to what is done in MTD NAND
> framework.
>
> I have tested this on two platform:
> DRA74 SoC (cortex a15 @1GHz) with s25fl256s1 QSPI (SPI bus frequency
> 76.8 MHz) and I don't see any performance degradation with UBIFS
> read/write(10MB file).
> AM437x SoC (cortex a9 @1GHz) with macronix mx66l51235l QSPI flash (SPI bus
> frequency 48MHz) and performance degradation is <4% for UBIFS.
>
>
> Vignesh R (2):
>   mtd: spi-nor: Introduce bounce buffer to handle vmalloc'd buffers
>   mtd: devices: m25p80: Enable spi-nor bounce buffer support
>
>  drivers/mtd/devices/m25p80.c  |  1 +
>  drivers/mtd/spi-nor/spi-nor.c | 30 +++++++++++++++++++++++++++---
>  include/linux/mtd/spi-nor.h   |  4 ++++
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
I have tested this on a daVinci EVM board with SPI DMA enabled and the UBIFS tests all passed.

Thanks,
Frode

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
