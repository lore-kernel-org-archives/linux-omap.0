From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 16/33] Removing dead APM
Date: Wed, 30 Jun 2010 20:23:47 +0200
Message-ID: <201006302023.47382.marek.vasut@gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de> <51c095a4c49baacbfdd6ed332d1375ab64209753.1277911346.git.siccegge@cs.fau.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51c095a4c49baacbfdd6ed332d1375ab64209753.1277911346.git.siccegge@cs.fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Egger <siccegge@cs.fau.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kalle Valo <kalle.valo@iki.fi>, Ladislav Michl <ladis@linux-mips.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
List-Id: linux-omap@vger.kernel.org

Dne St 30. =C4=8Dervna 2010 17:59:06 Christoph Egger napsal(a):
> APM doesn't exist in Kconfig, therefore removing all references for i=
t
> from the source code.

Tony, do you know Andrzej Zaborowski's new email address? Maybe he shou=
ld be=20
CCed here
>=20
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap1/board-palmte.c |   84
> ------------------------------------ 1 files changed, 0 insertions(+)=
, 84
> deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/board-palmte.c
> b/arch/arm/mach-omap1/board-palmte.c index 569b4c9..23bb0c9 100644
> --- a/arch/arm/mach-omap1/board-palmte.c
> +++ b/arch/arm/mach-omap1/board-palmte.c
> @@ -213,90 +213,6 @@ static struct omap_lcd_config palmte_lcd_config
> __initdata =3D { .ctrl_name	=3D "internal",
>  };
>=20
> -#ifdef CONFIG_APM
> -/*
> - * Values measured in 10 minute intervals averaged over 10 samples.
> - * May differ slightly from device to device but should be accurate
> - * enough to give basic idea of battery life left and trigger
> - * potential alerts.
> - */
> -static const int palmte_battery_sample[] =3D {
> -	2194, 2157, 2138, 2120,
> -	2104, 2089, 2075, 2061,
> -	2048, 2038, 2026, 2016,
> -	2008, 1998, 1989, 1980,
> -	1970, 1958, 1945, 1928,
> -	1910, 1888, 1860, 1827,
> -	1791, 1751, 1709, 1656,
> -};
> -
> -#define INTERVAL		10
> -#define BATTERY_HIGH_TRESHOLD	66
> -#define BATTERY_LOW_TRESHOLD	33
> -
> -static void palmte_get_power_status(struct apm_power_info *info, int
> *battery) -{
> -	int charging, batt, hi, lo, mid;
> -
> -	charging =3D !gpio_get_value(PALMTE_DC_GPIO);
> -	batt =3D battery[0];
> -	if (charging)
> -		batt -=3D 60;
> -
> -	hi =3D ARRAY_SIZE(palmte_battery_sample);
> -	lo =3D 0;
> -
> -	info->battery_flag =3D 0;
> -	info->units =3D APM_UNITS_MINS;
> -
> -	if (batt > palmte_battery_sample[lo]) {
> -		info->battery_life =3D 100;
> -		info->time =3D INTERVAL * ARRAY_SIZE(palmte_battery_sample);
> -	} else if (batt <=3D palmte_battery_sample[hi - 1]) {
> -		info->battery_life =3D 0;
> -		info->time =3D 0;
> -	} else {
> -		while (hi > lo + 1) {
> -			mid =3D (hi + lo) >> 1;
> -			if (batt <=3D palmte_battery_sample[mid])
> -				lo =3D mid;
> -			else
> -				hi =3D mid;
> -		}
> -
> -		mid =3D palmte_battery_sample[lo] - palmte_battery_sample[hi];
> -		hi =3D palmte_battery_sample[lo] - batt;
> -		info->battery_life =3D 100 - (100 * lo + 100 * hi / mid) /
> -			ARRAY_SIZE(palmte_battery_sample);
> -		info->time =3D INTERVAL * (ARRAY_SIZE(palmte_battery_sample) -
> -				lo) - INTERVAL * hi / mid;
> -	}
> -
> -	if (charging) {
> -		info->ac_line_status =3D APM_AC_ONLINE;
> -		info->battery_status =3D APM_BATTERY_STATUS_CHARGING;
> -		info->battery_flag |=3D APM_BATTERY_FLAG_CHARGING;
> -	} else {
> -		info->ac_line_status =3D APM_AC_OFFLINE;
> -		if (info->battery_life > BATTERY_HIGH_TRESHOLD)
> -			info->battery_status =3D APM_BATTERY_STATUS_HIGH;
> -		else if (info->battery_life > BATTERY_LOW_TRESHOLD)
> -			info->battery_status =3D APM_BATTERY_STATUS_LOW;
> -		else
> -			info->battery_status =3D APM_BATTERY_STATUS_CRITICAL;
> -	}
> -
> -	if (info->battery_life > BATTERY_HIGH_TRESHOLD)
> -		info->battery_flag |=3D APM_BATTERY_FLAG_HIGH;
> -	else if (info->battery_life > BATTERY_LOW_TRESHOLD)
> -		info->battery_flag |=3D APM_BATTERY_FLAG_LOW;
> -	else
> -		info->battery_flag |=3D APM_BATTERY_FLAG_CRITICAL;
> -}
> -#else
> -#define palmte_get_power_status	NULL
> -#endif
> -
>  static struct omap_board_config_kernel palmte_config[] __initdata =3D=
 {
>  	{ OMAP_TAG_LCD,		&palmte_lcd_config },
>  };
