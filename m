From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP: DSS: Fix for dsi_pll to dpll4 clk switch
Date: Mon, 21 Jun 2010 16:38:28 +0300
Message-ID: <AANLkTim28bTkt71iKyydzg2RkusPQh8sTD_qrTun1aOf@mail.gmail.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49872 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab0FUNi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 09:38:29 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org

when sending DSS patches, CC Tomi and fbdev.

On Thu, Jun 17, 2010 at 8:12 AM, Nagarajan, Rajkumar <x0133774@ti.com> =
wrote:
>
> When switching between clocks, The new functional clock is
> effective when the next vertical blanking interval occurs.
> GOLCD bit has to be set for the new clock to take effect.
>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> ---
> =A0drivers/video/omap2/dss/dpi.c | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/=
dpi.c
> index 960e977..5d778d6 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -214,10 +214,15 @@ void omapdss_dpi_display_disable(struct omap_ds=
s_device *dssdev)
>
> =A0#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
> =A0 =A0 =A0 =A0dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
> + =A0 =A0 =A0 dispc_go(OMAP_DSS_CHANNEL_LCD);
> + =A0 =A0 =A0 while =A0 (dispc_go_busy(OMAP_DSS_CHANNEL_LCD))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> =A0 =A0 =A0 =A0dsi_pll_uninit();
> =A0 =A0 =A0 =A0dss_clk_disable(DSS_CLK_FCK2);
> =A0#endif
>
> + =A0 =A0 =A0 dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, 0);
> +
> =A0 =A0 =A0 =A0dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
>
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx())
> --
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
