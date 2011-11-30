From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv4 02/15] omap3+: voltage: parameter segregation
Date: Wed, 30 Nov 2011 11:11:44 +0100
Message-ID: <CAORVsuXd5tvC3-+6=QD8yg4ZiK4_4es4OpbuBtvJS2xGLf+e+g@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33795 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1K3KLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Nov 2011 05:11:45 -0500
Received: by vcbfk14 with SMTP id fk14so212618vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 02:11:45 -0800 (PST)
In-Reply-To: <1322236188-19456-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

Tero,

On Fri, Nov 25, 2011 at 4:49 PM, Tero Kristo <t-kristo@ti.com> wrote:
> -static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> +static void omap3_set_i2c_timings(struct voltagedomain *voltdm, int =
off_mode)
> =A0{
> + =A0 =A0 =A0 unsigned long voltsetup1;
> + =A0 =A0 =A0 u32 tgt_volt;
> +
> + =A0 =A0 =A0 if (off_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tgt_volt =3D voltdm->vc_param->off;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tgt_volt =3D voltdm->vc_param->ret;
> +
> + =A0 =A0 =A0 voltsetup1 =3D (voltdm->vc_param->on - tgt_volt) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->pmic->slew_rate=
;
> +
> + =A0 =A0 =A0 voltsetup1 =3D voltsetup1 * voltdm->sys_clk.rate / 8 / =
1000000 + 1;
Minor: some () here would improve the code readability.

> +
> + =A0 =A0 =A0 voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltsetup1 << __ffs(voltdm->vfsm->volts=
etup_mask),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vfsm->voltsetup_reg);
> +
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
