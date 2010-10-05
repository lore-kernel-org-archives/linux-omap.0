From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 07/10] OMAP: McBSP: implement functional clock switching via clock framework
Date: Tue, 5 Oct 2010 11:35:36 +0300
Message-ID: <201010051135.36436.peter.ujfalusi@nokia.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213531.1408.87922.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:52062 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460Ab0JEIfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 04:35:43 -0400
In-Reply-To: <20101001213531.1408.87922.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jarkko Nikula <jhnikula@gmail.com>

Hello,

I have only one question...

On Saturday 02 October 2010 00:35:32 ext Paul Walmsley wrote:
=2E..

> +/* McBSP CLKS source switching function */
> +
> +int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	struct clk *fck_src;
> +	char *fck_src_name;
> +	int r;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		pr_err("%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -EINVAL;
> +	}
> +	mcbsp =3D id_to_mcbsp_ptr(id);
> +
> +	if (fck_src_id =3D=3D MCBSP_CLKS_PAD_SRC)
> +		fck_src_name =3D "pad_fck";
> +	else if (fck_src_id =3D=3D MCBSP_CLKS_PRCM_SRC)
> +		fck_src_name =3D "prcm_fck";
> +	else
> +		return -EINVAL;
> +
> +	fck_src =3D clk_get(mcbsp->dev, fck_src_name);
> +	if (IS_ERR_OR_NULL(fck_src)) {
> +		pr_err("omap-mcbsp: %s: could not clk_get() %s\n", "clks",
> +		       fck_src_name);
> +		return -EINVAL;
> +	}
> +
> +	clk_disable(mcbsp->fclk);
> +
> +	r =3D clk_set_parent(mcbsp->fclk, fck_src);
> +	if (IS_ERR_VALUE(r)) {
> +		pr_err("omap-mcbsp: %s: could not clk_set_parent() to %s\n",
> +		       "clks", fck_src_name);
> +		clk_put(fck_src);
> +		return -EINVAL;
> +	}
> +
> +	clk_enable(mcbsp->fclk);
> +
> +	clk_put(fck_src);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);

=2E..

>  static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai=
,
>  					 int clk_id, unsigned int freq,
>  					 int dir)
>  {
>  	struct omap_mcbsp_data *mcbsp_data =3D to_mcbsp(cpu_dai->private_da=
ta);
>  	struct omap_mcbsp_reg_cfg *regs =3D &mcbsp_data->regs;
> -	struct omap_mcbsp_platform_data *pdata =3D cpu_dai->dev->platform_d=
ata;
>  	int err =3D 0;
>=20
>  	/* The McBSP signal muxing functions are only available on McBSP1 *=
/
> @@ -685,8 +630,20 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct
> snd_soc_dai *cpu_dai, regs->srgr2	|=3D CLKSM;
>  		break;
>  	case OMAP_MCBSP_SYSCLK_CLKS_FCLK:
> +		if (cpu_class_is_omap1()) {
> +			err =3D -EINVAL;
> +			break;
> +		}
> +		err =3D omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
> +					       MCBSP_CLKS_PRCM_SRC);
> +		break;
>  	case OMAP_MCBSP_SYSCLK_CLKS_EXT:
> -		err =3D omap_mcbsp_dai_set_clks_src(mcbsp_data, clk_id);
> +		if (cpu_class_is_omap1()) {
> +			err =3D 0;
> +			break;
> +		}
> +		err =3D omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
> +					       MCBSP_CLKS_PAD_SRC);
>  		break;
>=20
>  	case OMAP_MCBSP_SYSCLK_CLKX_EXT:

What is the fclk source by default.
What I mean is that most of the machine drivers are not calling the=20
snd_soc_dai_set_sysclk for the cpu_dai.
It has been by default to prcm_fclk (core_96 or per_96).
Is this still the case after this series?
Do we need to go through the ASoC machine drivers, and need to select e=
xplicitly=20
the prcm_fclk from now on?

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
