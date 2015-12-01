From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 12/25] mtd: nand: use the mtd instance
 embedded in struct nand_chip
Date: Tue, 1 Dec 2015 14:15:31 -0800
Message-ID: <20151201221531.GA64635@google.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-13-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZ6PSPVXMNBBB5Y7CZAKGQEFP3Q5QA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448967802-25796-13-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On Tue, Dec 01, 2015 at 12:03:09PM +0100, Boris Brezillon wrote:
> struct nand_chip now embeds an mtd device. Patch all drivers to make use
> of this mtd instance instead of using the instance embedded in their
> private struct or dynamically allocated.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
> ---
> Most of those changes were generated with the coccinelle script added
> in commit c671312 "coccinelle: nand: detect and correct drivers embedding
> an mtd_info object"
> ---
>  drivers/mtd/nand/ams-delta.c                   | 13 ++--
>  drivers/mtd/nand/atmel_nand.c                  | 13 ++--
>  drivers/mtd/nand/au1550nd.c                    | 19 ++---
>  drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h |  1 -
>  drivers/mtd/nand/bcm47xxnflash/main.c          |  8 ++-
>  drivers/mtd/nand/bcm47xxnflash/ops_bcm4706.c   |  2 +-
>  drivers/mtd/nand/bf5xx_nand.c                  | 12 ++--
>  drivers/mtd/nand/brcmnand/brcmnand.c           | 13 ++--
>  drivers/mtd/nand/cafe_nand.c                   |  8 +--
>  drivers/mtd/nand/cmx270_nand.c                 | 11 ++-
>  drivers/mtd/nand/cs553x_nand.c                 | 13 ++--
>  drivers/mtd/nand/davinci_nand.c                | 30 ++++----
>  drivers/mtd/nand/denali.c                      | 68 ++++++++++--------
>  drivers/mtd/nand/denali.h                      |  1 -
>  drivers/mtd/nand/diskonchip.c                  | 11 ++-
>  drivers/mtd/nand/docg4.c                       | 16 ++---
>  drivers/mtd/nand/fsl_elbc_nand.c               | 26 ++++---
>  drivers/mtd/nand/fsl_ifc_nand.c                | 28 ++++----
>  drivers/mtd/nand/fsl_upm.c                     | 28 ++++----
>  drivers/mtd/nand/fsmc_nand.c                   | 56 ++++++++-------
>  drivers/mtd/nand/gpio.c                        | 20 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c          |  2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c         | 20 +++---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h         |  1 -
>  drivers/mtd/nand/hisi504_nand.c                | 13 ++--
>  drivers/mtd/nand/jz4740_nand.c                 |  9 ++-
>  drivers/mtd/nand/lpc32xx_mlc.c                 |  7 +-
>  drivers/mtd/nand/lpc32xx_slc.c                 |  7 +-
>  drivers/mtd/nand/mpc5121_nfc.c                 |  3 +-
>  drivers/mtd/nand/mxc_nand.c                    |  5 +-
>  drivers/mtd/nand/nandsim.c                     | 12 ++--
>  drivers/mtd/nand/ndfc.c                        | 24 ++++---
>  drivers/mtd/nand/nuc900_nand.c                 | 24 +++----
>  drivers/mtd/nand/omap2.c                       | 98 +++++++++++++++-----=
------
>  drivers/mtd/nand/orion_nand.c                  |  4 +-
>  drivers/mtd/nand/pasemi_nand.c                 | 12 ++--
>  drivers/mtd/nand/plat_nand.c                   | 15 ++--
>  drivers/mtd/nand/pxa3xx_nand.c                 | 33 ++++-----
>  drivers/mtd/nand/r852.c                        | 34 ++++-----
>  drivers/mtd/nand/r852.h                        |  1 -
>  drivers/mtd/nand/s3c2410.c                     | 23 +++---

^^ some errors in this one

>  drivers/mtd/nand/sh_flctl.c                    |  8 +--
>  drivers/mtd/nand/sharpsl.c                     | 22 +++---
>  drivers/mtd/nand/socrates_nand.c               |  5 +-
>  drivers/mtd/nand/sunxi_nand.c                  | 13 ++--
>  drivers/mtd/nand/tmio_nand.c                   | 10 +--
>  drivers/mtd/nand/txx9ndfmc.c                   |  3 +-
>  drivers/mtd/nand/vf610_nfc.c                   |  8 ++-
>  include/linux/mtd/sh_flctl.h                   |  3 +-
>  49 files changed, 426 insertions(+), 390 deletions(-)
>=20

