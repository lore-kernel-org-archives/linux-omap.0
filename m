From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v11 04/10] mtd: nand: omap: use DT specified bus-width
 only for scanning NAND device
Date: Thu, 24 Oct 2013 18:27:15 -0300
Message-ID: <20131024212714.GB2520@localhost>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
 <1382619026-4182-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52451 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752724Ab3JXV12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 17:27:28 -0400
Content-Disposition: inline
In-Reply-To: <1382619026-4182-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, jp.francois@cynove.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, robherring2@gmail.com, bcousson@baylibre.com, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com, linux-omap@vger.kernel.org, dwmw2@infradead.org

On Thu, Oct 24, 2013 at 06:20:20PM +0530, Pekon Gupta wrote:
> This patch:
> - calls nand_scan_ident() using bus-width as passed by DT
> - removes double calls to nand_scan_ident(), incase first call fails
>   then omap_nand_probe just returns error.
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/nand/omap2.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 5596368..f464321 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1856,7 +1856,6 @@ static int omap_nand_probe(struct platform_devi=
ce *pdev)
>  	mtd->name		=3D dev_name(&pdev->dev);
>  	mtd->owner		=3D THIS_MODULE;
>  	nand_chip		=3D &info->nand;
> -	nand_chip->options	=3D pdata->devsize;
>  	nand_chip->options	|=3D NAND_SKIP_BBTSCAN;
>  #ifdef CONFIG_MTD_NAND_OMAP_BCH
>  	info->of_node		=3D pdata->of_node;
> @@ -1904,6 +1903,15 @@ static int omap_nand_probe(struct platform_dev=
ice *pdev)
>  		nand_chip->chip_delay =3D 50;
>  	}
> =20
> +	/* scan NAND device connected to chip controller */
> +	nand_chip->options |=3D pdata->devsize & NAND_BUSWIDTH_16;

Hm.. this only works if the device is listed in nand_flash_ids[] array,
so that ONFI detection is not used. To make ONFI detection work I think=
 you
need to do as Brian suggested and use NAND_BUSWIDTH_AUTO.

(Odd: why is there no current user of that auto-width option?)

Anyway, I really think we should fix this now and independently
of the evolution of this ECC DT binding discussion.
That way you can keep sending a smaller ECC DT binding patchset and
make reviewers focus on what's really important in each case.

I have a few fixes (based on your work) and I'll send them now, after
I complete the tests. We can continue our discussion there.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
