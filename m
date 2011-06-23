From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 3/8] OMAP4: DSS: HDMI: Use specific HDMI timings structure
Date: Thu, 23 Jun 2011 14:16:12 +0530
Message-ID: <BANLkTikmUfo=sJ6-wrhbYeDCJOySc7NnMg@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com> <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com> <1308817843.1834.40.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51609 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758942Ab1FWIqu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 04:46:50 -0400
Received: by fxm1 with SMTP id 1so1353561fxm.15
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 01:46:47 -0700 (PDT)
In-Reply-To: <1308817843.1834.40.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Thu, Jun 23, 2011 at 2:00 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-06-17 at 13:47 +0530, Mythri P K wrote:
>> Define new HDMI timings structure to replace the OMAP DSS timing str=
ucutre in hdmi.c
>> to have the HDMI include defintion out of DSS.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0 23 ++++++++++++++++++++---
>> =A0drivers/video/omap2/dss/hdmi.h | =A0 15 ++++++++++++++-
>> =A02 files changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 4ee879a..c24d573 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -593,6 +593,20 @@ static int read_edid(struct hdmi_ip_data *ip_da=
ta, u8 *pedid, u16 max_length)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void copy_hdmi_to_dss_timings(struct hdmi_video_timings hdmi=
_timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timings =
*timings)
>
> There's no reason to pass hdmi_timings as a value, so it should be a
> pointer.
As the hdmi_timings is not changed in the function , i passed it by
value, Not a problem to change.
>
>> +{
>> + =A0 =A0 timings->x_res =3D hdmi_timings.x_res;
>> + =A0 =A0 timings->y_res =3D hdmi_timings.y_res;
>> + =A0 =A0 timings->pixel_clock =3D hdmi_timings.pixel_clock;
>> + =A0 =A0 timings->hbp =3D hdmi_timings.hbp;
>> + =A0 =A0 timings->hfp =3D hdmi_timings.hfp;
>> + =A0 =A0 timings->hsw =3D hdmi_timings.hsw;
>> + =A0 =A0 timings->vbp =3D hdmi_timings.vbp;
>> + =A0 =A0 timings->vfp =3D hdmi_timings.vfp;
>> + =A0 =A0 timings->vsw =3D hdmi_timings.vsw;
>> +}
>> +
>> =A0static int get_timings_index(void)
>> =A0{
>> =A0 =A0 =A0 int code;
>> @@ -617,7 +631,7 @@ static struct hdmi_cm hdmi_get_code(struct omap_=
video_timings *timing)
>> =A0{
>> =A0 =A0 =A0 int i =3D 0, code =3D -1, temp_vsync =3D 0, temp_hsync =3D=
 0;
>> =A0 =A0 =A0 int timing_vsync =3D 0, timing_hsync =3D 0;
>> - =A0 =A0 struct omap_video_timings temp;
>> + =A0 =A0 struct hdmi_video_timings temp;
>> =A0 =A0 =A0 struct hdmi_cm cm =3D {-1};
>> =A0 =A0 =A0 DSSDBG("hdmi_get_code\n");
>>
>> @@ -775,7 +789,8 @@ static void hdmi_read_edid(struct omap_video_tim=
ings *dp)
>
> "dp" feels a rather odd name for video timings variable. What does it
> stand for?

*display pointer, but then it is not a part of this patch.

>
> =A0Tomi
>
>
>



--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
