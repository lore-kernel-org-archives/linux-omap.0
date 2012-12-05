From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 1/3] mtd: nand: omap2: Update nerrors using ecc.strength
Date: Wed, 5 Dec 2012 12:43:59 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA1139B@DBDE01.ent.ti.com>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-2-git-send-email-avinashphilip@ti.com>
 <50BF3819.9010200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50BF3819.9010200-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 05, 2012 at 17:33:37, Nori, Sekhar wrote:
> Hi Avinash,
> 
> On 11/29/2012 5:16 PM, Philip, Avinash wrote:
> > Update number of errors using nand ecc strength.
> > Also add macro definitions BCH8_ERROR_MAX & BCH4_ERROR_MAX
> 
> Can you please describe why the original method of setting nerrors was
> incorrect? Was it causing any issues in any particular configuration?

It affects the reusability of the code. For example BCH8 with AM335x RBL 
compatibility requires  14 bytes instead of 13 byte. So setting nerrors
with
	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
will break am335x RBL compatibility.

> Mentioning this will help maintainers assign priority to your patch. If
> this is a real bug affecting existing platforms, then there is a chance
> this patch can get into v3.7 (or at least into v3.8-rc1).
> 
> Like Peter who commented on this before, I am not a fan of using macros
> for self-describing constants - especially when you end up using the
> same numbers inside the macro name itself. No need to resend any thing
> just for this, you can wait to see if the maintainers are okay with it.

Yes I agree. But the same constants are used in multiple places here.
So usage of macro helps in readability & code debugging.

Thanks
Avinash
 
> 
> Thanks,
> Sekhar
> 
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
> > ---
> > :100644 100644 359293e... 7e61dac... M	drivers/mtd/nand/omap2.c
> >  drivers/mtd/nand/omap2.c |   12 ++++++++----
> >  1 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index 359293e..7e61dac 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -118,6 +118,9 @@
> >  
> >  #define OMAP24XX_DMA_GPMC		4
> >  
> > +#define BCH8_MAX_ERROR		8	/* upto 8 bit correctable */
> > +#define BCH4_MAX_ERROR		4	/* upto 4 bit correctable */
> > +
> >  /* oob info generated runtime depending on ecc algorithm and layout selected */
> >  static struct nand_ecclayout omap_oobinfo;
> >  /* Define some generic bad / good block scan pattern which are used
> > @@ -1042,7 +1045,7 @@ static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
> >  	struct nand_chip *chip = mtd->priv;
> >  	u32 val;
> >  
> > -	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
> > +	nerrors = info->nand.ecc.strength;
> >  	dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
> >  	nsectors = 1;
> >  	/*
> > @@ -1219,13 +1222,14 @@ static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
> >  	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
> >  						   mtd);
> >  #ifdef CONFIG_MTD_NAND_OMAP_BCH8
> > -	const int hw_errors = 8;
> > +	const int hw_errors = BCH8_MAX_ERROR;
> >  #else
> > -	const int hw_errors = 4;
> > +	const int hw_errors = BCH4_MAX_ERROR;
> >  #endif
> >  	info->bch = NULL;
> >  
> > -	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ? 8 : 4;
> > +	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ?
> > +		BCH8_MAX_ERROR : BCH4_MAX_ERROR;
> >  	if (max_errors != hw_errors) {
> >  		pr_err("cannot configure %d-bit BCH ecc, only %d-bit supported",
> >  		       max_errors, hw_errors);
> > 
> 
