From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/2] mfd: twl4030-power: use
 'ti,system-power-controller' as alternative way to support system power off
Date: Wed, 17 Sep 2014 14:39:23 -0700
Message-ID: <20140917213923.GT30918@lee--X1>
References: <1410957252-764-1-git-send-email-nm@ti.com>
 <1410957252-764-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410957252-764-3-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 17 Sep 2014, Nishanth Menon wrote:

> ti,system-power-controller is more or less the standard way of
> indicating that the PMIC is the system wide power controller and henc=
e
> may be used to switch off the system. Almost ALL TI PMIC drivers and
> many Maxim PMIC drivers follow the same style.
>=20
> So support 'ti,system-power-controller' in addition to the usual
> 'ti,use_poweroff' to indicate that the PMIC instance has control for
> switching off the system.
>=20
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>=20
> V2: no change, picked up Tony's ack.
> V1: https://patchwork.kernel.org/patch/4836371/
>  drivers/mfd/twl4030-power.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 3bc969a..1c129ba 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -627,6 +627,9 @@ static bool twl4030_power_use_poweroff(const stru=
ct twl4030_power_data *pdata,
>  	if (pdata && pdata->use_poweroff)
>  		return true;
> =20
> +	if (of_property_read_bool(node, "ti,system-power-controller"))
> +		return true;
> +
>  	if (of_property_read_bool(node, "ti,use_poweroff"))
>  		return true;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
