From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 02/10] OMAP4: DSS: HDMI: Move pll and video configuration
Date: Fri, 2 Sep 2011 10:41:55 +0530
Message-ID: <CAP5A+B_Kx+sHj+n3MZRPFMjeh+1u_g_4KbyW5qCdD7SOZyF5Yw@mail.gmail.com>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
 <1314598500-24005-2-git-send-email-mythripk@ti.com> <1314598500-24005-3-git-send-email-mythripk@ti.com>
 <1314865665.2169.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:50201 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246Ab1IBFMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 01:12:16 -0400
Received: by mail-iy0-f176.google.com with SMTP id i7so3981633iaf.35
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:12:15 -0700 (PDT)
In-Reply-To: <1314865665.2169.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 1, 2011 at 1:57 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> As the pll and the video configuration info are part of the ip_data =
those
>> structures are moved to the ip_data strtucure.Also the functions are=
 modified
>> accordingly to take care of this movement.
>
> structure typoed, and use a space after period.
>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0 34 +++++++++++++++----------=
---------
>> =A0drivers/video/omap2/dss/hdmi.h | =A0 18 ++++++++++--------
>> =A02 files changed, 25 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 544f93e..084a47e 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -59,7 +59,6 @@ static struct {
>> =A0 =A0 =A0 u8 edid[HDMI_EDID_MAX_LENGTH];
>> =A0 =A0 =A0 u8 edid_set;
>> =A0 =A0 =A0 bool custom_set;
>> - =A0 =A0 struct hdmi_config cfg;
>>
>> =A0 =A0 =A0 struct clk *sys_clk;
>> =A0} hdmi;
>> @@ -230,11 +229,11 @@ int hdmi_init_display(struct omap_dss_device *=
dssdev)
>> =A0}
>>
>> =A0static int hdmi_pll_init(struct hdmi_ip_data *ip_data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 enum hdmi_clk_refsel refsel, int dcofreq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_pll_info *fmt, u16 sd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum hdmi_clk_refsel refse=
l)
>> =A0{
>> =A0 =A0 =A0 u32 r;
>> =A0 =A0 =A0 void __iomem *pll_base =3D hdmi_pll_base(ip_data);
>> + =A0 =A0 struct hdmi_pll_info *fmt =3D &ip_data->pll_data;
>>
>> =A0 =A0 =A0 /* PLL start always use manual mode */
>> =A0 =A0 =A0 REG_FLD_MOD(pll_base, PLLCTRL_PLL_CONTROL, 0x0, 0, 0);
>> @@ -251,9 +250,9 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip=
_data,
>> =A0 =A0 =A0 r =3D FLD_MOD(r, 0x1, 13, 13); /* PLL_REFEN */
>> =A0 =A0 =A0 r =3D FLD_MOD(r, 0x0, 14, 14); /* PHY_CLKINEN de-assert =
during locking */
>>
>> - =A0 =A0 if (dcofreq) {
>> + =A0 =A0 if (fmt->dcofreq) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* divider programming for frequency bey=
ond 1000Mhz */
>> - =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(pll_base, PLLCTRL_CFG3, sd, 17=
, 10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(pll_base, PLLCTRL_CFG3, fmt->r=
egsd, 17, 10);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0x4, 3, 1); /* 1000MHz =
and 2000MHz */
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D FLD_MOD(r, 0x2, 3, 1); /* 500MHz a=
nd 1000MHz */
>> @@ -379,8 +378,7 @@ static int hdmi_phy_init(struct hdmi_ip_data *ip=
_data)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdm=
i_pll_info *fmt)
>> +static int hdmi_pll_program(struct hdmi_ip_data *ip_data)
>> =A0{
>> =A0 =A0 =A0 u16 r =3D 0;
>> =A0 =A0 =A0 enum hdmi_clk_refsel refsel;
>> @@ -399,7 +397,7 @@ static int hdmi_pll_program(struct hdmi_ip_data =
*ip_data,
>>
>> =A0 =A0 =A0 refsel =3D HDMI_REFSEL_SYSCLK;
>>
>> - =A0 =A0 r =3D hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt, fm=
t->regsd);
>> + =A0 =A0 r =3D hdmi_pll_init(ip_data, refsel);
>
> I don't think I quite understood why refsel is not part of the pll in=
fo.
> And if it has to be hardcoded, you could as well do that in
> hdmi_pll_init().
>
Ok , yes that is better.
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
