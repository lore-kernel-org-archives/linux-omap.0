From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv4 04/15] omap4: add pmic startup / shutdown times
Date: Tue, 29 Nov 2011 12:30:20 -0600
Message-ID: <CAOMWX4dfTTd6DHX=RhtymyvMEdfoWWQbATqYqbf2svNYHsQGhw@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com> <1322236188-19456-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41468 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756086Ab1K2Sao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 13:30:44 -0500
Received: by mail-bw0-f53.google.com with SMTP id q10so11471371bka.12
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 10:30:41 -0800 (PST)
In-Reply-To: <1322236188-19456-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
> Both startup and shutdown take 500us at maximum, value taken from
> TWL6030 data manual.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_twl.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index 62ed050..bd99328 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -207,6 +207,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_core_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> + =A0 =A0 =A0 .startup_time =A0 =A0 =A0 =A0 =A0 =3D 500,
549?
> + =A0 =A0 =A0 .shutdown_time =A0 =A0 =A0 =A0 =A0=3D 500,
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> --
> 1.7.4.1
>


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
