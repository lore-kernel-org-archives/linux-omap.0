From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v5 08/17] OMAP2,3: DSS2: Build omap_device for each DSS HWIP
Date: Sun, 9 Jan 2011 13:34:11 +0530
Message-ID: <AANLkTimKE4SQZYygXef4Ax14X0Y9pnD65RivGqLA_UiG@mail.gmail.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
 <1294399551-10457-9-git-send-email-sumit.semwal@ti.com> <87zkrci8zb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44262 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab1AIIEp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 9 Jan 2011 03:04:45 -0500
Received: by bwz10 with SMTP id 10so12108628bwz.24
        for <linux-omap@vger.kernel.org>; Sun, 09 Jan 2011 00:04:31 -0800 (PST)
In-Reply-To: <87zkrci8zb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi Kevin,

On Sat, Jan 8, 2011 at 5:04 AM, Kevin Hilman <khilman@ti.com> wrote:
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> Looks up the hwmod database for each of the given DSS HW IP and buil=
ds
>> omap_device which inturn does the platform device register for each =
of DSS HW IP
>>
>> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 44 ++=
+++++++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/display.h | =A0 =A06 ++++
>> =A02 files changed, 50 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/dis=
play.c
>> index 26d3feb..276b800 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -36,10 +36,54 @@ static struct platform_device omap_display_devic=
e =3D {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +static struct omap_device_pm_latency omap_dss_latency[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =A0 =A0 =A0 =A0=3D omap_d=
evice_idle_hwmods,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =A0 =A0 =A0 =A0=3D omap=
_device_enable_hwmods,
>
> Without any latency numbers or AUTO_ADJUST you're going to have noisy
> output from omap_device.
>
>> + =A0 =A0 },
>> +};
>> +
>> =A0int __init omap_display_init(struct omap_dss_board_info
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 *board_data)
>> =A0{
>> =A0 =A0 =A0 int r =3D 0;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 int i;
>> + =A0 =A0 struct omap_display_platform_data pdata;
>> + =A0 =A0 char *oh_name[] =3D { =A0 =A0 "dss_dss", =A0 =A0 =A0/* oma=
p2,3 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dss_dispc=
", =A0 =A0/* omap2,3 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dss_rfbi"=
, =A0 =A0 /* omap2,3 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dss_venc"=
, =A0 =A0 /* omap2,3 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dss_dsi1"=
 }; =A0 /* omap3 */
>
> Why all the extra whitespace before the strings?
>
>> + =A0 =A0 char *dev_name[] =3D { "omap_dss", "omap_dispc", "omap_rfb=
i",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "omap_venc=
", "omap_dsi1" };
>
> ditto
>
>> + =A0 =A0 int oh_count;
>> +
>> + =A0 =A0 if (cpu_is_omap24xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh_count =3D ARRAY_SIZE(oh_name) - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* last hwmod dev in oh_name is not availa=
ble for omap2 */
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh_count =3D ARRAY_SIZE(oh_name);
>> + =A0 =A0 }
>
> braces not needed
>
>> + =A0 =A0 pdata.board_data =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 board_data=
;
>
> extra whitespace not necessary
>
>> + =A0 =A0 pdata.board_data->get_last_off_on_transaction_id =3D NULL;
>
> instead, you should probably zero all of pdata before using it since =
it
> is on the stack
>
>> + =A0 =A0 for (i =3D 0; i < oh_count; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_hwmod_lookup(oh_name[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!oh) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up =
%s\n", oh_name[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 od =3D omap_device_build(dev_name[i], -1, =
oh, &pdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(str=
uct omap_display_platform_data),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dss_l=
atency,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE=
(omap_dss_latency), 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN((IS_ERR(od)), "Could not build omap_d=
evice for %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh_name[i]=
);
>
> yet code below will still try and register it?
>
>> + =A0 =A0 }
>> =A0 =A0 =A0 omap_display_device.dev.platform_data =3D board_data;
>>
>> =A0 =A0 =A0 r =3D platform_device_register(&omap_display_device);
>> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/pl=
at-omap/include/plat/display.h
>> index 871bbae..23afd6d 100644
>> --- a/arch/arm/plat-omap/include/plat/display.h
>> +++ b/arch/arm/plat-omap/include/plat/display.h
>> @@ -26,6 +26,7 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <asm/atomic.h>
>>
>> +
>
> stray whitespace change
>
>> =A0#define DISPC_IRQ_FRAMEDONE =A0 =A0 =A0 =A0 =A0(1 << 0)
>> =A0#define DISPC_IRQ_VSYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 1)
>> =A0#define DISPC_IRQ_EVSYNC_EVEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <=
< 2)
>> @@ -224,6 +225,11 @@ struct omap_dss_board_info {
>> =A0/* Init with the board info */
>> =A0extern int omap_display_init(struct omap_dss_board_info *board_da=
ta);
>>
>> +struct omap_display_platform_data {
>> + =A0 =A0 struct omap_dss_board_info *board_data;
>> + =A0 =A0 /* TODO: Additional members to be added when PM is conside=
red */
>> +};
>> +
>> =A0struct omap_video_timings {
>> =A0 =A0 =A0 /* Unit: pixels */
>> =A0 =A0 =A0 u16 x_res;
>
Thanks for all your comments; will incorporate in the upcoming version.

Best regards,
~Sumit.
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
