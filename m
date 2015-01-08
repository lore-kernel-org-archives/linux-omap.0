From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable misc options for
 BeagleBoard-X15 platform
Date: Thu, 8 Jan 2015 15:59:43 -0600
Message-ID: <20150108215943.GW31926@saruman>
References: <1420751680-21230-1-git-send-email-nm@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CpBQqYjq/d0HQTAP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756129AbbAHWAn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 17:00:43 -0500
Content-Disposition: inline
In-Reply-To: <1420751680-21230-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--CpBQqYjq/d0HQTAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2015 at 03:14:40PM -0600, Nishanth Menon wrote:
> BeagleBoard-X15 has options such as rtc, fan that need to be functional
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>=20
> Applies on
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> branch:
> omap-for-v3.20/defconfig  4af41284e83c ARM: omap2plus_defconfig: enable T=
PS65218 power button
>=20
>  erch/arm/configs/omap2plus_defconfig |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index b5ccb36c599b..3435e6043710 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -184,6 +184,7 @@ CONFIG_TOUCHSCREEN_TSC2007=3Dm
>  CONFIG_INPUT_MISC=3Dy
>  CONFIG_INPUT_TPS65218_PWRBUTTON=3Dm
>  CONFIG_INPUT_TWL4030_PWRBUTTON=3Dm
> +CONFIG_INPUT_PALMAS_PWRBUTTON=3Dm
>  CONFIG_SERIO=3Dm
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_8250=3Dy
> @@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=3Dy
>  CONFIG_DEBUG_GPIO=3Dy
>  CONFIG_GPIO_SYSFS=3Dy
>  CONFIG_GPIO_TWL4030=3Dy
> +CONFIG_GPIO_PALMAS=3Dy
>  CONFIG_W1=3Dm
>  CONFIG_HDQ_MASTER_OMAP=3Dm
>  CONFIG_BATTERY_BQ27x00=3Dm
> @@ -216,6 +218,7 @@ CONFIG_CHARGER_BQ24735=3Dm
>  CONFIG_POWER_RESET=3Dy
>  CONFIG_POWER_AVS=3Dy
>  CONFIG_HWMON=3Dm
> +CONFIG_SENSORS_GPIO_FAN=3Dm
>  CONFIG_SENSORS_LM75=3Dm
>  CONFIG_SENSORS_TMP102=3Dm
>  CONFIG_THERMAL=3Dm
> @@ -346,6 +349,8 @@ CONFIG_LEDS_TRIGGER_CPU=3Dy
>  CONFIG_LEDS_TRIGGER_GPIO=3Dm
>  CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
>  CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_DRV_DS1307=3Dm
> +CONFIG_RTC_DRV_PALMAS=3Dm
>  CONFIG_RTC_DRV_TWL92330=3Dy
>  CONFIG_RTC_DRV_TWL4030=3Dm
>  CONFIG_RTC_DRV_OMAP=3Dm
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--CpBQqYjq/d0HQTAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrv3PAAoJEIaOsuA1yqREUNwP/3OjMExvnF2gg7fxOefYLebl
AJvNThT20D4F0mAI6iVm/c3H2dhqCX/CB+h1pjDLlud9uqKVNtODdUT4unOGASQy
ie7D9eGMzgdFDt0kKqXc3ScoopCjfhViXNgkbMnOvN/AY9CUzHnzRUGhmmLmRYIl
pnxk3OhJfy03PmRgihbD5ZyLJgqjf4+kLvyDAvyY8XNXKvQfCStElBAh0EENW8n0
sEF81SCots2n1g04KKQLpn7A0krouV+xkv/58C56f0ep9yWhoux5NVotb+k9Lwwp
WwCHVFK57cSlyMaSiR0mRRKsG3VzQRlG4RgCpC8Qst01YtwBZaJbbthq190Q5AaQ
qcQRX/t1lr6C1HfI7cmdXGOxp0YZvjNK2lpQDTA3siDaX7xIkkKPy62Xi5pEPvLb
IBMhVCji6rurGghfbeutp0Km/tjD4LDojPHuGgWejAFjbwgKoKra7ECKJ9Ss4seg
CKZXUpFZC3JuUB7c5F0EhU/oMJAOCUU82BkhweUHcVcDE885igniyh/GJ+2s6GWd
anUjqEanRfu00j/T05/rQi2lJKQs8QczsEBUwyxrEyBB3yFR7huAeR4ZYvfjp67I
2sL5SRX6O9a78wYADNRZBNh9wgEwsbiGo2EN4BTVHHh/4eHjtGCEOa5WklSvyJ27
pVaq6iRk2wIhPGmOhWUr
=ixWY
-----END PGP SIGNATURE-----

--CpBQqYjq/d0HQTAP--
