From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Thu, 24 Feb 2011 00:13:33 +0530
Message-ID: <AANLkTim3X-k-0HV2wLjSSAmKHQ1kLCYW777s52TyirDU@mail.gmail.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com> <1298483913-20344-4-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55714 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755440Ab1BWSny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 13:43:54 -0500
Received: by mail-wy0-f177.google.com with SMTP id 23so2498509wyf.8
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 10:43:53 -0800 (PST)
In-Reply-To: <1298483913-20344-4-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 23, 2011 at 23:28, Sanjeev Premi <premi@ti.com> wrote:
> Add glue logic to hook-up AM35x processors
> with TPS65023.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

[...]
> +/**
> + * TBD: Just a copy of OMAP3 PMIC info.
> + * =A0 =A0 =A0Many fields below don't make much sense for AM3517,
> + * =A0 =A0 =A0but keeping them as is for now.
> + */
> +static struct omap_volt_pmic_info am3517_volt_info =3D {
> + =A0 =A0 =A0 .slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> + =A0 =A0 =A0 .step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 25000,
> + =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> + =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1000000,
> + =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 975000,
> + =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> + =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0xfff,
> + =A0 =A0 =A0 .vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP3_VP_CONFIG_ERR=
OROFFSET,
> + =A0 =A0 =A0 .vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEPM=
IN_VSTEPMIN,
> + =A0 =A0 =A0 .vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEPM=
AX_VSTEPMAX,
> + =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP2_=
VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP2_=
VLIMITTO_VDDMAX,
> + =A0 =A0 =A0 .vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VLIMITTO=
_TIMEOUT_US,
> + =A0 =A0 =A0 .i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP3_SRI2C_SLAVE_A=
DDR,
> + =A0 =A0 =A0 .pmic_reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_VDD_COR=
E_SR_CONTROL_REG,
> + =A0 =A0 =A0 .vsel_to_uv =A0 =A0 =A0 =A0 =A0 =A0 =3D tps65023_vsel_t=
o_uv,
> + =A0 =A0 =A0 .uv_to_vsel =A0 =A0 =A0 =A0 =A0 =A0 =3D tps65023_uv_to_=
vsel,
> +};
I see your point in http://marc.info/?l=3Dlinux-omap&m=3D12984712680565=
6&w=3D2
"Check the definition of omap_volt_pmic_info and omap_volt_data.

Just to "hack" support we can fill *don't care* values for the
fields not supported and wrap processing under if (cpu_is_....())
checks; but this doesn't appear to be a good solution"
PMIC specific data:
> +       .slew_rate              =3D 4000,
> +       .step_size              =3D 25000,

SoC specific data + PMIC limits:
> +       .on_volt                =3D 1200000,
> +       .onlp_volt              =3D 1000000,
> +       .ret_volt               =3D 975000,
> +       .off_volt               =3D 600000,

I dont like the following at all!
> +       .volt_setup_time        =3D 0xfff,

SOC specific
> +       .vp_erroroffset         =3D OMAP3_VP_CONFIG_ERROROFFSET,
> +       .vp_vstepmin            =3D OMAP3_VP_VSTEPMIN_VSTEPMIN,
> +       .vp_vstepmax            =3D OMAP3_VP_VSTEPMAX_VSTEPMAX,
> +       .vp_vddmin              =3D OMAP3430_VP2_VLIMITTO_VDDMIN,
> +       .vp_vddmax              =3D OMAP3430_VP2_VLIMITTO_VDDMAX,
> +       .vp_timeout_us          =3D OMAP3_VP_VLIMITTO_TIMEOUT_US,

PMIC speciic
> +       .i2c_slave_addr         =3D OMAP3_SRI2C_SLAVE_ADDR,
> +       .pmic_reg               =3D OMAP3_VDD_CORE_SR_CONTROL_REG,
> +       .vsel_to_uv             =3D tps65023_vsel_to_uv,
> +       .uv_to_vsel             =3D tps65023_uv_to_vsel,

Yeah they ought to be split properly IMHO.
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
