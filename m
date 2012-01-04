From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 1/3 REPOST] OMAPDSS: HDMI: Move Avi infoframe structure to
Date: Wed, 4 Jan 2012 17:31:40 +0530
Message-ID: <CAP5A+B8yQubhwALuSAV65vDjf4nD=3mti77VFez+AK-fY8CrKQ@mail.gmail.com>
References: <1325494735-30160-1-git-send-email-mythripk@ti.com> <1325585381.1973.33.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:53162 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754063Ab2ADMCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jan 2012 07:02:02 -0500
Received: by mail-iy0-f178.google.com with SMTP id f6so33913006iag.9
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 04:02:01 -0800 (PST)
In-Reply-To: <1325585381.1973.33.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Tue, Jan 3, 2012 at 3:39 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> Hi,
>
> Again the subjects are cut off in mid sentence. And the patch series
> contains patch 1 two times.
>
> Please use git-format-patch and git-send-email to send proper patches=
,
> and please check the patches before sending.
I resent the patches with fixed header.

Thanks and regards,
Mythri.
>
> =A0Tomi
>
> On Mon, 2012-01-02 at 14:28 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> With AVI infoframe various parameters of video stream such as
>> aspect ratio, quantization range, videocode etc will be indicated
>> from source to sink.Thus AVI information needs to be set/accessed
>> by the middle ware based on the video content.
>> Thus this parameter is now moved to the ip_data structure.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0 =A0 | =A0 42 ++++++=
+++++++++++++++++++++++
>> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | =A0 =A08 +++---
>> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | =A0 40 --------------=
-------------
>> =A03 files changed, 46 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2=
/dss/ti_hdmi.h
>> index 3cf5198..835cfb1 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi.h
>> +++ b/drivers/video/omap2/dss/ti_hdmi.h
>> @@ -108,6 +108,47 @@ struct ti_hdmi_ip_ops {
>>
>> =A0};
>>
>> +/*
>> + * Refer to section 8.2 in HDMI 1.3 specification for
>> + * details about infoframe databytes
>> + */
>> +struct hdmi_core_infoframe_avi {
>> + =A0 =A0 /* Y0, Y1 rgb,yCbCr */
>> + =A0 =A0 u8 =A0 =A0 =A0db1_format;
>> + =A0 =A0 /* A0 =A0Active information Present */
>> + =A0 =A0 u8 =A0 =A0 =A0db1_active_info;
>> + =A0 =A0 /* B0, B1 Bar info data valid */
>> + =A0 =A0 u8 =A0 =A0 =A0db1_bar_info_dv;
>> + =A0 =A0 /* S0, S1 scan information */
>> + =A0 =A0 u8 =A0 =A0 =A0db1_scan_info;
>> + =A0 =A0 /* C0, C1 colorimetry */
>> + =A0 =A0 u8 =A0 =A0 =A0db2_colorimetry;
>> + =A0 =A0 /* M0, M1 Aspect ratio (4:3, 16:9) */
>> + =A0 =A0 u8 =A0 =A0 =A0db2_aspect_ratio;
>> + =A0 =A0 /* R0...R3 Active format aspect ratio */
>> + =A0 =A0 u8 =A0 =A0 =A0db2_active_fmt_ar;
>> + =A0 =A0 /* ITC IT content. */
>> + =A0 =A0 u8 =A0 =A0 =A0db3_itc;
>> + =A0 =A0 /* EC0, EC1, EC2 Extended colorimetry */
>> + =A0 =A0 u8 =A0 =A0 =A0db3_ec;
>> + =A0 =A0 /* Q1, Q0 Quantization range */
>> + =A0 =A0 u8 =A0 =A0 =A0db3_q_range;
>> + =A0 =A0 /* SC1, SC0 Non-uniform picture scaling */
>> + =A0 =A0 u8 =A0 =A0 =A0db3_nup_scaling;
>> + =A0 =A0 /* VIC0..6 Video format identification */
>> + =A0 =A0 u8 =A0 =A0 =A0db4_videocode;
>> + =A0 =A0 /* PR0..PR3 Pixel repetition factor */
>> + =A0 =A0 u8 =A0 =A0 =A0db5_pixel_repeat;
>> + =A0 =A0 /* Line number end of top bar */
>> + =A0 =A0 u16 =A0 =A0 db6_7_line_eoftop;
>> + =A0 =A0 /* Line number start of bottom bar */
>> + =A0 =A0 u16 =A0 =A0 db8_9_line_sofbottom;
>> + =A0 =A0 /* Pixel number end of left bar */
>> + =A0 =A0 u16 =A0 =A0 db10_11_pixel_eofleft;
>> + =A0 =A0 /* Pixel number start of right bar */
>> + =A0 =A0 u16 =A0 =A0 db12_13_pixel_sofright;
>> +};
>> +
>> =A0struct hdmi_ip_data {
>> =A0 =A0 =A0 void __iomem =A0 =A0*base_wp; =A0 =A0 =A0 /* HDMI wrappe=
r */
>> =A0 =A0 =A0 unsigned long =A0 core_sys_offset;
>> @@ -117,6 +158,7 @@ struct hdmi_ip_data {
>> =A0 =A0 =A0 const struct ti_hdmi_ip_ops *ops;
>> =A0 =A0 =A0 struct hdmi_config cfg;
>> =A0 =A0 =A0 struct hdmi_pll_info pll_data;
>> + =A0 =A0 struct hdmi_core_infoframe_avi avi_cfg;
>> =A0};
>> =A0int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>> =A0void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
>> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/vid=
eo/omap2/dss/ti_hdmi_4xxx_ip.c
>> index ccc6254..b66d82e 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
>> @@ -534,12 +534,12 @@ static void hdmi_core_video_config(struct hdmi=
_ip_data *ip_data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HDMI_CORE_SYS_TMDS_CTRL,=
 cfg->tclk_sel_clkmult, 6, 5);
>> =A0}
>>
>> -static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data =
*ip_data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_core_infoframe_avi info_avi)
>> +static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data =
*ip_data)
>> =A0{
>> =A0 =A0 =A0 u32 val;
>> =A0 =A0 =A0 char sum =3D 0, checksum =3D 0;
>> =A0 =A0 =A0 void __iomem *av_base =3D hdmi_av_base(ip_data);
>> + =A0 =A0 struct hdmi_core_infoframe_avi info_avi =3D ip_data->avi_c=
fg;
>>
>> =A0 =A0 =A0 sum +=3D 0x82 + 0x002 + 0x00D;
>> =A0 =A0 =A0 hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_TYPE, 0x082);
>> @@ -718,7 +718,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip=
_data *ip_data)
>> =A0 =A0 =A0 struct omap_video_timings video_timing;
>> =A0 =A0 =A0 struct hdmi_video_format video_format;
>> =A0 =A0 =A0 /* HDMI core */
>> - =A0 =A0 struct hdmi_core_infoframe_avi avi_cfg;
>> + =A0 =A0 struct hdmi_core_infoframe_avi avi_cfg =3D ip_data->avi_cf=
g;
>> =A0 =A0 =A0 struct hdmi_core_video_config v_core_cfg;
>> =A0 =A0 =A0 struct hdmi_core_packet_enable_repeat repeat_cfg;
>> =A0 =A0 =A0 struct hdmi_config *cfg =3D &ip_data->cfg;
>> @@ -780,7 +780,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip=
_data *ip_data)
>> =A0 =A0 =A0 avi_cfg.db10_11_pixel_eofleft =3D 0;
>> =A0 =A0 =A0 avi_cfg.db12_13_pixel_sofright =3D 0;
>>
>> - =A0 =A0 hdmi_core_aux_infoframe_avi_config(ip_data, avi_cfg);
>> + =A0 =A0 hdmi_core_aux_infoframe_avi_config(ip_data);
>>
>> =A0 =A0 =A0 /* enable/repeat the infoframe */
>> =A0 =A0 =A0 repeat_cfg.avi_infoframe =3D HDMI_PACKETENABLE;
>> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/vid=
eo/omap2/dss/ti_hdmi_4xxx_ip.h
>> index 914bec6..21f1d82 100644
>> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
>> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
>> @@ -450,46 +450,6 @@ struct hdmi_core_video_config {
>> =A0 * Refer to section 8.2 in HDMI 1.3 specification for
>> =A0 * details about infoframe databytes
>> =A0 */
>> -struct hdmi_core_infoframe_avi {
>> - =A0 =A0 /* Y0, Y1 rgb,yCbCr */
>> - =A0 =A0 u8 =A0 =A0 =A0db1_format;
>> - =A0 =A0 /* A0 =A0Active information Present */
>> - =A0 =A0 u8 =A0 =A0 =A0db1_active_info;
>> - =A0 =A0 /* B0, B1 Bar info data valid */
>> - =A0 =A0 u8 =A0 =A0 =A0db1_bar_info_dv;
>> - =A0 =A0 /* S0, S1 scan information */
>> - =A0 =A0 u8 =A0 =A0 =A0db1_scan_info;
>> - =A0 =A0 /* C0, C1 colorimetry */
>> - =A0 =A0 u8 =A0 =A0 =A0db2_colorimetry;
>> - =A0 =A0 /* M0, M1 Aspect ratio (4:3, 16:9) */
>> - =A0 =A0 u8 =A0 =A0 =A0db2_aspect_ratio;
>> - =A0 =A0 /* R0...R3 Active format aspect ratio */
>> - =A0 =A0 u8 =A0 =A0 =A0db2_active_fmt_ar;
>> - =A0 =A0 /* ITC IT content. */
>> - =A0 =A0 u8 =A0 =A0 =A0db3_itc;
>> - =A0 =A0 /* EC0, EC1, EC2 Extended colorimetry */
>> - =A0 =A0 u8 =A0 =A0 =A0db3_ec;
>> - =A0 =A0 /* Q1, Q0 Quantization range */
>> - =A0 =A0 u8 =A0 =A0 =A0db3_q_range;
>> - =A0 =A0 /* SC1, SC0 Non-uniform picture scaling */
>> - =A0 =A0 u8 =A0 =A0 =A0db3_nup_scaling;
>> - =A0 =A0 /* VIC0..6 Video format identification */
>> - =A0 =A0 u8 =A0 =A0 =A0db4_videocode;
>> - =A0 =A0 /* PR0..PR3 Pixel repetition factor */
>> - =A0 =A0 u8 =A0 =A0 =A0db5_pixel_repeat;
>> - =A0 =A0 /* Line number end of top bar */
>> - =A0 =A0 u16 =A0 =A0 db6_7_line_eoftop;
>> - =A0 =A0 /* Line number start of bottom bar */
>> - =A0 =A0 u16 =A0 =A0 db8_9_line_sofbottom;
>> - =A0 =A0 /* Pixel number end of left bar */
>> - =A0 =A0 u16 =A0 =A0 db10_11_pixel_eofleft;
>> - =A0 =A0 /* Pixel number start of right bar */
>> - =A0 =A0 u16 =A0 =A0 db12_13_pixel_sofright;
>> -};
>> -/*
>> - * Refer to section 8.2 in HDMI 1.3 specification for
>> - * details about infoframe databytes
>> - */
>> =A0struct hdmi_core_infoframe_audio {
>> =A0 =A0 =A0 u8 db1_coding_type;
>> =A0 =A0 =A0 u8 db1_channel_count;
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
