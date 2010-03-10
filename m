From: <Tomi.Valkeinen@nokia.com>
Subject: RE: kernel panic with latest DSS
Date: Wed, 10 Mar 2010 19:58:02 +0100
Message-ID: <3647DBDA80551C4696E9E4506F0BE08E255DC2F2A7@NOK-EUMSG-02.mgdnok.nokia.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
	 <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>,<5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42200 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab0CJS6O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 13:58:14 -0500
In-Reply-To: <5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com, linux-omap@vger.kernel.org

Hi,

Sorry for top posting, thank microsoft outlook web access =).

I haven't had time to look at this, but I don't think your analysis is correct.

dss_select_dispc_clk_source() sets dss.dispc_clk_source to clk_src, which is DSS_SRC_DSI1_PLL_FCLK or DSS_SRC_DSS1_ALWON_FCLK. There's no assignment to clk_src in that function. And dss_get_dispc_clk_source() returns dss.dispc_clk_source. (also, those functions are in dss.c, not in dispc.c).

What first comes to my mind is that dss.dispc_clk_source is, for some reason, uninitialized. Could you put prints to dss_select_dispc_clk_source to see if it's called, and if so, what is assigned to dss.dispc_clk_source?

 Tomi

________________________________________
From: ext Steve Sakoman [sakoman@gmail.com]
Sent: Wednesday, March 10, 2010 20:42
To: linux-omap@vger.kernel.org; Valkeinen Tomi (Nokia-D/Helsinki)
Subject: Re: kernel panic with latest DSS

On Wed, Mar 10, 2010 at 10:16 AM, Steve Sakoman <sakoman@gmail.com> wrote:

> The issue occurs in the following section of code in
> drivers/video/omap2/dss/dispc.c:
>
> unsigned long dispc_fclk_rate(void)
> {
>        unsigned long r = 0;
>
>        if (dss_get_dispc_clk_source() == DSS_SRC_DSS1_ALWON_FCLK)
>                r = dss_clk_get_rate(DSS_CLK_FCK1);
>        else
> #ifdef CONFIG_OMAP2_DSS_DSI
>                r = dsi_get_dsi1_pll_rate();
> #else
>        BUG();
> #endif
>        return r;
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

        BUG_ON(clk_src != DSS_SRC_DSI1_PLL_FCLK &&
                        clk_src != DSS_SRC_DSS1_ALWON_FCLK);

        b = clk_src == DSS_SRC_DSS1_ALWON_FCLK ? 0 : 1;

        REG_FLD_MOD(DSS_CONTROL, b, 0, 0);      /* DISPC_CLK_SWITCH */

        dss.dispc_clk_source = clk_src;
}

It seems to me that the test should return to the way it was in the
previous DSS version, i.e. a test for 0:

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e777e35..be9b3de 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2218,7 +2218,7 @@ unsigned long dispc_fclk_rate(void)
 {
        unsigned long r = 0;

-       if (dss_get_dispc_clk_source() == DSS_SRC_DSS1_ALWON_FCLK)
+       if (dss_get_dispc_clk_source() == 0)
                r = dss_clk_get_rate(DSS_CLK_FCK1);
        else
 #ifdef CONFIG_OMAP2_DSS_DSI

A test build confirms that this change restores my ability to play
DVD's and display webcam streams.  My understanding of this code is
superficial, so hopefully Tomi can comment on whether this is a good
fix or not.

Steve