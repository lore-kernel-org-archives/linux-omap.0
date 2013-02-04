From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Mon, 4 Feb 2013 09:54:52 +0100
Message-ID: <510F775C.6010404@ti.com>
References: <51090829.1010109@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961Ab3BDIzG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 03:55:06 -0500
In-Reply-To: <51090829.1010109@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: tony@atomide.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/30/2013 12:46 PM, Chen Gang wrote:
>=20
>   the fields must be null-terminated:
>   the caller may use it as null-terminted string, next.
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/mach-omap2/twl-common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/t=
wl-common.c
> index e49b40b..6a7aec6 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -23,6 +23,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/gpio.h>
> +#include <linux/string.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
> =20
> @@ -56,7 +57,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
>  			   struct twl4030_platform_data *pmic_data)
>  {
>  	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_O=
=46F_WAKEUPENABLE);
> -	strncpy(pmic_i2c_board_info.type, pmic_type,
> +	strlcpy(pmic_i2c_board_info.type, pmic_type,
>  		sizeof(pmic_i2c_board_info.type));
>  	pmic_i2c_board_info.irq =3D pmic_irq;
>  	pmic_i2c_board_info.platform_data =3D pmic_data;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
