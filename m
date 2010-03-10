From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: kernel panic with latest DSS
Date: Wed, 10 Mar 2010 11:48:37 -0800
Message-ID: <5e088bd91003101148o82a07e2j4df803d23ee78d83@mail.gmail.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
	 <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
	 <5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>
	 <3647DBDA80551C4696E9E4506F0BE08E255DC2F2A7@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f204.google.com ([209.85.221.204]:57960 "EHLO
	mail-qy0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab0CJTsj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 14:48:39 -0500
Received: by qyk42 with SMTP id 42so1891952qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 11:48:38 -0800 (PST)
In-Reply-To: <3647DBDA80551C4696E9E4506F0BE08E255DC2F2A7@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org

On Wed, Mar 10, 2010 at 10:58 AM,  <Tomi.Valkeinen@nokia.com> wrote:

> I haven't had time to look at this, but I don't think your analysis i=
s correct.

You are correct of course.  My sleepy eyes neglected to notice that
double =3D and that makes a big difference :-)

> What first comes to my mind is that dss.dispc_clk_source is, for some=
 reason, uninitialized. Could you put prints to dss_select_dispc_clk_so=
urce to see if it's called, and if so, what is assigned to dss.dispc_cl=
k_source?

I did a build with that change and it does seem that
dss_select_dispc_clk_source is never called.

Steve

> =A0Tomi
>
> ________________________________________
> From: ext Steve Sakoman [sakoman@gmail.com]
> Sent: Wednesday, March 10, 2010 20:42
> To: linux-omap@vger.kernel.org; Valkeinen Tomi (Nokia-D/Helsinki)
> Subject: Re: kernel panic with latest DSS
>
> On Wed, Mar 10, 2010 at 10:16 AM, Steve Sakoman <sakoman@gmail.com> w=
rote:
>
>> The issue occurs in the following section of code in
>> drivers/video/omap2/dss/dispc.c:
>>
>> unsigned long dispc_fclk_rate(void)
>> {
>> =A0 =A0 =A0 =A0unsigned long r =3D 0;
>>
>> =A0 =A0 =A0 =A0if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1_AL=
WON_FCLK)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dss_clk_get_rate(DSS_CLK_FCK1);
>> =A0 =A0 =A0 =A0else
>> #ifdef CONFIG_OMAP2_DSS_DSI
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dsi_get_dsi1_pll_rate();
>> #else
>> =A0 =A0 =A0 =A0BUG();
>> #endif
>> =A0 =A0 =A0 =A0return r;
>> }
>>
>> Since my machines don't have DSI displays CONFIG_OMAP2_DSS_DSI is no=
t
>> defined and the BUG() call is triggered.
>
> The issue seems to be the test for DSS_SRC_DSS1_ALWON_FCLK.
>
> Looking at =A0drivers/video/omap2/dss/dispc.c I see that
> DSS_SRC_DSS1_ALWON_FCLK will never be returned since clk_src is alway=
s
> set to 0 or 1 based on a test of DSS_SRC_DSS1_ALWON_FCLK :
>
> void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
> {
> =A0 =A0 =A0 =A0int b;
>
> =A0 =A0 =A0 =A0BUG_ON(clk_src !=3D DSS_SRC_DSI1_PLL_FCLK &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_src !=3D DSS_SRC_D=
SS1_ALWON_FCLK);
>
> =A0 =A0 =A0 =A0b =3D clk_src =3D=3D DSS_SRC_DSS1_ALWON_FCLK ? 0 : 1;
>
> =A0 =A0 =A0 =A0REG_FLD_MOD(DSS_CONTROL, b, 0, 0); =A0 =A0 =A0/* DISPC=
_CLK_SWITCH */
>
> =A0 =A0 =A0 =A0dss.dispc_clk_source =3D clk_src;
> }
>
> It seems to me that the test should return to the way it was in the
> previous DSS version, i.e. a test for 0:
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/ds=
s/dispc.c
> index e777e35..be9b3de 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -2218,7 +2218,7 @@ unsigned long dispc_fclk_rate(void)
> =A0{
> =A0 =A0 =A0 =A0unsigned long r =3D 0;
>
> - =A0 =A0 =A0 if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1_ALWO=
N_FCLK)
> + =A0 =A0 =A0 if (dss_get_dispc_clk_source() =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dss_clk_get_rate(DSS_CLK_FCK1);
> =A0 =A0 =A0 =A0else
> =A0#ifdef CONFIG_OMAP2_DSS_DSI
>
> A test build confirms that this change restores my ability to play
> DVD's and display webcam streams. =A0My understanding of this code is
> superficial, so hopefully Tomi can comment on whether this is a good
> fix or not.
>
> Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
