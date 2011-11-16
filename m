From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Wed, 16 Nov 2011 11:01:58 +0530
Message-ID: <CAP5A+B_8fm7unbvb9_=SC62v=3+XFcoOKKA2JOttQugRTPLW8g@mail.gmail.com>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
 <1321016977-1808-2-git-send-email-mythripk@ti.com> <1321016977-1808-3-git-send-email-mythripk@ti.com>
 <1321016977-1808-4-git-send-email-mythripk@ti.com> <1321255999.1931.18.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog022.obsmtp.com ([74.125.150.84]:39655 "EHLO
	na6sys009bog022.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752691Ab1KPFcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 00:32:23 -0500
Received: by mail-iy0-f179.google.com with SMTP id i7so108472iaf.38
        for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 21:32:19 -0800 (PST)
In-Reply-To: <1321255999.1931.18.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Nov 14, 2011 at 1:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-11-11 at 18:39 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Change the timing match logic, Instead of the statically mapped meth=
od
>> to get the corresponding timings for a given code and mode, move to =
a
>> simpler array indexed method. It =A0will help to scale up to add mor=
e
>> timings when needed.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0162 ++++++++++++++++---------=
--------------
>> =A01 files changed, 67 insertions(+), 95 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index f76ae47..b859350 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -58,8 +58,6 @@
>> =A0#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR =A0 4
>> =A0#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR =A0 4
>>
>> -#define OMAP_HDMI_TIMINGS_NB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 34
>> -
>> =A0#define HDMI_DEFAULT_REGN 16
>> =A0#define HDMI_DEFAULT_REGM2 1
>>
>> @@ -88,7 +86,7 @@ static struct {
>> =A0 * map it to corresponding CEA or VESA index.
>> =A0 */
>>
>> -static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_=
NB] =3D {
>> +static const struct hdmi_config cea_timings[] =3D {
>> =A0{ {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDM=
I} },
>> =A0{ {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI=
} },
>> =A0{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_H=
DMI} },
>> @@ -104,6 +102,8 @@ static const struct hdmi_config cea_vesa_timings=
[OMAP_HDMI_TIMINGS_NB] =3D {
>> =A0{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI=
_HDMI} },
>> =A0{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI=
_HDMI} },
>> =A0{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI=
_HDMI} },
>> +};
>> +static const struct hdmi_config vesa_timings[] =3D {
>> =A0/* VESA From Here */
>> =A0{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DV=
I} },
>> =A0{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DV=
I} },
>> @@ -126,39 +126,6 @@ static const struct hdmi_config cea_vesa_timing=
s[OMAP_HDMI_TIMINGS_NB] =3D {
>> =A0{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDM=
I_DVI} }
>> =A0};
>>
>> -/*
>> - * This is a static mapping array which maps the timing values
>> - * with corresponding CEA / VESA code
>> - */
>> -static const int code_index[OMAP_HDMI_TIMINGS_NB] =3D {
>> - =A0 =A0 1, 19, 4, 2, 37, 6, 21, 20, 5, 16, 17, 29, 31, 35, 32,
>> - =A0 =A0 /* <--15 CEA 17--> vesa*/
>> - =A0 =A0 4, 9, 0xE, 0x17, 0x1C, 0x27, 0x20, 0x23, 0x10, 0x2A,
>> - =A0 =A0 0X2F, 0x3A, 0X51, 0X52, 0x16, 0x29, 0x39, 0x1B
>> -};
>> -
>> -/*
>> - * This is reverse static mapping which maps the CEA / VESA code
>> - * to the corresponding timing values
>> - */
>> -static const int code_cea[39] =3D {
>> - =A0 =A0 -1, =A00, =A03, =A03, =A02, =A08, =A05, =A05, -1, -1,
>> - =A0 =A0 -1, -1, -1, -1, -1, -1, =A09, 10, 10, =A01,
>> - =A0 =A0 7, =A0 6, =A06, -1, -1, -1, -1, -1, -1, 11,
>> - =A0 =A0 11, 12, 14, -1, -1, 13, 13, =A04, =A04
>> -};
>> -
>> -static const int code_vesa[85] =3D {
>> - =A0 =A0 -1, -1, -1, -1, 15, -1, -1, -1, -1, 16,
>> - =A0 =A0 -1, -1, -1, -1, 17, -1, 23, -1, -1, -1,
>> - =A0 =A0 -1, -1, 29, 18, -1, -1, -1, 32, 19, -1,
>> - =A0 =A0 -1, -1, 21, -1, -1, 22, -1, -1, -1, 20,
>> - =A0 =A0 -1, 30, 24, -1, -1, -1, -1, 25, -1, -1,
>> - =A0 =A0 -1, -1, -1, -1, -1, -1, -1, 31, 26, -1,
>> - =A0 =A0 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
>> - =A0 =A0 -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
>> - =A0 =A0 -1, 27, 28, -1, 33};
>> -
>> =A0static int hdmi_runtime_get(void)
>> =A0{
>> =A0 =A0 =A0 int r;
>> @@ -188,82 +155,88 @@ int hdmi_init_display(struct omap_dss_device *=
dssdev)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static int get_timings_index(void)
>> +static bool hdmi_find_code(const struct hdmi_config *timings_arr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len, struct hdmi_confi=
g *timing)
>> =A0{
>> - =A0 =A0 int code;
>> + =A0 =A0 int i;
>>
>> - =A0 =A0 if (hdmi.mode =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_vesa[hdmi.code];
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_cea[hdmi.code];
>> + =A0 =A0 for (i =3D 0; i < len; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (timings_arr[i].cm.code =3D=3D hdmi.cod=
e) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *timing =3D timings_arr[i]=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return false;
>> +}
>
> You could return the hdmi_config pointer instead of making a copy and
> returning a bool.
In this function i'm passing the timing value and finally there needs
to be one copy whether it is in this function or after the return,
because the timings array is a const and dssdev->paneltimings and
config timings are not, so do you see any benefit of doing that later
or suggest any other method?

>
> You shouldn't use hdmi.code in this function, but get the code as a
> parameter.
>
>>
>> - =A0 =A0 if (code =3D=3D -1) {
>> +static void hdmi_get_timings(struct hdmi_config *timing)
>> +{
>> + =A0 =A0 int r;
>> +
>> + =A0 =A0 if (hdmi.mode =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D hdmi_find_code(vesa_timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ARRAY_SIZE(vesa_timings), timing);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D =A0hdmi_find_code(cea_timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ARRAY_SIZE(cea_timings), timing);
>> + =A0 =A0 }
>> + =A0 =A0 if (!r) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HDMI code 4 corresponds to 640 * 480 =
VGA */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.code =3D 4;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DVI mode 1 corresponds to HDMI 0 to D=
VI */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.mode =3D HDMI_DVI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 *timing =3D vesa_timings[0];
>> + =A0 =A0 }
>> +}
>
> Same thing here, you could just return the pointer to hdmi_config.
>
> And also for this function you shouldn't use hdmi.mode and hdmi.code,
> but they should be parameters to this function.
>
In the next patch i remove the hdmi.code and mode and use the config in=
stead.

> And the code in the error path shouldn't modify hdmi.code or hdmi.mod=
e,
> it should just return NULL, and the caller would then do what it want=
s,
> in this case use VGA as a fallback.
ok.
>
>> +
>> +static bool hdmi_timings_compare(struct omap_video_timings *timing,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const stru=
ct hdmi_video_timings *temp)
>
> Don't call the second argument "temp". It's not a temporary variable.
> Naming the parameters timing1 and timing2 would make much more sense.
>
ok.

Thanks and regards,
Mythri.
> =A0Tomi
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
