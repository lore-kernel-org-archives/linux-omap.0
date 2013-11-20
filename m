From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [RFC] mtd: gpmc: add BCH support for plain AM335x
Date: Wed, 20 Nov 2013 14:57:34 -0300
Message-ID: <20131120175733.GA27064@localhost>
References: <1384969152-10411-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54184 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753492Ab3KTR5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 12:57:34 -0500
Content-Disposition: inline
In-Reply-To: <1384969152-10411-1-git-send-email-wsa@the-dreams.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hey Wolfram:

On Wed, Nov 20, 2013 at 06:39:12PM +0100, Wolfram Sang wrote:
> When building a kernel without OMAP3 support but only AM335x, we can'=
t
> activate the needed MTD_NAND_OMAP_BCH symbol.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>=20
> Actually, I wonder if this is fix will scale. Maybe someone with more=
 insight
> about TI SoCs could find a better expression of supported SoCs. This =
is the
> only one I could test .
>=20
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 93ae6a6..f9455e4 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
>  	  platforms.
> =20
>  config MTD_NAND_OMAP_BCH
> -	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> +	depends on MTD_NAND && MTD_NAND_OMAP2 && (ARCH_OMAP3 || SOC_AM33XX)
>  	tristate "Support hardware based BCH error correction"
>  	default n
>  	select BCH
> --=20
> 1.8.4.2
>=20

A similar patch has been already merged and you can pick it from l2-mtd
next branch:

http://git.infradead.org/l2-mtd.git/commitdiff/1900cdf03057030497e96761=
4c4b19296b6ac460

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
