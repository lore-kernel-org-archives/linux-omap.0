From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: kernel panic with latest DSS
Date: Wed, 10 Mar 2010 10:42:21 -0800
Message-ID: <5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
	 <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f204.google.com ([209.85.221.204]:58983 "EHLO
	mail-qy0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0CJSm0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 13:42:26 -0500
Received: by qyk42 with SMTP id 42so1819922qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 10:42:25 -0800 (PST)
In-Reply-To: <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>

On Wed, Mar 10, 2010 at 10:16 AM, Steve Sakoman <sakoman@gmail.com> wro=
te:

> The issue occurs in the following section of code in
> drivers/video/omap2/dss/dispc.c:
>
> unsigned long dispc_fclk_rate(void)
> {
> =A0 =A0 =A0 =A0unsigned long r =3D 0;
>
> =A0 =A0 =A0 =A0if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1_ALW=
ON_FCLK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dss_clk_get_rate(DSS_CLK_FCK1);
> =A0 =A0 =A0 =A0else
> #ifdef CONFIG_OMAP2_DSS_DSI
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dsi_get_dsi1_pll_rate();
> #else
> =A0 =A0 =A0 =A0BUG();
> #endif
> =A0 =A0 =A0 =A0return r;
> }
>
> Since my machines don't have DSI displays CONFIG_OMAP2_DSS_DSI is not
> defined and the BUG() call is triggered.

The issue seems to be the test for DSS_SRC_DSS1_ALWON_FCLK.

Looking at  drivers/video/omap2/dss/dispc.c I see that
DSS_SRC_DSS1_ALWON_FCLK will never be returned since clk_src is always
set to 0 or 1 based on a test of DSS_SRC_DSS1_ALWON_FCLK :

void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
{
	int b;

	BUG_ON(clk_src !=3D DSS_SRC_DSI1_PLL_FCLK &&
			clk_src !=3D DSS_SRC_DSS1_ALWON_FCLK);

	b =3D clk_src =3D=3D DSS_SRC_DSS1_ALWON_FCLK ? 0 : 1;

	REG_FLD_MOD(DSS_CONTROL, b, 0, 0);	/* DISPC_CLK_SWITCH */

	dss.dispc_clk_source =3D clk_src;
}

It seems to me that the test should return to the way it was in the
previous DSS version, i.e. a test for 0:

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
index e777e35..be9b3de 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2218,7 +2218,7 @@ unsigned long dispc_fclk_rate(void)
 {
 	unsigned long r =3D 0;

-	if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1_ALWON_FCLK)
+	if (dss_get_dispc_clk_source() =3D=3D 0)
 		r =3D dss_clk_get_rate(DSS_CLK_FCK1);
 	else
 #ifdef CONFIG_OMAP2_DSS_DSI

A test build confirms that this change restores my ability to play
DVD's and display webcam streams.  My understanding of this code is
superficial, so hopefully Tomi can comment on whether this is a good
fix or not.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
