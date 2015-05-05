From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl4030-power: Fix pmic for boards that need AC
 charger disabled
Date: Tue, 5 May 2015 09:17:35 +0100
Message-ID: <20150505081735.GR4047@x1>
References: <1427736974-1842-1-git-send-email-tony@atomide.com>
 <20150504143213.GF24469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34851 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbbEEIRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 04:17:43 -0400
Received: by widdi4 with SMTP id di4so150051747wid.0
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2015 01:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150504143213.GF24469@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, 04 May 2015, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150330 10:41]:
> > I noticed the PMIC configuration on 37xx-evm won't actually shut do=
wn
> > the voltages during off-idle. Turns out 37xx-evm needs the AC charg=
er
> > state transitions disabled like we are doing for SDP and LDP in the
> > legacy booting case.
> >=20
> > Let's fix this for device tree based booting by setting up the quir=
k
> > flag based on the compatible flag. And let's also use the existing
> > define for STARTON_CHG.
> >=20
> > Note that SDP and EVM do not have the PMIC clken wired to gate the
> > the oscillator while LDP has.
>=20
> Looks like this fix is still pending?

Applied now, thanks.

> Seems to require a minor update for the const changes, updated
> version below.
>=20
> Regards,
>=20
> Tony
>=20
> 8< ------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 27 Apr 2015 10:18:14 -0700
> Subject: [PATCH] mfd: twl4030-power: Fix pmic for boards that need AC=
 charger
>  disabled
>=20
> I noticed the PMIC configuration on 37xx-evm won't actually shut down
> the voltages during off-idle. Turns out 37xx-evm needs the AC charger
> state transitions disabled like we are doing for SDP and LDP in the
> legacy booting case.
>=20
> Let's fix this for device tree based booting by setting up the quirk
> flag based on the compatible flag. And let's also use the existing
> define for STARTON_CHG.
>=20
> Note that SDP and EVM do not have the PMIC clken wired to gate the
> the oscillator while LDP has.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -264,7 +264,9 @@ out:
>  	return err;
>  }
> =20
> -static int twl4030_config_wakeup12_sequence(u8 address)
> +static int
> +twl4030_config_wakeup12_sequence(const struct twl4030_power_data *pd=
ata,
> +				 u8 address)
>  {
>  	int err =3D 0;
>  	u8 data;
> @@ -293,13 +295,14 @@ static int twl4030_config_wakeup12_sequence(u8 =
address)
>  	if (err)
>  		goto out;
> =20
> -	if (machine_is_omap_3430sdp() || machine_is_omap_ldp()) {
> +	if (pdata->ac_charger_quirk || machine_is_omap_3430sdp() ||
> +	    machine_is_omap_ldp()) {
>  		/* Disabling AC charger effect on sleep-active transitions */
>  		err =3D twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data,
>  				      R_CFG_P1_TRANSITION);
>  		if (err)
>  			goto out;
> -		data &=3D ~(1<<1);
> +		data &=3D ~STARTON_CHG;
>  		err =3D twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data,
>  				       R_CFG_P1_TRANSITION);
>  		if (err)
> @@ -459,8 +462,9 @@ static int twl4030_configure_resource(struct twl4=
030_resconfig *rconfig)
>  	return 0;
>  }
> =20
> -static int load_twl4030_script(struct twl4030_script *tscript,
> -	       u8 address)
> +static int load_twl4030_script(const struct twl4030_power_data *pdat=
a,
> +			       struct twl4030_script *tscript,
> +			       u8 address)
>  {
>  	int err;
>  	static int order;
> @@ -487,7 +491,7 @@ static int load_twl4030_script(struct twl4030_scr=
ipt *tscript,
>  		if (err)
>  			goto out;
> =20
> -		err =3D twl4030_config_wakeup12_sequence(address);
> +		err =3D twl4030_config_wakeup12_sequence(pdata, address);
>  		if (err)
>  			goto out;
>  		order =3D 1;
> @@ -567,7 +571,7 @@ twl4030_power_configure_scripts(const struct twl4=
030_power_data *pdata)
>  	u8 address =3D twl4030_start_script_address;
> =20
>  	for (i =3D 0; i < pdata->num; i++) {
> -		err =3D load_twl4030_script(pdata->scripts[i], address);
> +		err =3D load_twl4030_script(pdata, pdata->scripts[i], address);
>  		if (err)
>  			return err;
>  		address +=3D pdata->scripts[i]->size;
> @@ -829,6 +833,21 @@ static struct twl4030_power_data osc_off_idle =3D=
 {
>  	.board_config		=3D osc_off_rconfig,
>  };
> =20
> +static struct twl4030_power_data omap3_idle_ac_quirk =3D {
> +	.scripts		=3D omap3_idle_scripts,
> +	.num			=3D ARRAY_SIZE(omap3_idle_scripts),
> +	.resource_config	=3D omap3_idle_rconfig,
> +	.ac_charger_quirk	=3D true,
> +};
> +
> +static struct twl4030_power_data omap3_idle_ac_quirk_osc_off =3D {
> +	.scripts		=3D omap3_idle_scripts,
> +	.num			=3D ARRAY_SIZE(omap3_idle_scripts),
> +	.resource_config	=3D omap3_idle_rconfig,
> +	.board_config		=3D osc_off_rconfig,
> +	.ac_charger_quirk	=3D true,
> +};
> +
>  static const struct of_device_id twl4030_power_of_match[] =3D {
>  	{
>  		.compatible =3D "ti,twl4030-power",
> @@ -845,6 +864,18 @@ static const struct of_device_id twl4030_power_o=
f_match[] =3D {
>  		.compatible =3D "ti,twl4030-power-idle-osc-off",
>  		.data =3D &osc_off_idle,
>  	},
> +	{
> +		.compatible =3D "ti,twl4030-power-omap3-sdp",
> +		.data =3D &omap3_idle_ac_quirk,
> +	},
> +	{
> +		.compatible =3D "ti,twl4030-power-omap3-ldp",
> +		.data =3D &omap3_idle_ac_quirk_osc_off,
> +	},
> +	{
> +		.compatible =3D "ti,twl4030-power-omap3-evm",
> +		.data =3D &omap3_idle_ac_quirk,
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -675,6 +675,7 @@ struct twl4030_power_data {
>  	struct twl4030_resconfig *board_config;
>  #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
>  	bool use_poweroff;	/* Board is wired for TWL poweroff */
> +	bool ac_charger_quirk;	/* Disable AC charger on board */
>  };
> =20
>  extern int twl4030_remove_script(u8 flags);

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
