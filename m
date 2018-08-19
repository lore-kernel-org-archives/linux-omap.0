From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 08/23] mtd: rawnand: Pass a nand_chip object to
 ecc->read_xxx() hooks
Date: Sun, 19 Aug 2018 13:26:15 +0200
Message-ID: <20180819132615.6c090d12@bbrezillon>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
 <20180817160922.6224-9-boris.brezillon@bootlin.com>
 <c08c6ecf720cc6b242094246b2f296c3@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <c08c6ecf720cc6b242094246b2f296c3@agner.ch>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Mans Rullgard <mans@mansr.com>, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Gregory Clement <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Lukasz Majewski <lukma@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-omap@vger.kernel.org

Hi Stefan,

On Sat, 18 Aug 2018 10:30:13 +0200
Stefan Agner <stefan@agner.ch> wrote:

> > diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> > b/drivers/mtd/nand/raw/tegra_nand.c
> > index 5dcee20e2a8c..bcc3a2888c4f 100644
> > --- a/drivers/mtd/nand/raw/tegra_nand.c
> > +++ b/drivers/mtd/nand/raw/tegra_nand.c
> > @@ -615,10 +615,10 @@ static int tegra_nand_page_xfer(struct mtd_info
> > *mtd, struct nand_chip *chip,
> >  	return ret;
> >  }
> >  
> > -static int tegra_nand_read_page_raw(struct mtd_info *mtd,
> > -				    struct nand_chip *chip, u8 *buf,
> > +static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
> >  				    int oob_required, int page)
> >  {
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> >  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
> >  
> >  	return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,  
> 
> Since mtd is only required to pass it to tegra_nand_page_xfer, it would
> be better to change tegra_nand_page_xfer to only take chip.

For sure, but that's the sort of cleanups I'll leave to NAND controller
driver maintainers (in this case you ;-)). I only take care of the NAND
API here and try to make things as simple as possible to ease review and
avoid breaking drivers. 

Regards,

Boris