[...]

> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> index e658b29..3f29734 100644
> --- a/drivers/mtd/nand/s3c2410.c
> +++ b/drivers/mtd/nand/s3c2410.c
> @@ -104,7 +104,6 @@ struct s3c2410_nand_info;
>   * @scan_res: The result from calling nand_scan_ident().
>  */
>  struct s3c2410_nand_mtd {
> -	struct mtd_info			mtd;
>  	struct nand_chip		chip;
>  	struct s3c2410_nand_set		*set;
>  	struct s3c2410_nand_info	*info;
> @@ -168,7 +167,8 @@ struct s3c2410_nand_info {
> =20
>  static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info =
*mtd)
>  {
> -	return container_of(mtd, struct s3c2410_nand_mtd, mtd);
> +	return container_of(mtd_to_nand(mtd), struct s3c2410_nand_mtd,
> +			    chip);
>  }
> =20
>  static struct s3c2410_nand_info *s3c2410_nand_mtd_toinfo(struct mtd_info=
 *mtd)
> @@ -745,7 +745,7 @@ static int s3c24xx_nand_remove(struct platform_device=
 *pdev)
> =20
>  		for (mtdno =3D 0; mtdno < info->mtd_count; mtdno++, ptr++) {
>  			pr_debug("releasing mtd %d (%p)\n", mtdno, ptr);
> -			nand_release(&ptr->mtd);
> +			nand_release(nand_to_mtd(&ptr->chip));
>  		}
>  	}
> =20
> @@ -762,9 +762,11 @@ static int s3c2410_nand_add_partition(struct s3c2410=
_nand_info *info,
>  				      struct s3c2410_nand_set *set)
>  {
>  	if (set) {
> -		mtd->mtd.name =3D set->name;
> +		struct mtd_info *mtd =3D nand_to_mtd(&mtd->chip);

You're shadowing the earlier 'mtd' variable:

drivers/mtd/nand/s3c2410.c: In function =E2=80=98s3c2410_nand_add_partition=
=E2=80=99:
drivers/mtd/nand/s3c2410.c:765:42: error: =E2=80=98struct mtd_info=E2=80=99=
 has no member named =E2=80=98chip=E2=80=99

> =20
> -		return mtd_device_parse_register(&mtd->mtd, NULL, NULL,
> +		mtd->name =3D set->name;
> +
> +		return mtd_device_parse_register(mtd, NULL, NULL,
>  					 set->partitions, set->nr_partitions);
>  	}
> =20
> @@ -786,6 +788,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nan=
d_info *info,
>  				   struct s3c2410_nand_set *set)
>  {
>  	struct nand_chip *chip =3D &nmtd->chip;
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	void __iomem *regs =3D info->regs;
> =20
>  	chip->write_buf    =3D s3c2410_nand_write_buf;
> @@ -831,7 +834,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nan=
d_info *info,
>  	chip->IO_ADDR_R =3D chip->IO_ADDR_W;
> =20
>  	nmtd->info	   =3D info;
> -	nmtd->mtd.priv	   =3D chip;
> +	mtd->priv	   =3D chip;
>  	nmtd->set	   =3D set;
> =20
>  #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
> @@ -1012,19 +1015,21 @@ static int s3c24xx_nand_probe(struct platform_dev=
ice *pdev)
>  	nmtd =3D info->mtds;
> =20
>  	for (setno =3D 0; setno < nr_sets; setno++, nmtd++) {
> +		struct mtd_info *mtd =3D nand_to_mtd(&nmtd->chip);
> +
>  		pr_debug("initialising set %d (%p, info %p)\n",
>  			 setno, nmtd, info);
> =20
> -		nmtd->mtd.dev.parent =3D &pdev->dev;
> +		mtd->dev.parent =3D &pdev->dev;
>  		s3c2410_nand_init_chip(info, nmtd, sets);
> =20
> -		nmtd->scan_res =3D nand_scan_ident(&nmtd->mtd,
> +		nmtd->scan_res =3D nand_scan_ident(mtd,
>  						 (sets) ? sets->nr_chips : 1,
>  						 NULL);
> =20
>  		if (nmtd->scan_res =3D=3D 0) {
>  			s3c2410_nand_update_chip(info, nmtd);
> -			nand_scan_tail(&nmtd->mtd);
> +			nand_scan_tail(mtd);
>  			s3c2410_nand_add_partition(info, nmtd, sets);
>  		}
> =20

[...]

Brian

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
