From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv2] ti-soc-thermal: implement omap3 support
Date: Tue, 7 Apr 2015 11:57:31 -0700
Message-ID: <20150407185718.GA4203@localhost.localdomain>
References: <20150103114632.GA21883@amd>
 <20150118202447.GA29014@amd>
 <20150331084234.GA11712@amd>
 <20150402144907.GB11687@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150402144907.GB11687@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2015 at 04:49:07PM +0200, Pavel Machek wrote:
>=20
>=20
> This adds support for OMAP3 chips to ti-soc-thermal. As requested by
> TI people, it is marked unreliable and warning is printed.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---
>=20
> Patch is against thermal linus tree, please apply so that it has
> chance for 4.1.
>=20
> v2: fixed min/max temp
>=20
> diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-=
soc-thermal/Kconfig
> index bd4c7be..d414c2d 100644
> --- a/drivers/thermal/ti-soc-thermal/Kconfig
> +++ b/drivers/thermal/ti-soc-thermal/Kconfig
> @@ -21,6 +21,21 @@ config TI_THERMAL
>  	  This includes trip points definitions, extrapolation rules and
>  	  CPU cooling device bindings.
> =20
> +config OMAP3_THERMAL
> +	bool "Texas Instruments OMAP3 thermal support"
> +	depends on TI_SOC_THERMAL
> +	depends on ARCH_OMAP3
> +	help
> +	  If you say yes here you get thermal support for the Texas Instruments
> +	  OMAP3 SoC family. The current chips supported are:
> +	   - OMAP3430
> +
> +	  OMAP3 chips normally don't need thermal management, and sensors in
> +	  this generation are not accurate, nor they are very close to
> +	  the important hotspots.
> +
> +	  Say 'N' here.
> +
>  config OMAP4_THERMAL
>  	bool "Texas Instruments OMAP4 thermal support"
>  	depends on TI_SOC_THERMAL
> diff --git a/drivers/thermal/ti-soc-thermal/Makefile b/drivers/thermal/ti=
-soc-thermal/Makefile
> index 1226b24..0f89bdf 100644
> --- a/drivers/thermal/ti-soc-thermal/Makefile
> +++ b/drivers/thermal/ti-soc-thermal/Makefile
> @@ -2,5 +2,6 @@ obj-$(CONFIG_TI_SOC_THERMAL)		+=3D ti-soc-thermal.o
>  ti-soc-thermal-y			:=3D ti-bandgap.o
>  ti-soc-thermal-$(CONFIG_TI_THERMAL)	+=3D ti-thermal-common.o
>  ti-soc-thermal-$(CONFIG_DRA752_THERMAL)	+=3D dra752-thermal-data.o
> +ti-soc-thermal-$(CONFIG_OMAP3_THERMAL)	+=3D omap3-thermal-data.o
>  ti-soc-thermal-$(CONFIG_OMAP4_THERMAL)	+=3D omap4-thermal-data.o
>  ti-soc-thermal-$(CONFIG_OMAP5_THERMAL)	+=3D omap5-thermal-data.o
> diff --git a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c b/driver=
s/thermal/ti-soc-thermal/omap3-thermal-data.c
> new file mode 100644
> index 0000000..86a4e2d
> --- /dev/null
> +++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
> @@ -0,0 +1,103 @@
> +/*
> + * OMAP3 thermal driver.
> + *
> + * Copyright (C) 2011-2012 Texas Instruments Inc.
> + * Copyright (C) 2014 Pavel Machek <pavel@ucw.cz>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * Note
> + * http://www.ti.com/lit/er/sprz278f/sprz278f.pdf "Advisory
> + * 3.1.1.186 MMC OCP Clock Not Gated When Thermal Sensor Is Used"
> + *
> + * Also TI says:
> + * Just be careful when you try to make thermal policy like decisions
> + * based on this sensor. Placement of the sensor w.r.t the actual logic
> + * generating heat has to be a factor as well. If you are just looking
> + * for an approximation temperature (thermometerish kind), you might be
> + * ok with this. I am not sure we'd find any TI data around this.. just a
> + * heads up.
> + */
> +
> +#include "ti-thermal.h"
> +#include "ti-bandgap.h"
> +
> +/*
> + * OMAP34XX has one instance of thermal sensor for MPU
> + * need to describe the individual bit fields
> + */
> +static struct temp_sensor_registers
> +omap34xx_mpu_temp_sensor_registers =3D {
> +	.temp_sensor_ctrl =3D 0,
> +	.bgap_soc_mask =3D BIT(8),
> +	.bgap_eocz_mask =3D BIT(7),
> +	.bgap_dtemp_mask =3D 0x7f,
> +
> +	.bgap_mode_ctrl =3D 0,
> +	.mode_ctrl_mask =3D BIT(9),
> +};
> +
> +/* Thresholds and limits for OMAP34XX MPU temperature sensor */
> +static struct temp_sensor_data omap34xx_mpu_temp_sensor_data =3D {
> +	.min_freq =3D 32768,
> +	.max_freq =3D 32768,
> +	.max_temp =3D 125000,
> +	.min_temp =3D -40000,
> +	.hyst_val =3D 5000,
> +};
> +
> +/*
> + * Temperature values in milli degree celsius
> + */
> +static const int
> +omap34xx_adc_to_temp[128] =3D {
> +	-40000, -40000, -40000, -40000, -40000, -39000, -38000, -36000,
> +	-34000, -32000, -31000,	-29000, -28000, -26000, -25000, -24000,
> +	-22000, -21000, -19000, -18000, -17000, -15000,	-14000, -12000,
> +	-11000, -9000, -8000, -7000, -5000, -4000, -2000, -1000, 0000,
> +	1000, 3000, 4000, 5000, 7000, 8000, 10000, 11000, 13000, 14000,
> +	15000, 17000, 18000, 20000, 21000, 22000, 24000, 25000, 27000,
> +	28000, 30000, 31000, 32000, 34000, 35000, 37000, 38000, 39000,
> +	41000, 42000, 44000, 45000, 47000, 48000, 49000, 51000, 52000,
> +	53000, 55000, 56000, 58000, 59000, 60000, 62000, 63000, 65000,
> +	66000, 67000, 69000, 70000, 72000, 73000, 74000, 76000, 77000,
> +	79000, 80000, 81000, 83000, 84000, 85000, 87000, 88000, 89000,
> +	91000, 92000, 94000, 95000, 96000, 98000, 99000, 100000,
> +	102000, 103000, 105000, 106000, 107000, 109000, 110000, 111000,
> +	113000, 114000, 116000, 117000, 118000, 120000, 121000, 122000,
> +	124000, 124000, 125000, 125000, 125000, 125000,	125000
> +};
> +
> +/* OMAP34XX data */
> +const struct ti_bandgap_data omap34xx_data =3D {
> +	.features =3D TI_BANDGAP_FEATURE_CLK_CTRL | TI_BANDGAP_FEATURE_UNRELIAB=
LE,
> +	.fclock_name =3D "ts_fck",
> +	.div_ck_name =3D "ts_fck",
> +	.conv_table =3D omap34xx_adc_to_temp,
> +	.adc_start_val =3D 0,
> +	.adc_end_val =3D 127,
> +	.expose_sensor =3D ti_thermal_expose_sensor,
> +	.remove_sensor =3D ti_thermal_remove_sensor,
> +
> +	.sensors =3D {
> +		{
> +		.registers =3D &omap34xx_mpu_temp_sensor_registers,
> +		.ts_data =3D &omap34xx_mpu_temp_sensor_data,
> +		.domain =3D "cpu",
> +		.slope =3D 0,
> +		.constant =3D 20000,
> +		.slope_pcb =3D 0,
> +		.constant_pcb =3D 20000,
> +		.register_cooling =3D NULL,
> +		.unregister_cooling =3D NULL,
> +		},
> +	},
> +	.sensor_count =3D 1,
> +};
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.c
> index 63e2f5c..a58610d 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1200,6 +1195,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
>  	}
>  	bgp->dev =3D &pdev->dev;
> =20
> +	if (TI_BANDGAP_HAS(bgp, UNRELIABLE))
> +		dev_warn(&pdev->dev,
> +			 "OMAP3 thermal sensor is unreliable and normally unneccessary\n");
		For now we have only one unreliable sensor. But once one
		is in, I am pretty sure other people will ask for more
		:-). Therefore, I am accepting this patch but with the
		message like this:
