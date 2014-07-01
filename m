From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 2/6] regulator: palmas: Rename reg_info to
 palmas_reg_info
Date: Tue, 1 Jul 2014 08:41:05 +0100
Message-ID: <20140701074105.GB27971@lee--X1>
References: <1404143859-8160-1-git-send-email-nm@ti.com>
 <1404143859-8160-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:60171 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757394AbaGAHlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 03:41:11 -0400
Received: by mail-ig0-f169.google.com with SMTP id c1so5050777igq.2
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 00:41:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404143859-8160-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Keerthy J <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org

On Mon, 30 Jun 2014, Nishanth Menon wrote:

> reg_info is a generic term which might cause conflict at a later poin=
t
> in time. To prevent such a thing from occuring in future, rename to
> palmas_reg_info.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/regulator/palmas-regulator.c |    4 ++--
>  include/linux/mfd/palmas.h           |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator=
/palmas-regulator.c
> index 91f60fa..05f11b9 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -41,7 +41,7 @@ static const struct regulator_linear_range smps_hig=
h_ranges[] =3D {
>  	REGULATOR_LINEAR_RANGE(3300000, 0x7A, 0x7f, 0),
>  };
> =20
> -static struct regs_info palmas_regs_info[] =3D {
> +static struct palmas_regs_info palmas_regs_info[] =3D {
>  	{
>  		.name		=3D "SMPS12",
>  		.sname		=3D "smps1-in",
> @@ -227,7 +227,7 @@ static struct regs_info palmas_regs_info[] =3D {
>  	},
>  };
> =20
> -static struct regs_info tps65917_regs_info[] =3D {
> +static struct palmas_regs_info tps65917_regs_info[] =3D {
>  	{
>  		.name		=3D "SMPS1",
>  		.sname		=3D "smps1-in",
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 1a045ba..fb0390a 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -102,7 +102,7 @@ struct palmas_sleep_requestor_info {
>  	int bit_pos;
>  };
> =20
> -struct regs_info {
> +struct palmas_regs_info {
>  	char	*name;
>  	char	*sname;
>  	u8	vsel_addr;
> @@ -117,7 +117,7 @@ struct palmas_pmic_driver_data {
>  	int ldo_begin;
>  	int ldo_end;
>  	int max_reg;
> -	struct regs_info *palmas_regs_info;
> +	struct palmas_regs_info *palmas_regs_info;
>  	struct of_regulator_match *palmas_matches;
>  	struct palmas_sleep_requestor_info *sleep_req_info;
>  	int (*smps_register)(struct palmas_pmic *pmic,

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
