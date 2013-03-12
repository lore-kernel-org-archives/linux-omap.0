From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight
Date: Tue, 12 Mar 2013 10:24:15 +0100
Message-ID: <513EF43F.4030107@ti.com>
References: <1363053266-515-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37295 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab3CLJYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 05:24:21 -0400
In-Reply-To: <1363053266-515-1-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, linux-omap@vger.kernel.org

Hi,

On 03/12/2013 02:54 AM, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gott=
en
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.

Can you point me to the commit which makes a regulator mandatory for
pwm-backlight?
Why the regulator is mandatory?
The 4430SDP (or Blaze) and Zoom2 is just happy alone with the PWM why s=
hould
we have dummy regulators?

>=20
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
> This patch, along with many more soon to follow, attempts to satisfy =
the new
> mandatory regulator that pwm-backlight will grab during probe.  The o=
nly
> board in mach-omap2 to use the pwm-backlight appears to be the 4430sd=
p.
>=20
> I thought I'd start small and use this board as an example.
>=20
> I tested similar code in my Tegra board, so it should be okay.  Of co=
urse,
> I don't have a 4430sdp to test with.
>=20
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
