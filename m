From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2 v2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Wed, 13 Mar 2013 09:51:08 +0100
Message-ID: <51403DFC.90609@ti.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com> <1363126934-8754-2-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36421 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224Ab3CMIvO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 04:51:14 -0400
In-Reply-To: <1363126934-8754-2-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, linux-omap@vger.kernel.org

On 03/12/2013 11:22 PM, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gott=
en
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.

I can test this tomorrow, but I have one comment:

>=20
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index 35f3ad0..62022c0 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -291,6 +291,10 @@ static struct platform_device sdp4430_leds_pwm =3D=
 {
>  	},
>  };
> =20
> +/* Dummy regulator for pwm-backlight driver */
> +static struct regulator_consumer_supply backlight_supply =3D
> +	REGULATOR_SUPPLY("enable", NULL);

'enable' is just too generic, the device name should be also provided:
	REGULATOR_SUPPLY("enable", "pwm-backlight");

> +
>  static struct platform_pwm_backlight_data sdp4430_backlight_data =3D=
 {
>  	.max_brightness =3D 127,
>  	.dft_brightness =3D 127,
> @@ -718,6 +722,7 @@ static void __init omap_4430sdp_init(void)
> =20
>  	omap4_i2c_init();
>  	omap_sfh7741prox_init();
> +	regulator_register_always_on(-1, "bl-enable", &backlight_supply, 1,=
 0);
>  	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
