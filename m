From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI: Add M2 divider while calculating clkout
Date: Thu, 16 Feb 2012 12:12:36 +0530
Message-ID: <CAP5A+B_4DwXgx=q3Eem5spsoR6=tPzCQBaBu2mEVQd7zWTTNeA@mail.gmail.com>
References: <1329285034-16121-1-git-send-email-mythripk@ti.com>
 <1329291660.1892.9.camel@deskari> <CAP5A+B9cuUsAnVSgt4G3Hue2Kns2+es8bW-8zHo2tLB9Kg-O=g@mail.gmail.com>
 <1329317541.1892.95.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:35057 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756778Ab2BPGm4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 01:42:56 -0500
Received: by mail-iy0-f180.google.com with SMTP id z7so3739831iab.39
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 22:42:56 -0800 (PST)
In-Reply-To: <1329317541.1892.95.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Wed, Feb 15, 2012 at 8:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-02-15 at 14:55 +0530, K, Mythri P wrote:
>> Hi,
>>
>> On Wed, Feb 15, 2012 at 1:11 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Wed, 2012-02-15 at 11:20 +0530, mythripk@ti.com wrote:
>> >> From: Mythri P K <mythripk@ti.com>
>> >>
>> >> Add M2 divider in the equation to calculate regm and regmf.
>> >> Formula for calculating:
>> >> Output clock on digital core domain:
>> >> =A0 =A0 =A0 CLKOUT =3D (M / (N+1))*CLKINP*(1/M2)
>> >> Internal oscillator output clock on internal LDO domain:
>> >> =A0 =A0 =A0 CLKDCOLDO =3D (M / (N+1))*CLKINP
>> >> The current code when allows variable M2 values as input
>> >> ignores using M2 divider values in calculation of regm and regmf.
>> >> so fix it by using M2 in calculation although the default value f=
or
>> >> M2 is 1.
>> >>
>> >> Signed-off-by: Mythri P K <mythripk@ti.com>
>> >> ---
>> >> =A0drivers/video/omap2/dss/hdmi.c | =A0 16 ++++++++--------
>> >> =A01 files changed, 8 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2=
/dss/hdmi.c
>> >> index 92a6679..9185630 100644
>> >> --- a/drivers/video/omap2/dss/hdmi.c
>> >> +++ b/drivers/video/omap2/dss/hdmi.c
>> >> @@ -256,24 +256,24 @@ static void hdmi_compute_pll(struct omap_ds=
s_device *dssdev, int phy,
>> >>
>> >> =A0 =A0 =A0 refclk =3D clkin / pi->regn;
>> >>
>> >> - =A0 =A0 /*
>> >> - =A0 =A0 =A0* multiplier is pixel_clk/ref_clk
>> >> - =A0 =A0 =A0* Multiplying by 100 to avoid fractional part remova=
l
>> >> - =A0 =A0 =A0*/
>> >> - =A0 =A0 pi->regm =3D (phy * 100 / (refclk)) / 100;
>> >> -
>> >> =A0 =A0 =A0 if (dssdev->clocks.hdmi.regm2 =3D=3D 0)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->regm2 =3D HDMI_DEFAULT_REGM2;
>> >> =A0 =A0 =A0 else
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->regm2 =3D dssdev->clocks.hdmi.reg=
m2;
>> >>
>> >> =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0* multiplier is pixel_clk/ref_clk
>> >> + =A0 =A0 =A0* Multiplying by 100 to avoid fractional part remova=
l
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 pi->regm =3D (phy * 100 * pi->regm2 / (refclk)) / 100;
>> >
>> > No need for parenthesis around refclk.
>> Well this is just a copy of old code will change.
>
> The multiplication and division with 100 is actually extra also, they
> don't bring any precision here.
>
Well this is actually done to accommodate the pixel clock, For some
pixel clock like 25175 for VGA VESA
there is slight change which is detected by the analyzer so it is
added for that reason.
>> >
Thanks and regards,
Mythri.
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
