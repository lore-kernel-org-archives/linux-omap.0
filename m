From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 2/8] OMAP4 : DSS2 : Add display structure in the board
 file for OMAP4 sdp
Date: Mon, 28 Feb 2011 11:02:42 +0530
Message-ID: <AANLkTimizZGZrjk59e_k9w2NrRi5hjCy8tQxKb529C8e@mail.gmail.com>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	<1298643715-21540-3-git-send-email-mythripk@ti.com>
	<1298798004.1977.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40412 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab1B1Fcn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 00:32:43 -0500
Received: by mail-vw0-f53.google.com with SMTP id 8so2988873vws.12
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 21:32:42 -0800 (PST)
In-Reply-To: <1298798004.1977.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,


On Sun, Feb 27, 2011 at 2:43 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
>> Adding =A0board file changes for display which adds the display stru=
cture
>> with HDMI as the default driver when the display init is called.
>> HDMI GPIO configurations are also done in this file.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 82 ++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 82 insertions(+), 0 deletions(-)
>
> You could move this patch in the end of the set, together with the pa=
nda
> board patch.
>
> The prefix "OMAP4: DSS2" is not quite right for this, as this is a bo=
ard
> file change. And you should mention HDMI in the subject. Perhaps
> something like "OMAP: 4430SDP: Add HDMI support"
>
Sure i will move and change the patch name.
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index 07d1b20..334b6fd 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -35,6 +35,7 @@
>> =A0#include <plat/common.h>
>> =A0#include <plat/usb.h>
>> =A0#include <plat/mmc.h>
>> +#include <plat/display.h>
>>
>> =A0#include "mux.h"
>> =A0#include "hsmmc.h"
>> @@ -47,6 +48,8 @@
>> =A0#define OMAP4SDP_MDM_PWR_EN_GPIO =A0 =A0 157
>> =A0#define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO =A0 =A0 184
>> =A0#define OMAP4_SFH7741_ENABLE_GPIO =A0 =A0 =A0 =A0 =A0 =A0188
>> +#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
>> +#define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
>>
>> =A0static struct gpio_led sdp4430_gpio_leds[] =3D {
>> =A0 =A0 =A0 {
>> @@ -552,6 +555,84 @@ static void __init omap_sfh7741prox_init(void)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static void sdp4430_hdmi_mux_init(void)
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
>> +static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev=
)
>> +{
>> + =A0 =A0 int status;
>
> r is quite often used as a name for return values.
>
Variable status is consistent with other gpio request calls made in the=
 file ,
so it would be good to have status instead of r ,
I have used r in all DSS files though.
>> +
>> + =A0 =A0 status =3D gpio_request_one(HDMI_GPIO_HPD, GPIOF_DIR_OUT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hdmi_gpio_hpd");
>> + =A0 =A0 if (status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot request GPIO %d\n", HDMI_GP=
IO_HPD);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return status;
>> + =A0 =A0 }
>> + =A0 =A0 status =3D gpio_request_one(HDMI_GPIO_LS_OE, GPIOF_DIR_OUT=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hdmi_gpio_ls_oe");
>> + =A0 =A0 if (status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot request GPIO %d\n", HDMI_GP=
IO_LS_OE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* The value set a pulse */
>
> I still don't understand that comment. It's not even English.
I was seeing issues where I had to set the pulse [ 101] , But i no
longer see the problem in my tests.
So i shall just enable GPIO.
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
