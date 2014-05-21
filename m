From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/7] mfd: twl4030-power: Add support for board specific
 configuration
Date: Wed, 21 May 2014 10:18:57 +0100
Message-ID: <20140521091857.GD6679@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-6-git-send-email-tony@atomide.com>
 <20140520151722.GA24991@lee--X1>
 <20140521024552.GD17417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44421 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbaEUJTE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 05:19:04 -0400
Received: by mail-ie0-f171.google.com with SMTP id to1so1692739ieb.16
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2014 02:19:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140521024552.GD17417@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, 20 May 2014, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [140520 08:18]:
> >=20
> > Ah, I forgot to Ack this last time, didn't I?
> >=20
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> Yeah, here's this one updated with your ack.

Has the code changed at all, or are you just reposting with my Ack
applied?

> 8< ---------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 20 May 2014 11:17:54 -0700
> Subject: [PATCH] mfd: twl4030-power: Add support for board specific c=
onfiguration
>=20
> With the recommended twl4030 configuration added, we can now add
> board specific changes as modifications to the recommended
> configuration.
>=20
> Note that the data is private to this driver, and the data must
> always have a NULL resource in the sentinel.
>=20
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -567,13 +567,34 @@ twl4030_power_configure_scripts(const struct tw=
l4030_power_data *pdata)
>  	return 0;
>  }
> =20
> +static void twl4030_patch_rconfig(struct twl4030_resconfig *common,
> +				  struct twl4030_resconfig *board)
> +{
> +	while (common->resource) {
> +		struct twl4030_resconfig *b =3D board;
> +
> +		while (b->resource) {
> +			if (b->resource =3D=3D common->resource) {
> +				*common =3D *b;
> +				break;
> +			}
> +			b++;
> +		}
> +		common++;
> +	}
> +}
> +
>  static int
>  twl4030_power_configure_resources(const struct twl4030_power_data *p=
data)
>  {
>  	struct twl4030_resconfig *resconfig =3D pdata->resource_config;
> +	struct twl4030_resconfig *boardconf =3D pdata->board_config;
>  	int err;
> =20
>  	if (resconfig) {
> +		if (boardconf)
> +			twl4030_patch_rconfig(resconfig, boardconf);
> +
>  		while (resconfig->resource) {
>  			err =3D twl4030_configure_resource(resconfig);
>  			if (err)
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -674,6 +674,7 @@ struct twl4030_power_data {
>  	struct twl4030_script **scripts;
>  	unsigned num;
>  	struct twl4030_resconfig *resource_config;
> +	struct twl4030_resconfig *board_config;
>  #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
>  	bool use_poweroff;	/* Board is wired for TWL poweroff */
>  };

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
