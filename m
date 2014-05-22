From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [RFC PATCH 08/16] mtd: nand: omap: Fix build warning
Date: Thu, 22 May 2014 09:54:59 +0900
Message-ID: <02cd01cf7558$7500eb00$5f02c100$%han@samsung.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
 <1400671264-10702-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1400671264-10702-9-git-send-email-rogerq@ti.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Roger Quadros' <rogerq@ti.com>
Cc: tony@atomide.com, computersforpeace@gmail.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, robertcnelson@gmail.com, dwmw2@infradead.org, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Christian Engelmayer' <cengelma@gmx.at>
List-Id: linux-omap@vger.kernel.org

On Wednesday, May 21, 2014 8:21 PM, Roger Quadros wrote:
>=20
> Fix the following warning when CONFIG_MTD_NAND_OMAP_BCH is disabled.
> warning: =E2=80=98erased_sector_bitflips=E2=80=99 defined but not use=
d [-Wunused-function]
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

(+cc Christian Engelmayer)

The same patch was already sent by Christian Engelmayer. [1]
Also, it was applied to mtd tree by Brian Norris. [2]
Thank you.

[1] http://lists.infradead.org/pipermail/linux-mtd/2014-April/053330.ht=
ml
[2] http://git.infradead.org/users/dedekind/l2-mtd.git/commit/9fd6c6c18=
c1a4a3220473c76fd447c5708b5ecf9

Best regards,
Jingoo Han

> ---
>  drivers/mtd/nand/omap2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1ff49b8..1b800bc 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1237,6 +1237,7 @@ static int __maybe_unused omap_calculate_ecc_bc=
h(struct mtd_info *mtd,
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  /**
>   * erased_sector_bitflips - count bit flips
>   * @data:	data sector buffer
> @@ -1276,7 +1277,6 @@ static int erased_sector_bitflips(u_char *data,=
 u_char *oob,
>  	return flip_bits;
>  }
>=20
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  /**
>   * omap_elm_correct_data - corrects page data area in case error rep=
orted
>   * @mtd:	MTD device structure
> --
> 1.8.3.2
