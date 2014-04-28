From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/4] mfd: twl4030-power: Add support for board specific
 configuration
Date: Mon, 28 Apr 2014 12:47:26 +0100
Message-ID: <20140428114726.GW21279@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:36601 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbaD1Lrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 07:47:32 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so6296679wes.29
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 04:47:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398300030-7386-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

> With the recommended twl4030 configuration added, we can now add
> board specific changes as modifications to the recommended
> configuration.
>=20
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
>  include/linux/i2c/twl.h     |  1 +
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 89a8528..89c6b1a 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -511,13 +511,34 @@ twl4030_power_configure_scripts(const struct tw=
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

=46orgive my ignorance, as I don't know how 'common' is setup, but we
appear to move to the next 'common' reference them immediately
dereference it without checking to see if it actually exists. Same
with 'b'. What happens if we reach the end of the array? NULL
dereference or does the final element always have a NULLed resource
attribute?

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
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index ade1c06..069f78f 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -659,6 +659,7 @@ struct twl4030_power_data {
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
