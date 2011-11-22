From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Tue, 22 Nov 2011 18:37:45 +0530
Message-ID: <CAP5A+B8Cv=knJwzRvGg4D2t3g=-bykam9iksHh9UXH4pmCB96Q@mail.gmail.com>
References: <1321365035-9224-1-git-send-email-mythripk@ti.com> <1321601445.1814.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:58923 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755367Ab1KVNIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 08:08:07 -0500
Received: by iafi7 with SMTP id i7so143941iaf.38
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 05:08:06 -0800 (PST)
In-Reply-To: <1321601445.1814.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

Hi,

On Fri, Nov 18, 2011 at 1:00 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2011-11-15 at 19:20 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Disables the internal pull resistor for SDA and SCL which are enable=
d by
>> default, as there are expernal pull up's in 4460 and 4430 ES2.3
>> SDP, Blaze and Panda Boards, It is done to avoid the EDID read failu=
re.
>>
>> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org=
>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0| =A0 13 ++++++++++++-
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 14 +++++++++++++-
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0| =A0 17 +++++++=
+++++++---
>> =A0include/video/omapdss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 +++-
>> =A04 files changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index c3bd640..d0a82f9 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -826,7 +826,18 @@ static void omap_4430sdp_display_init(void)
>> =A0 =A0 =A0 sdp4430_lcd_init();
>> =A0 =A0 =A0 sdp4430_picodlp_init();
>> =A0 =A0 =A0 omap_display_init(&sdp4430_dss_data);
>> - =A0 =A0 omap_hdmi_init();
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
>> + =A0 =A0 =A0* HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
>> + =A0 =A0 =A0* internal pull up resistor - This is a change needed i=
n
>> + =A0 =A0 =A0* OMAP4460 and OMAP4430 ES2.3 SDP, Blaze and Panda as t=
he
>> + =A0 =A0 =A0* external pull up are present. This is needed to avoid
>> + =A0 =A0 =A0* EDID read failure.
>> + =A0 =A0 =A0*/
>
> I don't think this comment makes sense here. The register and bit
> details are not seen here, they are handled in the display.c.
>
> Also, the comment is still speaking of OMAP versions. This is about
> board revisions. And this is SDP board file, no need to talk about
> Panda.
>
> So the text should be something like "44xxSDP rev XYZ and later have
> external HDMI I2C line pull up. We detect the board revision with the
> OMAP revision."
I shall update the comment and re-post.
>
>> + =A0 =A0 if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2)=
)
>
> If you compare omap_rev() you should also use cpu_is_omap at the same
> time. In this case (cpu_is_omap443x() && omap_rev() >
> OMAP4430_REV_ES2_2). Otherwise the omap_rev check could match, say,
> omap3 or omap5 boards.
Hmmm I am not really sure if that is needed, I dont think omap3 or
omap5 boards would be named with rev "OMAP4430"_REV_ES2_2 ???

Thanks and regards,
Mythri.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_init(0);
>> =A0}
>>
>> =A0#ifdef CONFIG_OMAP_MUX
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-=
omap2/board-omap4panda.c
>> index d95df2e..44ff8e0 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -541,7 +541,19 @@ void omap4_panda_display_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error initializing panda DVI\n")=
;
>>
>> =A0 =A0 =A0 omap_display_init(&omap4_panda_dss_data);
>> - =A0 =A0 omap_hdmi_init();
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
>> + =A0 =A0 =A0* HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
>> + =A0 =A0 =A0* internal pull up resistor - This is a change needed i=
n
>> + =A0 =A0 =A0* OMAP4460 and OMAP4430 ES2.3 SDP, Blaze and Panda as t=
he
>> + =A0 =A0 =A0* external pull up are present. This is needed to avoid
>> + =A0 =A0 =A0* EDID read failure.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_init(0);
>> =A0}
>>
>> =A0static void __init omap4_panda_init(void)
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/dis=
play.c
>> index 8436088..a75e179 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -97,8 +97,11 @@ static const struct omap_dss_hwmod_data omap4_dss=
_hwmod_data[] __initdata =3D {
>> =A0 =A0 =A0 { "dss_hdmi", "omapdss_hdmi", -1 },
>> =A0};
>>
>> -static void omap4_hdmi_mux_pads()
>> +static void omap4_hdmi_mux_pads(int flags)
>> =A0{
>> + =A0 =A0 u32 reg;
>> + =A0 =A0 u16 control_i2c_1;
>> +
>> =A0 =A0 =A0 /* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
>> =A0 =A0 =A0 omap_mux_init_signal("hdmi_hpd",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> @@ -109,6 +112,14 @@ static void omap4_hdmi_mux_pads()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> =A0 =A0 =A0 omap_mux_init_signal("hdmi_ddc_sda",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> +
>> + =A0 =A0 if (flags & OMAP_HDMI_EXTERNAL_PULLUP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 control_i2c_1 =3D OMAP4_CTRL_MODULE_PAD_CO=
RE_CONTROL_I2C_1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap4_ctrl_pad_readl(control_i2c_1=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP4_HDMI_DDC_SDA_PULLUPRESX_MA=
SK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK);
>
> Indent is wrong here, and the parenthesis are extra.
>
> =A0Tomi
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
