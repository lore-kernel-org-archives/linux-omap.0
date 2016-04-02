From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 1/8] mfd: twl-core: Rename struct twl4030_platform_data
 to twl_platform_data
Date: Sat, 02 Apr 2016 21:58:33 +0200
Message-ID: <1459627113.12073.24.camel@paulk.fr>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
	 <56FBEEC9.1020508@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-sDOAotwi9TTDR+Dw08/+"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FBEEC9.1020508-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--=-sDOAotwi9TTDR+Dw08/+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 30 mars 2016 =C3=A0 18:20 +0300, Grygorii Strashko a =C3=A9crit=
=C2=A0:
> On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> > Since twl4030_platform_data also holds platform data (e.g. regulators) =
for
> > other
> > TWL chips, it makes sense to rename it to a non-model-specific name.
> >=20
> > This will also allow hooking more platform data structure to it in the
> > future.
>
> Do we really need this patch?
> In general ldb and r51 board files are going to be dropped soon and
> it not expected to support this PMIC devices for non-DT use cases.
> As result twl4030_platform_data will be dropped at all or made private.

I understand. Depending on how soon these legacy boards are dropped, a clea=
nup
might still be a good thing to have. Either way, it doesn't hurt and the pa=
tch
is ready already.

However, I'll refrain from introducing more twl cleanups (which I had plann=
ed on
doing) until we get rid of all the platform data stuff.

> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > ---
> > =C2=A0 arch/arm/mach-omap2/board-ldp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> > =C2=A0 arch/arm/mach-omap2/board-rx51-peripherals.c |=C2=A0=C2=A02 +-
> > =C2=A0 arch/arm/mach-omap2/twl-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A08 ++++----
> > =C2=A0 arch/arm/mach-omap2/twl-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 14 +++++++-------
> > =C2=A0 drivers/mfd/twl-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A04 ++--
> > =C2=A0 include/linux/i2c/twl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A03 ++-
> > =C2=A0 6 files changed, 17 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/boar=
d-
> > ldp.c
> > index d9c3ffc..b8c2e21 100644
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -321,7 +321,7 @@ static struct regulator_init_data ldp_vpll2 =3D {
> > =C2=A0=C2=A0	.consumer_supplies	=3D ldp_vpll2_supplies,
> > =C2=A0 };
> >=20
> > -static struct twl4030_platform_data ldp_twldata =3D {
> > +static struct twl_platform_data ldp_twldata =3D {
> > =C2=A0=C2=A0	/* platform_data for children goes here */
> > =C2=A0=C2=A0	.vmmc1		=3D &ldp_vmmc1,
> > =C2=A0=C2=A0	.vaux1		=3D &ldp_vaux1,
> > diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-
> > omap2/board-rx51-peripherals.c
> > index da174c0..3739bff 100644
> > --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> > @@ -957,7 +957,7 @@ static struct twl4030_audio_data rx51_audio_data
> > __initdata =3D {
> > =C2=A0=C2=A0	.vibra		=3D &rx51_vibra_data,
> > =C2=A0 };
> >=20
> > -static struct twl4030_platform_data rx51_twldata __initdata =3D {
> > +static struct twl_platform_data rx51_twldata __initdata =3D {
> > =C2=A0=C2=A0	/* platform_data for children goes here */
> > =C2=A0=C2=A0	.gpio			=3D &rx51_gpio_data,
> > =C2=A0=C2=A0	.keypad			=3D &rx51_kp_data,
> > diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl=
-
> > common.c
> > index 292eca0..4e6532f 100644
> > --- a/arch/arm/mach-omap2/twl-common.c
> > +++ b/arch/arm/mach-omap2/twl-common.c
> > @@ -55,7 +55,7 @@ static int twl_get_voltage(void *data)
> >=20
> > =C2=A0 void __init omap_pmic_init(int bus, u32 clkrate,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0const char *pmic_type, int pmic_irq,
> > -			=C2=A0=C2=A0=C2=A0struct twl4030_platform_data *pmic_data)
> > +			=C2=A0=C2=A0=C2=A0struct twl_platform_data *pmic_data)
> > =C2=A0 {
> > =C2=A0=C2=A0	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP |
> > OMAP_PIN_OFF_WAKEUPENABLE);
> > =C2=A0=C2=A0	strlcpy(pmic_i2c_board_info.type, pmic_type,
> > @@ -68,7 +68,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
> >=20
> > =C2=A0 #ifdef CONFIG_ARCH_OMAP4
> > =C2=A0 void __init omap4_pmic_init(const char *pmic_type,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0struct twl4030_platform_data *pmic_data,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0struct twl_platform_data *pmic_data,
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_board_info *devices, i=
nt nr_devices)
> > =C2=A0 {
> > =C2=A0=C2=A0	/* PMIC part*/
> > @@ -205,7 +205,7 @@ static struct twl_regulator_driver_data
> > omap3_vdd2_drvdata =3D {
> > =C2=A0=C2=A0	.set_voltage =3D twl_set_voltage,
> > =C2=A0 };
> >=20
> > -void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_d=
ata,
> > +void __init omap3_pmic_get_config(struct twl_platform_data *pmic_data,
> > =C2=A0=C2=A0				=C2=A0=C2=A0u32 pdata_flags, u32 regulators_flags)
> > =C2=A0 {
> > =C2=A0=C2=A0	if (!pmic_data->vdd1) {
> > @@ -470,7 +470,7 @@ static struct regulator_init_data omap4_v2v1_idata =
=3D {
> > =C2=A0=C2=A0	.consumer_supplies	=3D omap4_v2v1_supply,
> > =C2=A0 };
> >=20
> > -void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_d=
ata,
> > +void __init omap4_pmic_get_config(struct twl_platform_data *pmic_data,
> > =C2=A0=C2=A0				=C2=A0=C2=A0u32 pdata_flags, u32 regulators_flags)
> > =C2=A0 {
> > =C2=A0=C2=A0	if (!pmic_data->vdd1) {
> > diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl=
-
> > common.h
> > index 24b65d0..e7caa23 100644
> > --- a/arch/arm/mach-omap2/twl-common.h
> > +++ b/arch/arm/mach-omap2/twl-common.h
> > @@ -30,35 +30,35 @@
> > =C2=A0 #define TWL_COMMON_REGULATOR_VPLL2	(1 << 5)
> >=20
> >=20
> > -struct twl4030_platform_data;
> > +struct twl_platform_data;
> > =C2=A0 struct twl6040_platform_data;
> > =C2=A0 struct omap_tw4030_pdata;
> > =C2=A0 struct i2c_board_info;
> >=20
> > =C2=A0 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type,=
 int
> > pmic_irq,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0struct twl4030_platform_data *pmic_data);
> > +		=C2=A0=C2=A0=C2=A0=C2=A0struct twl_platform_data *pmic_data);
> > =C2=A0 void omap_pmic_late_init(void);
> >=20
> > =C2=A0 static inline void omap2_pmic_init(const char *pmic_type,
> > -				=C2=A0=C2=A0=C2=A0struct twl4030_platform_data *pmic_data)
> > +				=C2=A0=C2=A0=C2=A0struct twl_platform_data *pmic_data)
> > =C2=A0 {
> > =C2=A0=C2=A0	omap_pmic_init(2, 2600, pmic_type, 7 + OMAP_INTC_START,
> > pmic_data);
> > =C2=A0 }
> >=20
> > =C2=A0 static inline void omap3_pmic_init(const char *pmic_type,
> > -				=C2=A0=C2=A0=C2=A0struct twl4030_platform_data *pmic_data)
> > +				=C2=A0=C2=A0=C2=A0struct twl_platform_data *pmic_data)
> > =C2=A0 {
> > =C2=A0=C2=A0	omap_pmic_init(1, 2600, pmic_type, 7 + OMAP_INTC_START,
> > pmic_data);
> > =C2=A0 }
> >=20
> > =C2=A0 void omap4_pmic_init(const char *pmic_type,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0struct twl4030_platform_data *pmic_data,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0struct twl_platform_data *pmic_data,
> > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_board_info *devices, i=
nt nr_devices);
> >=20
> > -void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
> > +void omap3_pmic_get_config(struct twl_platform_data *pmic_data,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0u32 pdata_flags, u32 regulators_flags)=
;
> >=20
> > -void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
> > +void omap4_pmic_get_config(struct twl_platform_data *pmic_data,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0u32 pdata_flags, u32 regulators_flags)=
;
> >=20
> > =C2=A0 void omap_twl4030_audio_init(char *card_name, struct omap_tw4030=
_pdata
> > *pdata);
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 831696e..dae52f7 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -721,7 +721,7 @@ add_regulator(int num, struct regulator_init_data
> > *pdata,
> > =C2=A0=C2=A0=C2=A0*/
> >=20
> > =C2=A0 static int
> > -add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
> > +add_children(struct twl_platform_data *pdata, unsigned irq_base,
> > =C2=A0=C2=A0		unsigned long features)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct device	*child;
> > @@ -1083,7 +1083,7 @@ static struct of_dev_auxdata twl_auxdata_lookup[]=
 =3D {
> > =C2=A0 static int
> > =C2=A0 twl_probe(struct i2c_client *client, const struct i2c_device_id =
*id)
> > =C2=A0 {
> > -	struct twl4030_platform_data	*pdata =3D
> > dev_get_platdata(&client->dev);
> > +	struct twl_platform_data	*pdata =3D dev_get_platdata(&client-
> > >dev);
> > =C2=A0=C2=A0	struct device_node		*node =3D client->dev.of_node;
> > =C2=A0=C2=A0	struct platform_device		*pdev;
> > =C2=A0=C2=A0	const struct regmap_config	*twl_regmap_config;
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index 9ad7828..27bea30 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -704,7 +704,8 @@ struct twl4030_audio_data {
> > =C2=A0=C2=A0	unsigned int irq_base;
> > =C2=A0 };
> >=20
> > -struct twl4030_platform_data {
> > +struct twl_platform_data {
> > +	/* TWL4030 platform data */
> > =C2=A0=C2=A0	struct twl4030_clock_init_data		*clock;
> > =C2=A0=C2=A0	struct twl4030_bci_platform_data	*bci;
> > =C2=A0=C2=A0	struct twl4030_gpio_platform_data	*gpio;
> >=20
>=20
--=-sDOAotwi9TTDR+Dw08/+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXACRpAAoJEIT9weqP7pUMjIcP/2OIheCHu8e+WGtDMWvviuax
JnxRUiTgqCPKVCVQAxMbxnHBHrkh507gCcMK02Pb7m/+yBnHvQDs4ETDFvL4fodR
DkZaw/We4smOpKBABsXmsjnIfSeYkMxtLCV8yLBD3oextXvo+OEy8r7J0FTh75RR
dCUQsd3zt2bFN4SNtfikRxFXuLDCxthOoJXyx8Iry8KBMIfpf1/3sEfdaMl+yfeL
K3XklsFCpbV+1jHrSQiQF8yEhK1MRzAOtIlardj76T8LMtmSdWjjxDJM3lAinUz2
UC1z5yOsKpflwXjmLm18E4CRffrx8NPR95j95GuWdxj1JTp+7E5M75LcP1UTPlVS
kkqtzXCn9WAGCLt7nL0dCWakLHmTVfQ4emzXkY8KpG1UUtRTsv9KsApOlwLsCFLU
DvHpSG2A0Q1LELu2LBpUKtx8CPFh3DWQeuI/BEvX3vq8iDjivjTq6sm/Vvb1aTjR
KsUpw5O5JQE8b4hDF7f/48VMlDGE0zhELtyqvOLq0yyGQJ7XnbQByVYKLY+CkN6o
uk/Hc2lP4DazDIw7rHmXkL9qkQB8d9cEDT9wpEuIyHydDkmcRZIi760MJysbjoX+
i84U2w4QbJe/PxJtIl0DuqUSFh5B3PTKe2DTLmNkySrG7VkrNfk8MbT26oDRnOAO
3qL+js9r402MKXysSBZh
=RKAS
-----END PGP SIGNATURE-----

--=-sDOAotwi9TTDR+Dw08/+--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
