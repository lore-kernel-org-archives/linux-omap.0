From: John S <john.schi15@gmail.com>
Subject: Re: [PATCH] HACK: OMAP: DSS2: Fix OMAP2_DSS_USE_DSI_PLL
Date: Wed, 2 Mar 2011 14:00:10 +0530
Message-ID: <AANLkTin9L6YWG5j=OsjBzhvtaVTttYdE_Xs8G-xs2Kip@mail.gmail.com>
References: <1299054015-1070-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36009 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab1CBIaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 03:30:12 -0500
Received: by pwi15 with SMTP id 15so1045620pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 00:30:11 -0800 (PST)
In-Reply-To: <1299054015-1070-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, steve@sakoman.com

On Wed, Mar 2, 2011 at 1:50 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>
> When using OMAP2_DSS_USE_DSI_PLL, which selects DSI PLL as source clo=
ck
> for DISPC, the DSI needs the vdds_dsi regulator. Latest regulator
> changes broke this, causing the the code to not acquire the regulator
> when using OMAP2_DSS_USE_DSI_PLL.
>
> This patch acquires the vdds_dsi regulator in dsi_pll_init(), fixing =
the
> issue. This is is just a quick hack to get the OMAP2_DSS_USE_DSI_PLL
> option working. There shouldn't be any other downside in this solutio=
n
> than some extra lines of code.
>
> OMAP2_DSS_USE_DSI_PLL is itself a big hack, and should be removed, an=
d
> the feature itself should be implemented in a more sane way. However,
> the solution is not trivial, and people are using DSI PLL to get more
> exact pixel clocks, so this hack is an acceptable temporary solution =
for
> the time being.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> =A0drivers/video/omap2/dss/dsi.c | =A0 20 ++++++++++++++++++++
> =A01 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/=
dsi.c
> index c3019d9..6f4f19d 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1105,6 +1105,26 @@ int dsi_pll_init(struct omap_dss_device *dssde=
v, bool enable_hsclk,
>
> =A0 =A0 =A0 =A0DSSDBG("PLL init\n");
>
> +#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* HACK: this is just a quick hack to get the USE_DSI=
_PLL
> + =A0 =A0 =A0 =A0* option working. USE_DSI_PLL is itself a big hack, =
and
> + =A0 =A0 =A0 =A0* should be removed.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (dsi.vdds_dsi_reg =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator *vdds_dsi;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdds_dsi =3D regulator_get(&dsi.pdev->d=
ev, "vdds_dsi");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(vdds_dsi)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDS_=
DSI regulator\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(vdds_dsi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi.vdds_dsi_reg =3D vdds_dsi;
> + =A0 =A0 =A0 }
> +#endif
> +
> =A0 =A0 =A0 =A0enable_clocks(1);
> =A0 =A0 =A0 =A0dsi_enable_pll_clock(1);
>

The hack might be temporarily acceptable.
But I think there should be a matching regulator_put in dsi_pll_uinit.

> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
