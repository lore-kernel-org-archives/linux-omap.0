From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Mon, 19 Dec 2011 13:56:31 +0530
Message-ID: <CAP5A+B-+SXzGOvY_51v32iHEC7vO0OMbfVMGR+TK3FGH3DkJpA@mail.gmail.com>
References: <1323755818-17901-1-git-send-email-mythripk@ti.com>
 <1323755818-17901-2-git-send-email-mythripk@ti.com> <1323766081.1877.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59866 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713Ab1LSI0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 03:26:53 -0500
Received: by mail-gx0-f170.google.com with SMTP id v1so3735284ggn.15
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 00:26:52 -0800 (PST)
In-Reply-To: <1323766081.1877.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

Hi Tomi,

On Tue, Dec 13, 2011 at 2:18 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2011-12-13 at 11:26 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Disables the internal pull resistor for SDA and SCL which are enable=
d by
>> default, as there are expernal pull up's in 4460 and 4430 ES2.3
>
> Typo above with external.
>
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
>> index c3bd640..1b7c5e5 100644
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
>> + =A0 =A0 =A0* OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze Boards=
 as the
>> + =A0 =A0 =A0* external pull up are present. This is needed to avoid
>> + =A0 =A0 =A0* EDID read failure.
>> + =A0 =A0 =A0*/
>
Well CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
HDMI_DDC_SCL_PULLUPRESX (bit 24) are marked as reserved bits in TRM
and hence dont feature there so wanted to add to make clear as to what
these bits mean, I can remove.

> The comment above about the control bits is not needed here. Those ar=
e
> internal details. And the "EDID read failure" is only needed in the
> commit message. What you should have here in the comment is something
> like:
>
> "OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and later have
> external pull up on the HDMI I2C lines."
>
>> + =A0 =A0 if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2)=
)
>
> Parenthesis around omap_rev are extra.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
>
> Should the define name be a bit more specific? The pull-up is about t=
he
> I2C SDA and SCL lines, right?
>
> And while I would presume that normally the SDA and SCL both either h=
ave
> external or internal pull-up, I don't see it as impossible that someb=
ody
> would need different configuration for the lines. So optimally we'd h=
ave
> separate bits for those two. However, to keep the API simpler I think
> it's fine to have only one bit for now.
>
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hdmi_init(0);
>> =A0}
>>
>> =A0#ifdef CONFIG_OMAP_MUX
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-=
omap2/board-omap4panda.c
>> index d95df2e..212e06c 100644
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
>> + =A0 =A0 =A0* OMAP4460 Panda and OMAP4430 ES2.3 Panda Boards as the
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
> Indentation missing.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_ctrl_pad_writel(reg, control_i2c_1);
>> + =A0 =A0 }
>> =A0}
>>
>> =A0static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
>> @@ -144,10 +155,10 @@ static int omap4_dsi_mux_pads(int dsi_id, unsi=
gned lanes)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -int omap_hdmi_init(void)
>> +int omap_hdmi_init(int flags)
>> =A0{
>> =A0 =A0 =A0 if (cpu_is_omap44xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap4_hdmi_mux_pads();
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_hdmi_mux_pads(flags);
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
>> index 0cb0469..df585b5 100644
>> --- a/include/video/omapdss.h
>> +++ b/include/video/omapdss.h
>> @@ -49,6 +49,8 @@
>> =A0#define DISPC_IRQ_FRAMEDONETV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 24)
>> =A0#define DISPC_IRQ_WBBUFFEROVERFLOW =A0 (1 << 25)
>>
>> +#define OMAP_HDMI_EXTERNAL_PULLUP =A0 =A00x1
>
> An enum would be nicer, so that it's clearer where this can be used. =
And
> as the flags is a bit field, you could define the value as (1 << 0) a=
s
> the custom is elsewhere in the file.
>
Will post it incorporating the changes.

Thanks and regards,
Mythri.

>> =A0struct omap_dss_device;
>> =A0struct omap_overlay_manager;
>>
>> @@ -310,7 +312,7 @@ struct omap_dss_board_info {
>> =A0/* Init with the board info */
>> =A0extern int omap_display_init(struct omap_dss_board_info *board_da=
ta);
>> =A0/* HDMI mux init*/
>> -extern int =A0omap_hdmi_init(void);
>> +extern int =A0omap_hdmi_init(int flags);
>
> Extra space between int and the function name. (in the previous patch
> also).
>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
