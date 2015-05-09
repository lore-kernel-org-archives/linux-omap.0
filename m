From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] thermal: ti-soc-thermal: OMAP5: Implement Workaround
 for Errata i813
Date: Fri, 8 May 2015 17:43:02 -0700
Message-ID: <20150509004300.GA28950@localhost.localdomain>
References: <1429707102-20678-1-git-send-email-j-keerthy@ti.com>
 <1429707102-20678-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34683 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbbEHRnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2015 13:43:05 -0400
Received: by pdbqa5 with SMTP id qa5so90358507pdb.1
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2015 10:43:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1429707102-20678-3-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.or, t-kristo@ti.com


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 06:21:42PM +0530, Keerthy wrote:
> DESCRIPTION
>=20
> Spurious Thermal Alert: Talert can happen randomly while the device remai=
ns under the temperature limit
> defined for this event to trig. This spurious event is caused by a incorr=
ect re-synchronization between
> clock domains. The comparison between configured threshold and current te=
mperature value can happen
> while the value is transitioning (metastable), thus causing inappropriate=
 event generation.
> No spurious event occurs as long as the threshold value stays unchanged. =
Spurious event can be
> generated while a thermal alert threshold is modified in
> CONTROL_BANDGAP_THRESHOLD_MPU/GPU/CORE/DSPEVE/IVA_n.
> WORKAROUND
>=20
> Spurious event generation can be avoided by performing following sequence=
 when the threshold is
> modified:
> 1. Mask the hot/cold events at the thermal IP level.
> 2. Modify Threshold.
> 3. Unmask the hot/cold events at the thermal IP level.
>=20

applying to my -fixes branch. next time, please make sure you have the
correct linux-pm address so we can track the patch in our patchwork.

BR,

Eduardo Valentin

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  3 +-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 41 ++++++++++++++++=
+++++-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 ++-
>  3 files changed, 45 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/driver=
s/thermal/ti-soc-thermal/omap5-thermal-data.c
> index eff0c80..79ff70c 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> @@ -319,7 +319,8 @@ const struct ti_bandgap_data omap5430_data =3D {
>  			TI_BANDGAP_FEATURE_FREEZE_BIT |
>  			TI_BANDGAP_FEATURE_TALERT |
>  			TI_BANDGAP_FEATURE_COUNTER_DELAY |
> -			TI_BANDGAP_FEATURE_HISTORY_BUFFER,
> +			TI_BANDGAP_FEATURE_HISTORY_BUFFER |
> +			TI_BANDGAP_FEATURE_ERRATA_813,
>  	.fclock_name =3D "l3instr_ts_gclk_div",
>  	.div_ck_name =3D "l3instr_ts_gclk_div",
>  	.conv_table =3D omap5430_adc_to_temp,
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.c
> index 8fdddb6..08a2155 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -445,7 +445,7 @@ static int ti_bandgap_update_alert_threshold(struct t=
i_bandgap *bgp, int id,
>  {
>  	struct temp_sensor_data *ts_data =3D bgp->conf->sensors[id].ts_data;
>  	struct temp_sensor_registers *tsr;
> -	u32 thresh_val, reg_val, t_hot, t_cold;
> +	u32 thresh_val, reg_val, t_hot, t_cold, ctrl;
>  	int err =3D 0;
> =20
>  	tsr =3D bgp->conf->sensors[id].registers;
> @@ -477,8 +477,47 @@ static int ti_bandgap_update_alert_threshold(struct =
ti_bandgap *bgp, int id,
>  		  ~(tsr->threshold_thot_mask | tsr->threshold_tcold_mask);
>  	reg_val |=3D (t_hot << __ffs(tsr->threshold_thot_mask)) |
>  		   (t_cold << __ffs(tsr->threshold_tcold_mask));
> +
> +	/**
> +	 * Errata i813:
> +	 * Spurious Thermal Alert: Talert can happen randomly while the device
> +	 * remains under the temperature limit defined for this event to trig.
> +	 * This spurious event is caused by a incorrect re-synchronization
> +	 * between clock domains. The comparison between configured threshold
> +	 * and current temperature value can happen while the value is
> +	 * transitioning (metastable), thus causing inappropriate event
> +	 * generation. No spurious event occurs as long as the threshold value
> +	 * stays unchanged. Spurious event can be generated while a thermal
> +	 * alert threshold is modified in
> +	 * CONTROL_BANDGAP_THRESHOLD_MPU/GPU/CORE/DSPEVE/IVA_n.
> +	 */
> +
> +	if (TI_BANDGAP_HAS(bgp, ERRATA_813)) {
> +		/* Mask t_hot and t_cold events at the IP Level */
> +		ctrl =3D ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
> +
> +		if (hot)
> +			ctrl &=3D ~tsr->mask_hot_mask;
> +		else
> +			ctrl &=3D ~tsr->mask_cold_mask;
> +
> +		ti_bandgap_writel(bgp, ctrl, tsr->bgap_mask_ctrl);
> +	}
> +
> +	/* Write the threshold value */
>  	ti_bandgap_writel(bgp, reg_val, tsr->bgap_threshold);
> =20
> +	if (TI_BANDGAP_HAS(bgp, ERRATA_813)) {
> +		/* Unmask t_hot and t_cold events at the IP Level */
> +		ctrl =3D ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
> +		if (hot)
> +			ctrl |=3D tsr->mask_hot_mask;
> +		else
> +			ctrl |=3D tsr->mask_cold_mask;
> +
> +		ti_bandgap_writel(bgp, ctrl, tsr->bgap_mask_ctrl);
> +	}
> +
>  	if (err) {
>  		dev_err(bgp->dev, "failed to reprogram thot threshold\n");
>  		err =3D -EIO;
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/therma=
l/ti-soc-thermal/ti-bandgap.h
> index b2da3fc..0c52f7a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -320,7 +320,8 @@ struct ti_temp_sensor {
>   *
>   * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the bandgap d=
evice
>   *	has Errata 814
> - *
> + * TI_BANDGAP_FEATURE_ERRATA_813 - used to workaorund when the bandgap d=
evice
> + *	has Errata 813
>   * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable =
of a
>   *      specific feature (above) or not. Return non-zero, if yes.
>   */
> @@ -335,6 +336,7 @@ struct ti_temp_sensor {
>  #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
>  #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
>  #define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
> +#define TI_BANDGAP_FEATURE_ERRATA_813		BIT(11)
>  #define TI_BANDGAP_HAS(b, f)			\
>  			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
> =20
> --=20
> 1.9.1
>=20

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVTVgIAAoJEMLUO4d9pOJWYucH/iBVLDoXTN05zApm4Js4kxrK
VFqD7FmCb2PhtuTf2aAnAXlwxKu3bt1eMl3NYx0INIWZRl5Zbbu30LqjLJ3BlGVU
m0D0yjw8s9VHDWDfygCCtyT1lx7cspKsZklLJdzlkne3qWLjedXoIPyZFdeVtuVG
qhh7dUkKqe/TSh43pV5rpS2jO7HI52UmXLX95Z+qxBvzVwL9iHNUmxjpXAKflugW
TQnLqNL4ZBZAE3sXNKSF8xLoVmYYidxJD3/Dpv939GQGYNYBNzHiKq4YmRlMDW08
bYymR6rIPYfdZ2FVoYZNW2YSaAA1l/N6eHKiiHRzQH+ZRPpdnu4TIYNUYrH1J5o=
=2TFD
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
