From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 3/3] OMAPDSS: HDMI: Sysfs support to configure quantization
Date: Fri, 6 Jan 2012 18:23:41 +0530
Message-ID: <CAP5A+B8z9VSZ=0OLJ1-D=GuEhwExaQAYBDVqkCYBdPuMb-Boog@mail.gmail.com>
References: <1325677990-16414-1-git-send-email-mythripk@ti.com>
 <1325677990-16414-2-git-send-email-mythripk@ti.com> <1325677990-16414-3-git-send-email-mythripk@ti.com>
 <1325748091.2045.22.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35478 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753238Ab2AFMyE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:54:04 -0500
Received: by mail-iy0-f180.google.com with SMTP id z13so3618820iaz.39
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 04:54:02 -0800 (PST)
In-Reply-To: <1325748091.2045.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,


On Thu, Jan 5, 2012 at 12:51 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-01-04 at 17:23 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Add sysfs support for the uset space to configure limited range or f=
ull range
>> quantization for HDMI.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dss.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0drivers/video/omap2/dss/dss_features.c | =A0 =A01 +
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 | =A0 28 +++++++++=
++++++++++++++++
>> =A0drivers/video/omap2/dss/hdmi_panel.c =A0 | =A0 35 +++++++++++++++=
++++++++++++++++-
>> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0| =A0 =A02 +
>> =A05 files changed, 67 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss=
/dss.h
>> index 6308fc5..cf1f0f9 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -498,6 +498,8 @@ int omapdss_hdmi_display_check_timing(struct oma=
p_dss_device *dssdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct omap_video_timings *timings);
>> =A0int omapdss_hdmi_read_edid(u8 *buf, int len);
>> =A0bool omapdss_hdmi_detect(void);
>> +int omapdss_hdmi_get_range(void);
>> +int omapdss_hdmi_set_range(int range);
>> =A0int hdmi_panel_init(void);
>> =A0void hdmi_panel_exit(void);
>>
>> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/=
omap2/dss/dss_features.c
>> index b402699..c7e71b9 100644
>> --- a/drivers/video/omap2/dss/dss_features.c
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -465,6 +465,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_fu=
nctions =3D {
>> =A0 =A0 =A0 .dump_core =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti=
_hdmi_4xxx_core_dump,
>> =A0 =A0 =A0 .dump_pll =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti=
_hdmi_4xxx_pll_dump,
>> =A0 =A0 =A0 .dump_phy =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti=
_hdmi_4xxx_phy_dump,
>> + =A0 =A0 .configure_range =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti_hdmi_4x=
xx_configure_range,
>>
>> =A0};
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/ds=
s/hdmi.c
>> index 4bb7678..ae7918e 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -378,6 +378,34 @@ static void hdmi_power_off(struct omap_dss_devi=
ce *dssdev)
>> =A0 =A0 =A0 hdmi_runtime_put();
>> =A0}
>>
>> +int omapdss_hdmi_set_range(int range)
>
> Range is an enum, not an int.
>
>> +{
>> + =A0 =A0 int r =3D 0;
>> + =A0 =A0 enum hdmi_range old_range;
>> +
>> + =A0 =A0 old_range =3D hdmi.ip_data.range;
>> + =A0 =A0 hdmi.ip_data.range =3D range;
>> +
>> + =A0 =A0 /* HDMI 1.3 section 6.6 VGA (640x480) format requires Full=
 Range */
>> + =A0 =A0 if ((range =3D=3D 0) &&
>
> Range is an enum, not an int.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((hdmi.ip_data.cfg.cm.code =3D=3D 4 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.ip_data.cfg.cm.mode =3D=3D HDMI_DVI) =
||
>> + =A0 =A0 =A0 =A0 =A0 =A0 (hdmi.ip_data.cfg.cm.code =3D=3D 1 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.ip_data.cfg.cm.mode =3D=3D HDMI_HDMI)=
))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 r =3D hdmi.ip_data.ops->configure_range(&hdmi.ip_data);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hdmi.ip_data.range =3D old_range;
>> +
>> + =A0 =A0 return r;
>> +}
>> +
>> +int omapdss_hdmi_get_range(void)
>
> Range is an enum, not an int... I won't comment on any more of these
> cases, please check all uses of range.
>
>> +{
>> + =A0 =A0 return hdmi.ip_data.range;
>> +}
>> +
>> =A0int omapdss_hdmi_display_check_timing(struct omap_dss_device *dss=
dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct omap_video_timings *timings)
>> =A0{
>> diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/om=
ap2/dss/hdmi_panel.c
>> index 533d5dc..c0aa922 100644
>> --- a/drivers/video/omap2/dss/hdmi_panel.c
>> +++ b/drivers/video/omap2/dss/hdmi_panel.c
>> @@ -33,6 +33,33 @@ static struct {
>> =A0 =A0 =A0 struct mutex hdmi_lock;
>> =A0} hdmi;
>>
>> +static ssize_t hdmi_range_show(struct device *dev,
>> + =A0 =A0 struct device_attribute *attr, char *buf)
>> +{
>> + =A0 =A0 int r;
>> +
>> + =A0 =A0 r =3D omapdss_hdmi_get_range();
>> + =A0 =A0 return snprintf(buf, PAGE_SIZE, "%d\n", r);
>> +}
>> +
>> +static ssize_t hdmi_range_store(struct device *dev,
>> + =A0 =A0 struct device_attribute *attr,
>> + =A0 =A0 const char *buf, size_t size)
>> +{
>> + =A0 =A0 unsigned long range;
>> + =A0 =A0 int r =3D kstrtoul(buf, 0, &range);
>> +
>> + =A0 =A0 if (r || range > 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 r =3D omapdss_hdmi_set_range(range);
>> + =A0 =A0 if (r)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> +
>> + =A0 =A0 return size;
>> +}
>
> I don't like to add a new custom userspace API, but I guess we don't
> have much choice.
>
> However, I don't think using 0 and 1 in the API is very good. The
> choices with range should probably be "full" and "limited".
>
> Btw, I tried to apply this patch set on top of dss master with and
> without the "improve the timings..." patch set, and failed both. What
> are these patches based on?
>
changes incorporated.
Thanks and regards,
Mythri.
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