+		dev_warn(&pdev->dev,
+			 "This OMAP thermal sensor is unreliable. You've been warned\n");

> +
>  	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
>  		ret =3D ti_bandgap_tshut_init(bgp, pdev);
>  		if (ret) {
> @@ -1505,6 +1504,12 @@ static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti=
_bandgap_suspend,
>  #endif
> =20
>  static const struct of_device_id of_ti_bandgap_match[] =3D {
> +#ifdef CONFIG_OMAP3_THERMAL
> +	{
> +		.compatible =3D "ti,omap34xx-bandgap",
> +		.data =3D (void *)&omap34xx_data,
> +	},
> +#endif
>  #ifdef CONFIG_OMAP4_THERMAL
>  	{
>  		.compatible =3D "ti,omap4430-bandgap",
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.h
> index b3adf72..15878a1 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -331,6 +331,7 @@ struct ti_temp_sensor {
>  #define TI_BANDGAP_FEATURE_FREEZE_BIT		BIT(7)
>  #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
>  #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
> +#define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(10)
>  #define TI_BANDGAP_HAS(b, f)			\
>  			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
> =20
> @@ -384,6 +385,12 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bg=
p, int id, void *data);
>  void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id);
>  int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
> =20
> +#ifdef CONFIG_OMAP3_THERMAL
> +extern const struct ti_bandgap_data omap34xx_data;
> +#else
> +#define omap34xx_data					NULL
> +#endif
> +
>  #ifdef CONFIG_OMAP4_THERMAL
>  extern const struct ti_bandgap_data omap4430_data;
>  extern const struct ti_bandgap_data omap4460_data;
> diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt=
 b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
> index 0c9222d..3cf8a3b 100644
> --- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
> @@ -10,6 +10,7 @@ to the silicon temperature.
> =20
>  Required properties:
>  - compatible : Should be:
> +  - "ti,omap34xx-bandgap" : for OMAP34xx bandgap
>    - "ti,omap4430-bandgap" : for OMAP4430 bandgap
>    - "ti,omap4460-bandgap" : for OMAP4460 bandgap
>    - "ti,omap4470-bandgap" : for OMAP4470 bandgap
>=20
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVJCiBAAoJEMLUO4d9pOJWbBAH/i9cZMSZTSyCA1x9x16SypJG
hFm7BvsVREiXmR5mnpgcZwo4riDaRn4ZJLPsH2W8fb7hTWBAMKnqLzf4SsGJiV22
1h7vpXGSok0Q0O4Pa838QYdhwm39ixAxLADOlbMQaUwUWVgqvrcLLTBM245WUnxs
LG4hAZL19kbdFau84YhgyoNTysd+AvA8m4EjiKjZmzADjxOnyy6xlq3DBU5SXyNA
TVUb2ZhMso4FsYCR58g8b/ZqA1diyRhJWsfTdS3guM+yyjwtLdsuJno3aX/E1D1S
5ZqxoiASECQRMHTFi1j4M3YiBln/czlkpIvfjN29+prMChdT2J9BAdNMkdoftdI=
=FGrt
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
