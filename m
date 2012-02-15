From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI: Add M2 divider while calculating clkout
Date: Wed, 15 Feb 2012 14:55:59 +0530
Message-ID: <CAP5A+B9cuUsAnVSgt4G3Hue2Kns2+es8bW-8zHo2tLB9Kg-O=g@mail.gmail.com>
References: <1329285034-16121-1-git-send-email-mythripk@ti.com> <1329291660.1892.9.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40131 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932204Ab2BOJ0b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 04:26:31 -0500
Received: by iabz7 with SMTP id z7so1659000iab.11
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 01:26:19 -0800 (PST)
In-Reply-To: <1329291660.1892.9.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Feb 15, 2012 at 1:11 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-02-15 at 11:20 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Add M2 divider in the equation to calculate regm and regmf.
>> Formula for calculating:
>> Output clock on digital core domain:
>> =A0 =A0 =A0 CLKOUT =3D (M / (N+1))*CLKINP*(1/M2)
>> Internal oscillator output clock on internal LDO domain:
>> =A0 =A0 =A0 CLKDCOLDO =3D (M / (N+1))*CLKINP
>> The current code when allows variable M2 values as input
>> ignores using M2 divider values in calculation of regm and regmf.
>> so fix it by using M2 in calculation although the default value for
>> M2 is 1.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0 16 ++++++++--------
>> =A01 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 92a6679..9185630 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -256,24 +256,24 @@ static void hdmi_compute_pll(struct omap_dss_d=
evice *dssdev, int phy,
>>
>> =A0 =A0 =A0 refclk =3D clkin / pi->regn;
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* multiplier is pixel_clk/ref_clk
>> - =A0 =A0 =A0* Multiplying by 100 to avoid fractional part removal
>> - =A0 =A0 =A0*/
>> - =A0 =A0 pi->regm =3D (phy * 100 / (refclk)) / 100;
>> -
>> =A0 =A0 =A0 if (dssdev->clocks.hdmi.regm2 =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->regm2 =3D HDMI_DEFAULT_REGM2;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->regm2 =3D dssdev->clocks.hdmi.regm2;
>>
>> =A0 =A0 =A0 /*
>> + =A0 =A0 =A0* multiplier is pixel_clk/ref_clk
>> + =A0 =A0 =A0* Multiplying by 100 to avoid fractional part removal
>> + =A0 =A0 =A0*/
>> + =A0 =A0 pi->regm =3D (phy * 100 * pi->regm2 / (refclk)) / 100;
>
> No need for parenthesis around refclk.
Well this is just a copy of old code will change.
>
>> +
>> + =A0 =A0 /*
>> =A0 =A0 =A0 =A0* fractional multiplier is remainder of the differenc=
e between
>> =A0 =A0 =A0 =A0* multiplier and actual phy(required pixel clock thus=
 should be
>> =A0 =A0 =A0 =A0* multiplied by 2^18(262144) divided by the reference=
 clock
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 mf =3D (phy - pi->regm * refclk) * 262144;
>> - =A0 =A0 pi->regmf =3D mf / (refclk);
>> + =A0 =A0 mf =3D (phy - pi->regm / pi->regm2 * refclk) * 262144;
>
> What kind of values does regm have? If the regm2 is something else th=
an
> 1, and regm is relatively small value, it's quite easy to lose precis=
ion
> there. Would it be better to have:
Normally regm values are much higher compared to regm2 , regm2 is
normally 1 or 2.
also given that regm2 is a multiplier factor in calculating regm there
should not be any precision factor what do you think ?

Thanks and regards,
Mythri.
>
> pi->regm * refclk / pi->regm2
>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
