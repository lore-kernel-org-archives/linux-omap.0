From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: HDMI: Move duplicate code from boardfile to
Date: Tue, 25 Oct 2011 15:11:17 +0530
Message-ID: <CAP5A+B9F8f+qZJg6DM1c78wj=o=rwh35bOsAEnLW4Bqr7oGVLA@mail.gmail.com>
References: <1319189211-10991-1-git-send-email-mythripk@ti.com> <1319195561.2870.75.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50680 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755821Ab1JYJlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Oct 2011 05:41:37 -0400
Received: by mail-iy0-f182.google.com with SMTP id y10so541494iak.13
        for <linux-omap@vger.kernel.org>; Tue, 25 Oct 2011 02:41:37 -0700 (PDT)
In-Reply-To: <1319195561.2870.75.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Oct 21, 2011 at 4:42 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-10-21 at 14:56 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Move duplicate HDMI mux_init code from omap4 and panda board file
>> to display file.
>
> The subject is again broken.
>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0| =A0 15 -------------=
--
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 16 ----------------
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0| =A0 25 +++++++=
++++++++++++++++++
>> =A03 files changed, 25 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index 6d16306..4fcdf38 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -601,20 +601,6 @@ static void __init omap_sfh7741prox_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, OMAP4_SFH7741_=
ENABLE_GPIO, error);
>> =A0}
>>
>> -static void sdp4430_hdmi_mux_init(void)
>> -{
>> - =A0 =A0 /* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
>> - =A0 =A0 omap_mux_init_signal("hdmi_hpd",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 omap_mux_init_signal("hdmi_cec",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 /* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
>> - =A0 =A0 omap_mux_init_signal("hdmi_ddc_scl",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 omap_mux_init_signal("hdmi_ddc_sda",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> -}
>> -
>> =A0static struct gpio sdp4430_hdmi_gpios[] =3D {
>> =A0 =A0 =A0 { HDMI_GPIO_HPD, =A0 =A0 =A0 =A0GPIOF_OUT_INIT_HIGH, =A0=
 =A0"hdmi_gpio_hpd" =A0 },
>> =A0 =A0 =A0 { HDMI_GPIO_LS_OE, =A0 =A0 =A0GPIOF_OUT_INIT_HIGH, =A0 =A0=
"hdmi_gpio_ls_oe" },
>> @@ -844,7 +830,6 @@ static void omap_4430sdp_display_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Could not get display_sel GP=
IO\n", __func__);
>>
>> =A0 =A0 =A0 sdp4430_lcd_init();
>> - =A0 =A0 sdp4430_hdmi_mux_init();
>> =A0 =A0 =A0 sdp4430_picodlp_init();
>> =A0 =A0 =A0 omap_display_init(&sdp4430_dss_data);
>> =A0}
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-=
omap2/board-omap4panda.c
>> index a38ed273..bb5fca2 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -484,21 +484,6 @@ int __init omap4_panda_dvi_init(void)
>> =A0 =A0 =A0 return r;
>> =A0}
>>
>> -
>> -static void omap4_panda_hdmi_mux_init(void)
>> -{
>> - =A0 =A0 /* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
>> - =A0 =A0 omap_mux_init_signal("hdmi_hpd",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 omap_mux_init_signal("hdmi_cec",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 /* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
>> - =A0 =A0 omap_mux_init_signal("hdmi_ddc_scl",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> - =A0 =A0 omap_mux_init_signal("hdmi_ddc_sda",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> -}
>> -
>> =A0static struct gpio panda_hdmi_gpios[] =3D {
>> =A0 =A0 =A0 { HDMI_GPIO_HPD, =A0 =A0 =A0 =A0GPIOF_OUT_INIT_HIGH, "hd=
mi_gpio_hpd" =A0 },
>> =A0 =A0 =A0 { HDMI_GPIO_LS_OE, =A0 =A0 =A0GPIOF_OUT_INIT_HIGH, "hdmi=
_gpio_ls_oe" },
>> @@ -550,7 +535,6 @@ void omap4_panda_display_init(void)
>> =A0 =A0 =A0 if (r)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error initializing panda DVI\n")=
;
>>
>> - =A0 =A0 omap4_panda_hdmi_mux_init();
>> =A0 =A0 =A0 omap_display_init(&omap4_panda_dss_data);
>> =A0}
>>
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/dis=
play.c
>> index 94a96ce..f6590b9 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -28,6 +28,7 @@
>> =A0#include <plat/omap-pm.h>
>> =A0#include <plat/common.h>
>>
>> +#include "mux.h"
>> =A0#include "control.h"
>> =A0#include "display.h"
>>
>> @@ -103,6 +104,20 @@ static const struct omap_dss_hwmod_data omap4_d=
ss_hwmod_data[] __initdata =3D {
>> =A0 =A0 =A0 { "dss_hdmi", "omapdss_hdmi", -1 },
>> =A0};
>>
>> +static void omap4_hdmi_mux_pads(void)
>> +{
>> + =A0 =A0 /* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
>> + =A0 =A0 omap_mux_init_signal("hdmi_hpd",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 omap_mux_init_signal("hdmi_cec",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 /* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
>> + =A0 =A0 omap_mux_init_signal("hdmi_ddc_scl",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 omap_mux_init_signal("hdmi_ddc_sda",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT_PULLUP);
>> +}
>> +
>> =A0static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
>> =A0{
>> =A0 =A0 =A0 u32 enable_mask, enable_shift;
>> @@ -136,6 +151,14 @@ static int omap4_dsi_mux_pads(int dsi_id, unsig=
ned lanes)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static int omap_hdmi_enable_pads(void)
>> +{
>> + =A0 =A0 if (cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4_hdmi_mux_pads();
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
>> =A0{
>> =A0 =A0 =A0 if (cpu_is_omap44xx())
>> @@ -172,6 +195,8 @@ int __init omap_display_init(struct omap_dss_boa=
rd_info *board_data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh_count =3D ARRAY_SIZE(omap4_dss_hwmod_=
data);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 omap_hdmi_enable_pads();
>
> Now this would be done for all boards, even those without HDMI. I don=
't
> think that's right, as the HDMI pins can probably be used for somethi=
ng
> else.
I guess there is a check for omap4 in the enable_pads.
>
> Should there be similar system than for DSI, so an enable and disable
> function for the pads, called from the hdmi driver?
>
> However, for DSI we need to change the pins during runtime, so that's
> why the functions for DSI are required. If the HDMI configuration is
> more static, and needs to be done only once at boot time, perhaps the
> display_init function could go through the displays from the board_da=
ta,
> and if there's an HDMI display defined, do the muxing.
Mux configuration for HDMI is static unlike for DSI, Also i have added
a check for OMAP4,
I am not aware of any OMAP4 board without the HDMI today.
It appears to me that even other modules do their mux configuration in
board-file.
Let me know if there is anything you think can improve it.

Thanks and regards,
Mythri.
>
> So is there ever need to change the hdmi pins after they have been
> configured? I guess the pins could be changed to safe mode when not i=
n
> use, preserving some power, but I don't know if that difference is
> noticeable.
>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
