From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Date: Mon, 7 Aug 2017 21:06:09 +0200
Message-ID: <20170807190609.uz6fpatkzijfgifr@kozik-lap>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Sekhar Nori <nsekhar@ti.com>, Stefan Agner <stefan@agner.ch>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mtd@lists.infradead.org, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, bcm-kernel-feedback-list@broadcom.com, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-omap@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-doc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-oxnas@lists.tuxfamily.org, Marek Vasut <marek.vasut@gmail.>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 04, 2017 at 05:29:10PM +0200, Boris Brezillon wrote:
> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Peter Pan <peterpandong@micron.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Han Xu <han.xu@nxp.com>
> Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: adi-buildroot-devel@lists.sourceforge.net
> Cc: linux-cris-kernel@axis.com
> Cc: linux-mips@linux-mips.org
> Cc: linux-sh@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-oxnas@lists.tuxfamily.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: devel@driverdev.osuosl.org
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

For s3c24xx:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
