From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 3/8] OMAP4: DSS: HDMI: Use specific HDMI timings structure
Date: Thu, 23 Jun 2011 11:15:49 +0530
Message-ID: <BANLkTik0Xm46OA1ek-2tguFF7TWnLAoZgQ@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com> <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D625AA8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50242 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058Ab1FWFqM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 01:46:12 -0400
Received: by fxm11 with SMTP id 11so1596531fxm.13
        for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 22:46:09 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D625AA8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Mon, Jun 20, 2011 at 6:16 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Friday, June 17, 2011 1:47 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH 3/8] OMAP4: DSS: HDMI: Use specific HDMI
>> timings structure
>>
>> Define new HDMI timings structure to replace the OMAP DSS
>> timing strucutre in hdmi.c
>
> [sp] Fix spelling of structure.
>
Thanks will fix it.
>> to have the HDMI include defintion out of DSS.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/hdmi.c | =A0 23 ++++++++++++++++++++---
>> =A0drivers/video/omap2/dss/hdmi.h | =A0 15 ++++++++++++++-
>> =A02 files changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c
>> b/drivers/video/omap2/dss/hdmi.c
>> index 4ee879a..c24d573 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -593,6 +593,20 @@ static int read_edid(struct hdmi_ip_data
>> *ip_data, u8 *pedid, u16 max_length)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void copy_hdmi_to_dss_timings(struct
>> hdmi_video_timings hdmi_timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timings =
*timings)
>
> [sp] Assuming that we really need 2 separate structures, suggest
> =A0 =A0 renaming function to "copy_hdmi_timings_to_dss" or
> =A0 =A0 "copy_timings_hdmi_to_dss" for better readability.
>
I shall rename.
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
>> @@ -617,7 +631,7 @@ static struct hdmi_cm
>> hdmi_get_code(struct omap_video_timings *timing)
>> =A0{
>> =A0 =A0 =A0 int i =3D 0, code =3D -1, temp_vsync =3D 0, temp_hsync =3D=
 0;
>> =A0 =A0 =A0 int timing_vsync =3D 0, timing_hsync =3D 0;
>> - =A0 =A0 struct omap_video_timings temp;
>> + =A0 =A0 struct hdmi_video_timings temp;
>> =A0 =A0 =A0 struct hdmi_cm cm =3D {-1};
>> =A0 =A0 =A0 DSSDBG("hdmi_get_code\n");
>>
>> @@ -775,7 +789,8 @@ static void hdmi_read_edid(struct
>> omap_video_timings *dp)
>>
>> =A0 =A0 =A0 code =3D get_timings_index();
>>
>> - =A0 =A0 *dp =3D cea_vesa_timings[code].timings;
>> + =A0 =A0 copy_hdmi_to_dss_timings(cea_vesa_timings[code].timings, d=
p);
>> +
>> =A0}
>>
>> =A0static void hdmi_core_init(struct hdmi_core_video_config *video_c=
fg,
>> @@ -1234,7 +1249,9 @@ static int hdmi_power_on(struct
>> omap_dss_device *dssdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi_read_edid(p);
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 code =3D get_timings_index();
>> - =A0 =A0 dssdev->panel.timings =3D cea_vesa_timings[code].timings;
>> + =A0 =A0 copy_hdmi_to_dss_timings(cea_vesa_timings[code].timings,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dssdev->panel.timings);
>> +
>> =A0 =A0 =A0 update_hdmi_timings(&hdmi.cfg, p, code);
>>
>> =A0 =A0 =A0 phy =3D p->pixel_clock;
>> diff --git a/drivers/video/omap2/dss/hdmi.h
>> b/drivers/video/omap2/dss/hdmi.h
>> index f57ef4a..dcc30b7 100644
>> --- a/drivers/video/omap2/dss/hdmi.h
>> +++ b/drivers/video/omap2/dss/hdmi.h
>> @@ -188,9 +188,22 @@ struct hdmi_reg { u16 idx; };
>> =A0#define REG_GET(base, idx, start, end) \
>> =A0 =A0 =A0 FLD_GET(hdmi_read_reg(base, idx), start, end)
>>
>> +struct hdmi_video_timings {
>> + =A0 =A0 u16 x_res;
>> + =A0 =A0 u16 y_res;
>> + =A0 =A0 /* Unit: KHz */
>> + =A0 =A0 u32 pixel_clock;
>
> [sp] Could be:
> =A0 =A0 =A0 =A0u32 pixel_clock; /* unit: KHz */
>
>> + =A0 =A0 u16 hsw;
>> + =A0 =A0 u16 hfp;
>> + =A0 =A0 u16 hbp;
>> + =A0 =A0 u16 vsw;
>> + =A0 =A0 u16 vfp;
>> + =A0 =A0 u16 vbp;
>> +};
>> +
>> =A0/* HDMI timing structure */
>> =A0struct hdmi_timings {
>> - =A0 =A0 struct omap_video_timings timings;
>> + =A0 =A0 struct hdmi_video_timings timings;
>> =A0 =A0 =A0 int vsync_pol;
>> =A0 =A0 =A0 int hsync_pol;
>> =A0};
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>



--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
