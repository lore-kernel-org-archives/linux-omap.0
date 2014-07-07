From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: Make GPMC skip disabled devices
Date: Mon, 7 Jul 2014 03:51:02 -0700
Message-ID: <20140707105101.GN28884@atomide.com>
References: <20980858CB6D3A4BAE95CA194937D5E73EAF8D44@DBDE04.ent.ti.com>
 <1404308118-14843-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404308118-14843-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: Guido =?utf-8?B?TWFydMOtbmV6?= <guido@vanguardiasur.com.ar>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ezequiel =?utf-8?Q?Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, pekon@ti.com
List-Id: linux-omap@vger.kernel.org

* Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar> [140702 06:34]:
> Currently, child nodes of the gpmc node are iterated and probed
> regardless of their 'status' property. This means adding 'status =3D
> "disabled";' has no effect.
>=20
> This patch changes the iteration to only probe nodes marked as
> available.
>=20
> Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
> ---
> v2: Make patch title consistent with previous gpmc patches

Thanks applying into omap-for-v3.16/fixes.

Tony
=20
>  arch/arm/mach-omap2/gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 2c0c281..8bc1338 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1615,7 +1615,7 @@ static int gpmc_probe_dt(struct platform_device=
 *pdev)
>  		return ret;
>  	}
> =20
> -	for_each_child_of_node(pdev->dev.of_node, child) {
> +	for_each_available_child_of_node(pdev->dev.of_node, child) {
> =20
>  		if (!child->name)
>  			continue;
> --=20
> 2.0.0
>=20
