From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Date: Fri, 4 Aug 2017 17:59:04 +0200
Message-ID: <c1b8cd3f-2db8-6f9f-286f-28992c8b5a8d@baylibre.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1501860550-16506-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Marc Gonzalez <marc_gonzalez-y1yR0Z3OICC7zZZRDBGcUA@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Matthias Brugger <ma>
List-Id: linux-omap@vger.kernel.org

On 08/04/2017 05:29 PM, Boris Brezillon wrote:
> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Peter Pan <peterpandong-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
> Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
> Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> Cc: Alexander Sverdlin <alexander.sverdlin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
> Cc: Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> Cc: Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>
> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>
> Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
> Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
> Cc: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Simtec Linux Team <linux-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> Cc: Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>
> Cc: Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>
> Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Cc: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
> Cc: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
> Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
> Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Cc: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>
> Cc: Harvey Hunt <harveyhuntnexus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
> Cc: Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Marc Gonzalez <marc_gonzalez-y1yR0Z3OICC7zZZRDBGcUA@public.gmane.org>
> Cc: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: linux-cris-kernel-VrBV9hrLPhE@public.gmane.org
> Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
> Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
> Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-oxnas-Xt5XgHjqiBU06sgRBLv0+0B+6BGkLq7r@public.gmane.org
> Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> ---
> Hi All,
> 
> Sorry for the huge Cc list, but I'd like to collect as much acks as
> possible for this patch which is actually part of a bigger series [1].
> 
> Note that there's nothing complicated here, it's just a mechanical
> s/nand\.h/rawnand\.h/ replacement, but it impacts several architectures,
> the doc and staging directories.
> 
> Regards,
> 
> Boris
> 
> [1]https://lwn.net/Articles/723694/
> ---
>  Documentation/driver-api/mtdnand.rst            | 8 ++++----
>  MAINTAINERS                                     | 2 +-
>  arch/arm/mach-davinci/board-da850-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm355-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c     | 2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-sffsdr.c            | 2 +-
>  arch/arm/mach-dove/dove-db-setup.c              | 2 +-
>  arch/arm/mach-ep93xx/snappercl15.c              | 2 +-
>  arch/arm/mach-ep93xx/ts72xx.c                   | 2 +-
>  arch/arm/mach-imx/mach-qong.c                   | 2 +-
>  arch/arm/mach-ixp4xx/ixdp425-setup.c            | 2 +-
>  arch/arm/mach-mmp/aspenite.c                    | 2 +-
>  arch/arm/mach-omap1/board-fsample.c             | 2 +-
>  arch/arm/mach-omap1/board-h2.c                  | 2 +-
>  arch/arm/mach-omap1/board-h3.c                  | 2 +-
>  arch/arm/mach-omap1/board-nand.c                | 2 +-
>  arch/arm/mach-omap1/board-perseus2.c            | 2 +-
>  arch/arm/mach-orion5x/db88f5281-setup.c         | 2 +-
>  arch/arm/mach-orion5x/kurobox_pro-setup.c       | 2 +-
>  arch/arm/mach-orion5x/ts209-setup.c             | 2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c            | 2 +-
>  arch/arm/mach-pxa/balloon3.c                    | 2 +-
>  arch/arm/mach-pxa/em-x270.c                     | 2 +-
>  arch/arm/mach-pxa/eseries.c                     | 2 +-
>  arch/arm/mach-pxa/palmtx.c                      | 2 +-
>  arch/arm/mach-pxa/tosa.c                        | 2 +-
>  arch/arm/mach-s3c24xx/common-smdk.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-anubis.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-at2440evb.c          | 2 +-
>  arch/arm/mach-s3c24xx/mach-bast.c               | 2 +-
>  arch/arm/mach-s3c24xx/mach-gta02.c              | 2 +-
>  arch/arm/mach-s3c24xx/mach-jive.c               | 2 +-
>  arch/arm/mach-s3c24xx/mach-mini2440.c           | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-qt2410.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-rx3715.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-vstms.c              | 2 +-
>  arch/blackfin/mach-bf537/boards/dnp5370.c       | 2 +-
>  arch/blackfin/mach-bf537/boards/stamp.c         | 2 +-
>  arch/blackfin/mach-bf561/boards/acvilon.c       | 2 +-
>  arch/cris/arch-v32/drivers/mach-a3/nandflash.c  | 2 +-
>  arch/cris/arch-v32/drivers/mach-fs/nandflash.c  | 2 +-
>  arch/mips/alchemy/devboards/db1200.c            | 2 +-
>  arch/mips/alchemy/devboards/db1300.c            | 2 +-
>  arch/mips/alchemy/devboards/db1550.c            | 2 +-
>  arch/mips/include/asm/mach-jz4740/jz4740_nand.h | 2 +-
>  arch/mips/netlogic/xlr/platform-flash.c         | 2 +-
>  arch/mips/pnx833x/common/platform.c             | 2 +-
>  arch/mips/rb532/devices.c                       | 2 +-
>  arch/sh/boards/mach-migor/setup.c               | 2 +-
>  drivers/mtd/inftlcore.c                         | 2 +-
>  drivers/mtd/nand/ams-delta.c                    | 2 +-
>  drivers/mtd/nand/atmel/nand-controller.c        | 2 +-
>  drivers/mtd/nand/atmel/pmecc.c                  | 2 +-
>  drivers/mtd/nand/au1550nd.c                     | 2 +-
>  drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h  | 2 +-
>  drivers/mtd/nand/bf5xx_nand.c                   | 2 +-
>  drivers/mtd/nand/brcmnand/brcmnand.c            | 2 +-
>  drivers/mtd/nand/cafe_nand.c                    | 2 +-
>  drivers/mtd/nand/cmx270_nand.c                  | 2 +-
>  drivers/mtd/nand/cs553x_nand.c                  | 2 +-
>  drivers/mtd/nand/davinci_nand.c                 | 2 +-
>  drivers/mtd/nand/denali.h                       | 2 +-
>  drivers/mtd/nand/diskonchip.c                   | 2 +-
>  drivers/mtd/nand/docg4.c                        | 2 +-
>  drivers/mtd/nand/fsl_elbc_nand.c                | 2 +-
>  drivers/mtd/nand/fsl_ifc_nand.c                 | 2 +-
>  drivers/mtd/nand/fsl_upm.c                      | 2 +-
>  drivers/mtd/nand/fsmc_nand.c                    | 2 +-
>  drivers/mtd/nand/gpio.c                         | 2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h          | 2 +-
>  drivers/mtd/nand/hisi504_nand.c                 | 2 +-
>  drivers/mtd/nand/jz4740_nand.c                  | 2 +-
>  drivers/mtd/nand/jz4780_nand.c                  | 2 +-
>  drivers/mtd/nand/lpc32xx_mlc.c                  | 2 +-
>  drivers/mtd/nand/lpc32xx_slc.c                  | 2 +-
>  drivers/mtd/nand/mpc5121_nfc.c                  | 2 +-
>  drivers/mtd/nand/mtk_nand.c                     | 2 +-
>  drivers/mtd/nand/mxc_nand.c                     | 2 +-
>  drivers/mtd/nand/nand_amd.c                     | 2 +-
>  drivers/mtd/nand/nand_base.c                    | 2 +-
>  drivers/mtd/nand/nand_bbt.c                     | 2 +-
>  drivers/mtd/nand/nand_bch.c                     | 2 +-
>  drivers/mtd/nand/nand_ecc.c                     | 2 +-
>  drivers/mtd/nand/nand_hynix.c                   | 2 +-
>  drivers/mtd/nand/nand_ids.c                     | 2 +-
>  drivers/mtd/nand/nand_macronix.c                | 2 +-
>  drivers/mtd/nand/nand_micron.c                  | 2 +-
>  drivers/mtd/nand/nand_samsung.c                 | 2 +-
>  drivers/mtd/nand/nand_timings.c                 | 2 +-
>  drivers/mtd/nand/nand_toshiba.c                 | 2 +-
>  drivers/mtd/nand/nandsim.c                      | 2 +-
>  drivers/mtd/nand/ndfc.c                         | 2 +-
>  drivers/mtd/nand/nuc900_nand.c                  | 2 +-
>  drivers/mtd/nand/omap2.c                        | 2 +-
>  drivers/mtd/nand/orion_nand.c                   | 2 +-
>  drivers/mtd/nand/oxnas_nand.c                   | 2 +-
>  drivers/mtd/nand/pasemi_nand.c                  | 2 +-
>  drivers/mtd/nand/plat_nand.c                    | 2 +-
>  drivers/mtd/nand/pxa3xx_nand.c                  | 2 +-
>  drivers/mtd/nand/qcom_nandc.c                   | 2 +-
>  drivers/mtd/nand/r852.h                         | 2 +-
>  drivers/mtd/nand/s3c2410.c                      | 2 +-
>  drivers/mtd/nand/sh_flctl.c                     | 2 +-
>  drivers/mtd/nand/sharpsl.c                      | 2 +-
>  drivers/mtd/nand/sm_common.c                    | 2 +-
>  drivers/mtd/nand/socrates_nand.c                | 2 +-
>  drivers/mtd/nand/sunxi_nand.c                   | 2 +-
>  drivers/mtd/nand/tango_nand.c                   | 2 +-
>  drivers/mtd/nand/tmio_nand.c                    | 2 +-
>  drivers/mtd/nand/txx9ndfmc.c                    | 2 +-
>  drivers/mtd/nand/vf610_nfc.c                    | 2 +-
>  drivers/mtd/nand/xway_nand.c                    | 2 +-
>  drivers/mtd/nftlcore.c                          | 2 +-
>  drivers/mtd/nftlmount.c                         | 2 +-
>  drivers/mtd/ssfdc.c                             | 2 +-
>  drivers/mtd/tests/nandbiterrs.c                 | 2 +-
>  drivers/staging/mt29f_spinand/mt29f_spinand.c   | 2 +-
>  fs/jffs2/wbuf.c                                 | 2 +-
>  include/linux/mtd/nand-gpio.h                   | 2 +-
>  include/linux/mtd/{nand.h => rawnand.h}         | 8 +++-----
>  include/linux/mtd/sh_flctl.h                    | 2 +-
>  include/linux/mtd/sharpsl.h                     | 2 +-
>  include/linux/platform_data/mtd-davinci.h       | 2 +-
>  include/linux/platform_data/mtd-nand-s3c2410.h  | 2 +-
>  128 files changed, 133 insertions(+), 135 deletions(-)
>  rename include/linux/mtd/{nand.h => rawnand.h} (99%)
> 
[...]
> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> index 7061bb2923b4..d649d5944826 100644
> --- a/drivers/mtd/nand/oxnas_nand.c
> +++ b/drivers/mtd/nand/oxnas_nand.c
> @@ -21,7 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/mtd/mtd.h>
> -#include <linux/mtd/nand.h>
> +#include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/of.h>
>  
[...]

For oxnas_nand.c :
Acked-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
