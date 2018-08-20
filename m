From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 08/23] mtd: rawnand: Pass a nand_chip object to
 ecc->read_xxx() hooks
Date: Mon, 20 Aug 2018 10:09:19 +0200
Message-ID: <20180820100919.47f89927@bbrezillon>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
 <20180817160922.6224-9-boris.brezillon@bootlin.com>
 <c08c6ecf720cc6b242094246b2f296c3@agner.ch>
 <20180819132615.6c090d12@bbrezillon>
 <f75fc1c2e3c70cdb6c2f9ca2dbba3f2f@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <f75fc1c2e3c70cdb6c2f9ca2dbba3f2f-XLVq0VzYD2Y@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Stefan,

On Mon, 20 Aug 2018 09:57:47 +0200
Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org> wrote:

> On 19.08.2018 13:26, Boris Brezillon wrote:
> > Hi Stefan,
> > 
> > On Sat, 18 Aug 2018 10:30:13 +0200
> > Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org> wrote:
> >   
> >> > diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> >> > b/drivers/mtd/nand/raw/tegra_nand.c
> >> > index 5dcee20e2a8c..bcc3a2888c4f 100644
> >> > --- a/drivers/mtd/nand/raw/tegra_nand.c
> >> > +++ b/drivers/mtd/nand/raw/tegra_nand.c
> >> > @@ -615,10 +615,10 @@ static int tegra_nand_page_xfer(struct mtd_info
> >> > *mtd, struct nand_chip *chip,
> >> >  	return ret;
> >> >  }
> >> >
> >> > -static int tegra_nand_read_page_raw(struct mtd_info *mtd,
> >> > -				    struct nand_chip *chip, u8 *buf,
> >> > +static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
> >> >  				    int oob_required, int page)
> >> >  {
> >> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> >> >  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
> >> >
> >> >  	return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,  
> >>
> >> Since mtd is only required to pass it to tegra_nand_page_xfer, it would
> >> be better to change tegra_nand_page_xfer to only take chip.  
> > 
> > For sure, but that's the sort of cleanups I'll leave to NAND controller
> > driver maintainers (in this case you ;-)). I only take care of the NAND
> > API here and try to make things as simple as possible to ease review and
> > avoid breaking drivers.  
> 
> Understand, but that change makes your patch simpler... Or did create
> those patches automatically? In that case it makes sense to avoid manual
> changes.

I could have written a coccinelle script, but every time I tried it
took me more time than using git grep + manual patching :-).

> 
> I can send a follow up patch no problem, but if you do a v2 and did the
> chagnes manually anyway, I really think it can go into this patchset.

The thing is, if I do that for tegra, why not doing it for other
drivers, and then the patch becomes really hard to review. So yes, I'd
prefer to keep the changes as dumb as possible and let each maintainer
cleanup their driver (which basically means, stop passing mtd_info to
all internal functions, not only this one).

Regards,

Boris
