From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 7/7] ARM: OMAP2+: Handle reset quirks for dynamically
 allocated modules
Date: Thu, 28 Mar 2019 01:28:22 +0100
Message-ID: <20190328002822.zbgimqsrilr2ysm7@earth.universe>
References: <20190325183819.15400-1-tony@atomide.com>
 <20190325183819.15400-8-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2340479736052925093=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325183819.15400-8-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2340479736052925093==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4biuw2rywrdqapmi"
Content-Disposition: inline


--4biuw2rywrdqapmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2019 at 11:38:19AM -0700, Tony Lindgren wrote:
> For dynamically allocated struct omap_hwmod data, we need to populate
> the device IP specific reset quirks.
>=20
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/common.h              |  9 +++
>  arch/arm/mach-omap2/omap_hwmod.c          | 70 +++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  2 +-
>  3 files changed, 80 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -336,6 +336,15 @@ static inline void omap5_secondary_hyp_startup(void)
>  }
>  #endif
> =20
> +#ifdef CONFIG_SOC_DRA7XX
> +extern int dra7xx_pciess_reset(struct omap_hwmod *oh);
> +#else
> +static inline int dra7xx_pciess_reset(struct omap_hwmod *oh)
> +{
> +	return 0;
> +}
> +#endif
> +
>  void pdata_quirks_init(const struct of_device_id *);
>  void omap_auxdata_legacy_init(struct device *dev);
>  void omap_pcs_legacy_init(int irq, void (*rearm)(void));
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_=
hwmod.c
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -155,6 +155,8 @@
>  #include "soc.h"
>  #include "common.h"
>  #include "clockdomain.h"
> +#include "hdq1w.h"
> +#include "mmc.h"
>  #include "powerdomain.h"
>  #include "cm2xxx.h"
>  #include "cm3xxx.h"
> @@ -165,6 +167,7 @@
>  #include "prm33xx.h"
>  #include "prminst44xx.h"
>  #include "pm.h"
> +#include "wd_timer.h"
> =20
>  /* Name of the OMAP hwmod for the MPU */
>  #define MPU_INITIATOR_NAME		"mpu"
> @@ -204,6 +207,20 @@ struct clkctrl_provider {
> =20
>  static LIST_HEAD(clkctrl_providers);
> =20
> +/**
> + * struct omap_hwmod_reset - IP specific reset functions
> + * @match: string to match against the module name
> + * @len: number of characters to match
> + * @reset: IP specific reset function
> + *
> + * Used only in cases where struct omap_hwmod is dynamically allocated.
> + */
> +struct omap_hwmod_reset {
> +	const char *match;
> +	int len;
> +	int (*reset)(struct omap_hwmod *oh);
> +};
> +
>  /**
>   * struct omap_hwmod_soc_ops - fn ptrs for some SoC-specific operations
>   * @enable_module: function to enable a module (via MODULEMODE)
> @@ -3542,6 +3559,57 @@ static int omap_hwmod_allocate_module(struct devic=
e *dev, struct omap_hwmod *oh,
>  	return 0;
>  }
> =20
> +static const struct omap_hwmod_reset omap24xx_reset_quirks[] =3D {
> +	{ .match =3D "msdi", .len =3D 3, .reset =3D omap_msdi_reset, },

len("msdi") =3D 4

> +};
> +
> +static const struct omap_hwmod_reset dra7_reset_quirks[] =3D {
> +	{ .match =3D "pcie", .len =3D 4, .reset =3D dra7xx_pciess_reset, },
> +};
> +
> +static const struct omap_hwmod_reset omap_reset_quirks[] =3D {
> +	{ .match =3D "dss", .len =3D 3, .reset =3D omap_dss_reset, },
> +	{ .match =3D "hdq1w", .len =3D 5, .reset =3D omap_hdq1w_reset, },
> +	{ .match =3D "i2c", .len =3D 3, .reset =3D omap_i2c_reset, },
> +	{ .match =3D "wd_timer", .len =3D 8, .reset =3D omap2_wd_timer_reset, },
> +};
> +
> +static void
> +omap_hwmod_init_reset_quirk(struct device *dev, struct omap_hwmod *oh,
> +			    const struct ti_sysc_module_data *data,
> +			    const struct omap_hwmod_reset *quirks,
> +			    int quirks_sz)
> +{
> +	const struct omap_hwmod_reset *quirk;
> +	int i;
> +
> +	for (i =3D 0; i < quirks_sz; i++) {
> +		quirk =3D &quirks[i];
> +		if (!strncmp(data->name, quirk->match, quirk->len)) {
> +			oh->class->reset =3D quirk->reset;
> +
> +			return;
> +		}
> +	}
> +}
> +
> +static void
> +omap_hwmod_init_reset_quirks(struct device *dev, struct omap_hwmod *oh,
> +			     const struct ti_sysc_module_data *data)
> +{
> +	if (soc_is_omap24xx())
> +		omap_hwmod_init_reset_quirk(dev, oh, data,
> +					    omap24xx_reset_quirks,
> +					    ARRAY_SIZE(omap24xx_reset_quirks));
> +
> +	if (!soc_is_dra7xx())

s/!soc_is/soc_is/ ?

> +		omap_hwmod_init_reset_quirk(dev, oh, data, dra7_reset_quirks,
> +					    ARRAY_SIZE(dra7_reset_quirks));
> +
> +	omap_hwmod_init_reset_quirk(dev, oh, data, omap_reset_quirks,
> +				    ARRAY_SIZE(omap_reset_quirks));
> +}
> +
>  /**
>   * omap_hwmod_init_module - initialize new module
>   * @dev: struct device
> @@ -3580,6 +3648,8 @@ int omap_hwmod_init_module(struct device *dev,
>  			return -ENOMEM;
>  		}
> =20
> +		omap_hwmod_init_reset_quirks(dev, oh, data);
> +
>  		oh->class->name =3D data->name;
>  		mutex_lock(&list_lock);
>  		error =3D _register(oh);
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-om=
ap2/omap_hwmod_7xx_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1828,7 +1828,7 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod =3D {
>   * We use a PCIeSS HWMOD class specific reset handler to deassert the ha=
rdreset
>   * lines after asserting them.
>   */
> -static int dra7xx_pciess_reset(struct omap_hwmod *oh)
> +int dra7xx_pciess_reset(struct omap_hwmod *oh)
>  {
>  	int i;

-- Sebastian

--4biuw2rywrdqapmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlycFR8ACgkQ2O7X88g7
+pqyAw//R/155mrYJJSz087h51mb1u9EbgmZ22Ys9EnwVfE7f1LjhGm6Ju3/+IIP
8XwChPTJ+Q2e0rhgzM3YsEpMvrlVQ0y9Znca/GsDgyGZGr5sC30SiVuNxD8iwmfN
2RhLLYjG7RxxG5XXZFXd9ibgByCbsGdlBaU02RhSKpNsu/+Bw4lHPzEBQojbmsaF
w+hz0LRU17QgdKkPCEiHSHstTvTRMN8FGoUfPZlzhDzESkHup0T9isjKda54byJ1
Uuow6nvfC+cOG2Ss/JdO8EA+L7rdFKJSrIb715yUKNn1IMnB85+lNZynI+E9KSuY
s9+ttsX0lWm7Wr11PTuHpXQ1dq1cgz0Jv+t0+sofhBgMqR4SZpkXEOnTg0W9/8gu
YTEGV4KDdv+eVbBCJ9NBfKW/tMRYIUNmqPvjHkwxRb7y+9MYePkHh9jcVZZlIB5V
fF3mBWtePySbZ0KFn0li6RS+b4wImJQMrKqkH+fyrePAUiD91UlWXDibCW7v0B8e
U6Kt5Xx/ZOgAA3e9JQtiBB29eJ8w34B1w9RgNakq6XQQs6p43X9Q7PYO+EZI96r1
GXFdmM3kGWARsvsXKMdutukpw6bUS6MkXPJdaCH/eO76kS5Ze/REEBXYdWCgcJUF
K7TGcfxzDGmkedFKaI4HeYP/YyCdpfCUYfdiKTs0iyqGRWNxf+w=
=JWjZ
-----END PGP SIGNATURE-----

--4biuw2rywrdqapmi--


--===============2340479736052925093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2340479736052925093==--
