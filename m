From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv4 06/15] omap3+: vp: use new vp_params for calculating
 vddmin and vddmax
Date: Tue, 29 Nov 2011 12:34:51 -0600
Message-ID: <CAOMWX4ftGiE3oh0tr5dG-oQLDi7oBXSjGL-LmjjO3YaaCAXRnQ@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com> <1322236188-19456-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:45160 "HELO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756086Ab1K2SfO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 13:35:14 -0500
Received: by mail-bw0-f50.google.com with SMTP id zx1so364553bkb.23
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 10:35:12 -0800 (PST)
In-Reply-To: <1322236188-19456-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
> Now we select the vddmin and vddmax values based on both pmic and
> voltage processor data, this allows usage of different power ICs.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon


> ---
> =A0arch/arm/mach-omap2/vp.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 16cb6d4..ffb68d8 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -53,8 +53,10 @@ void __init omap_vp_init(struct voltagedomain *vol=
tdm)
> =A0 =A0 =A0 =A0sys_clk_rate =3D voltdm->sys_clk.rate / 1000;
>
> =A0 =A0 =A0 =A0timeout =3D (sys_clk_rate * voltdm->pmic->vp_timeout_u=
s) / 1000;
> - =A0 =A0 =A0 vddmin =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vd=
dmin);
> - =A0 =A0 =A0 vddmax =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vd=
dmax);
> + =A0 =A0 =A0 vddmin =3D max(voltdm->vp_param->vddmin, voltdm->pmic->=
vp_vddmin);
> + =A0 =A0 =A0 vddmax =3D min(voltdm->vp_param->vddmax, voltdm->pmic->=
vp_vddmax);
> + =A0 =A0 =A0 vddmin =3D voltdm->pmic->uv_to_vsel(vddmin);
> + =A0 =A0 =A0 vddmax =3D voltdm->pmic->uv_to_vsel(vddmax);
>
> =A0 =A0 =A0 =A0waittime =3D ((voltdm->pmic->step_size / voltdm->pmic-=
>slew_rate) *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sys_clk_rate) / 1000;
> --
> 1.7.4.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
