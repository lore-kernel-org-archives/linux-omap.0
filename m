From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1a/4] mfd: twl4030-power: Add generic reset configuration
Date: Mon, 28 Apr 2014 12:37:21 +0100
Message-ID: <20140428113721.GU21279@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <20140424004955.GG6053@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58478 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbaD1Lh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 07:37:28 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so1394471wes.39
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 04:37:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140424004955.GG6053@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

> The twl4030 PMIC needs to be configured properly for things like
> warm reset and deeper idle states so the PMIC manages the regulators
> properly based on the hardware triggers from the SoC.
>=20
> For example, when rebooting an OMAP3530 at 125 MHz, it hangs.
> With this patch, TWL4030 will be reset when a warm reset occures.
> This way the OMAP3530 does not hang on reboot.
>=20
> Let's use this as the default when compatible =3D "ti,twl4030-power".
> Other more complicated configurations can be added to the driver
> based on other compatible flags.
>=20
> Based on earlier patch by Matthias Brugger <matthias.bgg@gmail.com>:
>=20
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/14=
4161.html
>=20
> For more information about twl4030 configuration for the
> "power scripts" see:
>=20
> http://www.omappedia.com/wiki/TWL4030_power_scripts
>=20
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> Sorry this got accidentally left out, should be the first patch
> in the series.
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt =
b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> index 8e15ec3..b906116 100644
> --- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> +++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> @@ -5,7 +5,12 @@ to control the power resources, including power scri=
pts. For now, the
>  binding only supports the complete shutdown of the system after powe=
roff.
> =20
>  Required properties:
> -- compatible : must be "ti,twl4030-power"
> +- compatible : must be one of the following
> +	"ti,twl4030-power"
> +	"ti,twl4030-power-reset"
> +

I think it'll be sensible to wait for a DT Ack for this kind of
change.


> +#ifdef CONFIG_OF
> +
> +/* Generic warm reset configuration for omap3 */
> +
> +static struct twl4030_ins omap3_wrst_seq[] =3D {
> +	{ MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2 },
> +	{ MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2 },
> +};

Nit: I'd prefer the number formatting to be unified here i.e. all in
the same base, all <0x10 with leading zero.
=20
> +static struct twl4030_script omap3_wrst_script =3D {
> +	.script	=3D omap3_wrst_seq,
> +	.size	=3D ARRAY_SIZE(omap3_wrst_seq),
> +	.flags	=3D TWL4030_WRST_SCRIPT,
> +};
> +
> +static struct twl4030_script *omap3_reset_scripts[] =3D {
> +	&omap3_wrst_script,
> +};
> +
> +static struct twl4030_resconfig omap3_rconfig[] =3D {
> +	{ .resource =3D RES_HFCLKOUT, .devgroup =3D DEV_GRP_P3, .type =3D -=
1,
> +	  .type2 =3D -1 },
> +	{ .resource =3D RES_VDD1, .devgroup =3D DEV_GRP_P1, .type =3D -1,
> +	  .type2 =3D -1 },
> +	{ .resource =3D RES_VDD2, .devgroup =3D DEV_GRP_P1, .type =3D -1,
> +	  .type2 =3D -1 },
> +	{ 0, 0},
> +};

Nit: May be just my OCD, but this looks a little messy. Perhaps a
simple MACRO might tidy things up, although that seems a little
over-kill for such a small sturct[]. At the very least least please
even up the brackets in the sentinel.

/me goes to organise his soup tins into alphabetical order.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
