From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: kernel panic with latest DSS
Date: Tue, 23 Mar 2010 10:28:12 -0700
Message-ID: <5e088bd91003231028l7c115da2ld1eff1a57f2b4cd2@mail.gmail.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>
	 <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
	 <5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>
	 <3647DBDA80551C4696E9E4506F0BE08E255DC2F2A7@NOK-EUMSG-02.mgdnok.nokia.com>
	 <5e088bd91003101148o82a07e2j4df803d23ee78d83@mail.gmail.com>
	 <1268391093.28571.137.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:33934 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0CWR2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 13:28:14 -0400
Received: by qyk9 with SMTP id 9so981797qyk.1
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 10:28:13 -0700 (PDT)
In-Reply-To: <1268391093.28571.137.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 12, 2010 at 3:51 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Can you try this patch?
>
> I haven't run into this earlier as I always have DSI compiled in. It
> possibly doesn't behave correctly in that case either, but doesn't
> crash.

Sorry, I got side-tracked with some unrelated client work.

I finally tried the patch this morning and it does fix the issue.

Thanks!

Steve


> =A0Tomi
>
>
> >From c065bb82e1358105d57d80974ce71d3e5aeabf35 Mon Sep 17 00:00:00 20=
01
> From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Date: Fri, 12 Mar 2010 12:46:05 +0200
> Subject: [PATCH] OMAP: DSS2: initialize dss clk sources properly
>
> Clk sources were not initialized, leading to kernel crash, or possibl=
y to
> strange behaviour if DSI was compiled in.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> =A0drivers/video/omap2/dss/dss.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/=
dss.c
> index 8254a42..5434418 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -590,6 +590,9 @@ int dss_init(bool skip_init)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 dss.dsi_clk_source =3D DSS_SRC_DSS1_ALWON_FCLK;
> + =A0 =A0 =A0 dss.dispc_clk_source =3D DSS_SRC_DSS1_ALWON_FCLK;
> +
> =A0 =A0 =A0 =A0dss_save_context();
>
> =A0 =A0 =A0 =A0rev =3D dss_read_reg(DSS_REVISION);
> --
> 1.6.5
>
>
>
>
>
>
> On Wed, 2010-03-10 at 20:48 +0100, ext Steve Sakoman wrote:
>> On Wed, Mar 10, 2010 at 10:58 AM, =A0<Tomi.Valkeinen@nokia.com> wrot=
e:
>>
>> > I haven't had time to look at this, but I don't think your analysi=
s is correct.
>>
>> You are correct of course. =A0My sleepy eyes neglected to notice tha=
t
>> double =3D and that makes a big difference :-)
>>
>> > What first comes to my mind is that dss.dispc_clk_source is, for s=
ome reason, uninitialized. Could you put prints to dss_select_dispc_clk=
_source to see if it's called, and if so, what is assigned to dss.dispc=
_clk_source?
>>
>> I did a build with that change and it does seem that
>> dss_select_dispc_clk_source is never called.
>>
>> Steve
>>
>> > =A0Tomi
>> >
>> > ________________________________________
>> > From: ext Steve Sakoman [sakoman@gmail.com]
>> > Sent: Wednesday, March 10, 2010 20:42
>> > To: linux-omap@vger.kernel.org; Valkeinen Tomi (Nokia-D/Helsinki)
>> > Subject: Re: kernel panic with latest DSS
>> >
>> > On Wed, Mar 10, 2010 at 10:16 AM, Steve Sakoman <sakoman@gmail.com=
> wrote:
>> >
>> >> The issue occurs in the following section of code in
>> >> drivers/video/omap2/dss/dispc.c:
>> >>
>> >> unsigned long dispc_fclk_rate(void)
>> >> {
>> >> =A0 =A0 =A0 =A0unsigned long r =3D 0;
>> >>
>> >> =A0 =A0 =A0 =A0if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1=
_ALWON_FCLK)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dss_clk_get_rate(DSS_CLK_FCK=
1);
>> >> =A0 =A0 =A0 =A0else
>> >> #ifdef CONFIG_OMAP2_DSS_DSI
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dsi_get_dsi1_pll_rate();
>> >> #else
>> >> =A0 =A0 =A0 =A0BUG();
>> >> #endif
>> >> =A0 =A0 =A0 =A0return r;
>> >> }
>> >>
>> >> Since my machines don't have DSI displays CONFIG_OMAP2_DSS_DSI is=
 not
>> >> defined and the BUG() call is triggered.
>> >
>> > The issue seems to be the test for DSS_SRC_DSS1_ALWON_FCLK.
>> >
>> > Looking at =A0drivers/video/omap2/dss/dispc.c I see that
>> > DSS_SRC_DSS1_ALWON_FCLK will never be returned since clk_src is al=
ways
>> > set to 0 or 1 based on a test of DSS_SRC_DSS1_ALWON_FCLK :
>> >
>> > void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
>> > {
>> > =A0 =A0 =A0 =A0int b;
>> >
>> > =A0 =A0 =A0 =A0BUG_ON(clk_src !=3D DSS_SRC_DSI1_PLL_FCLK &&
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_src !=3D DSS_SR=
C_DSS1_ALWON_FCLK);
>> >
>> > =A0 =A0 =A0 =A0b =3D clk_src =3D=3D DSS_SRC_DSS1_ALWON_FCLK ? 0 : =
1;
>> >
>> > =A0 =A0 =A0 =A0REG_FLD_MOD(DSS_CONTROL, b, 0, 0); =A0 =A0 =A0/* DI=
SPC_CLK_SWITCH */
>> >
>> > =A0 =A0 =A0 =A0dss.dispc_clk_source =3D clk_src;
>> > }
>> >
>> > It seems to me that the test should return to the way it was in th=
e
>> > previous DSS version, i.e. a test for 0:
>> >
>> > diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2=
/dss/dispc.c
>> > index e777e35..be9b3de 100644
>> > --- a/drivers/video/omap2/dss/dispc.c
>> > +++ b/drivers/video/omap2/dss/dispc.c
>> > @@ -2218,7 +2218,7 @@ unsigned long dispc_fclk_rate(void)
>> > =A0{
>> > =A0 =A0 =A0 =A0unsigned long r =3D 0;
>> >
>> > - =A0 =A0 =A0 if (dss_get_dispc_clk_source() =3D=3D DSS_SRC_DSS1_A=
LWON_FCLK)
>> > + =A0 =A0 =A0 if (dss_get_dispc_clk_source() =3D=3D 0)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D dss_clk_get_rate(DSS_CLK_FCK1=
);
>> > =A0 =A0 =A0 =A0else
>> > =A0#ifdef CONFIG_OMAP2_DSS_DSI
>> >
>> > A test build confirms that this change restores my ability to play
>> > DVD's and display webcam streams. =A0My understanding of this code=
 is
>> > superficial, so hopefully Tomi can comment on whether this is a go=
od
>> > fix or not.
>> >
>> > Steve
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
