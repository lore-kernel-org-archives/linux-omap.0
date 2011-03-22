From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Date: Tue, 22 Mar 2011 14:32:43 -0400
Message-ID: <AANLkTimbfet9rBXazFYjd_QbD9WqVgsAiEwjMBxJjYJs@mail.gmail.com>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1300815176-21206-1-git-send-email-mythripk@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Mythri P K <mythripk@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: linux-omap@vger.kernel.org

Adding dri-devel.

On Tue, Mar 22, 2011 at 1:32 PM, Mythri P K <mythripk@ti.com> wrote:
> Adding support for common EDID parsing in kernel.
>
> EDID - Extended display identification data is a data structure provi=
ded by
> a digital display to describe its capabilities to a video source, Thi=
s a
> standard supported by CEA and VESA.
>
> There are several custom implementations for parsing EDID in kernel, =
some
> of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, Ideally
> parsing of EDID should be done in a library, which is agnostic of the
> framework (V4l2, DRM, FB) =A0which is using the functionality, just b=
ased on
> the raw EDID pointer with size/segment information.
>
> With other RFC's such as the one below, which tries to standardize HD=
MI API's
> It would be better to have a common EDID code in one place.It also he=
lps to
> provide better interoperability with variety of TV/Monitor may be eve=
n by
> listing out quirks which might get missed with several custom impleme=
ntation
> of EDID.
> http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastruc=
ture/30401
>
> This patch tries to add functions to parse some portion EDID (detaile=
d timing,
> monitor limits, AV delay information, deep color mode support, Audio =
and VSDB)
> If we can align on this library approach i can enhance this library t=
o parse
> other blocks and probably we could also add quirks from other impleme=
ntation
> as well.
>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
> =A0arch/arm/include/asm/edid.h | =A0243 +++++++++++++++++++++++++++++=
+
> =A0drivers/video/edid.c =A0 =A0 =A0 =A0| =A0340 +++++++++++++++++++++=
++++++++++++++++++++++
> =A02 files changed, 583 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/include/asm/edid.h
> =A0create mode 100644 drivers/video/edid.c
>
> diff --git a/arch/arm/include/asm/edid.h b/arch/arm/include/asm/edid.=
h
> new file mode 100644
> index 0000000..843346a
> --- /dev/null
> +++ b/arch/arm/include/asm/edid.h
> @@ -0,0 +1,243 @@
> +/*
> + * edid.h
> + *
> + * Copyright (C) 2011 Texas Instruments
> + * Author: Mythri P K <mythripk@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> + * History:
> + */
> +
> +#ifndef _EDID_H_
> +#define _EDID_H_
> +
> +/* HDMI EDID Length */
> +#define HDMI_EDID_MAX_LENGTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 512
> +
> +/* HDMI EDID Extension Data Block Tags =A0*/
> +#define HDMI_EDID_EX_DATABLOCK_TAG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00xE0
> +#define HDMI_EDID_EX_DATABLOCK_LEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x1F
> +
> +#define EDID_TIMING_DESCRIPTOR_SIZE =A0 =A0 =A0 =A0 =A0 =A00x12
> +#define EDID_DESCRIPTOR_BLOCK0_ADDRESS =A0 =A0 =A0 =A0 0x36
> +#define EDID_DESCRIPTOR_BLOCK1_ADDRESS =A0 =A0 =A0 =A0 0x80
> +#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR =A0 =A0 4
> +#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR =A0 =A0 4
> +
> +/* EDID Detailed Timing =A0 =A0 =A0 =A0Info 0 begin offset */
> +#define HDMI_EDID_DETAILED_TIMING_OFFSET =A0 =A0 =A0 0x36
> +
> +#define HDMI_EDID_PIX_CLK_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define HDMI_EDID_H_ACTIVE_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A02
> +#define HDMI_EDID_H_BLANKING_OFFSET =A0 =A0 =A0 =A0 =A0 =A03
> +#define HDMI_EDID_V_ACTIVE_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A05
> +#define HDMI_EDID_V_BLANKING_OFFSET =A0 =A0 =A0 =A0 =A0 =A06
> +#define HDMI_EDID_H_SYNC_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A08
> +#define HDMI_EDID_H_SYNC_PW_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 9
> +#define HDMI_EDID_V_SYNC_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A010
> +#define HDMI_EDID_V_SYNC_PW_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 11
> +#define HDMI_EDID_H_IMAGE_SIZE_OFFSET =A0 =A0 =A0 =A0 =A012
> +#define HDMI_EDID_V_IMAGE_SIZE_OFFSET =A0 =A0 =A0 =A0 =A013
> +#define HDMI_EDID_H_BORDER_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A015
> +#define HDMI_EDID_V_BORDER_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A016
> +#define HDMI_EDID_FLAGS_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 17
> +
> +/* HDMI EDID DTDs */
> +#define HDMI_EDID_MAX_DTDS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4
> +
> +/* HDMI EDID DTD Tags */
> +#define HDMI_EDID_DTD_TAG_MONITOR_NAME =A0 =A0 =A0 =A0 0xFC
> +#define HDMI_EDID_DTD_TAG_MONITOR_SERIALNUM =A0 =A00xFF
> +#define HDMI_EDID_DTD_TAG_MONITOR_LIMITS =A0 =A0 =A0 0xFD
> +#define HDMI_EDID_DTD_TAG_STANDARD_TIMING_DATA 0xFA
> +#define HDMI_EDID_DTD_TAG_COLOR_POINT_DATA =A0 =A0 0xFB
> +#define HDMI_EDID_DTD_TAG_ASCII_STRING =A0 =A0 =A0 =A0 0xFE
> +
> +#define HDMI_IMG_FORMAT_MAX_LENGTH =A0 =A0 =A0 =A0 =A0 =A0 20
> +#define HDMI_AUDIO_FORMAT_MAX_LENGTH =A0 =A0 =A0 =A0 =A0 10
> +
> +/* HDMI EDID Extenion Data Block Values: Video */
> +#define HDMI_EDID_EX_VIDEO_NATIVE =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
> +#define HDMI_EDID_EX_VIDEO_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x7F
> +#define HDMI_EDID_EX_VIDEO_MAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 35
> +
> +#define STANDARD_HDMI_TIMINGS_NB =A0 =A0 =A0 =A0 =A0 =A0 =A0 34
> +#define STANDARD_HDMI_TIMINGS_VESA_START =A0 =A0 =A0 15
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +enum extension_edid_db {
> + =A0 =A0 =A0 DATABLOCK_AUDIO =3D 1,
> + =A0 =A0 =A0 DATABLOCK_VIDEO =3D 2,
> + =A0 =A0 =A0 DATABLOCK_VENDOR =3D 3,
> + =A0 =A0 =A0 DATABLOCK_SPEAKERS =3D 4,
> +};
> +
> +struct img_edid {
> + =A0 =A0 =A0 bool pref;
> + =A0 =A0 =A0 int code;
> +};
> +
> +struct image_format {
> + =A0 =A0 =A0 int length;
> + =A0 =A0 =A0 struct img_edid fmt[HDMI_IMG_FORMAT_MAX_LENGTH];
> +};
> +
> +struct audio_edid {
> + =A0 =A0 =A0 int num_of_ch;
> + =A0 =A0 =A0 int format;
> +};
> +
> +struct audio_format {
> + =A0 =A0 =A0 int length;
> + =A0 =A0 =A0 struct audio_edid fmt[HDMI_AUDIO_FORMAT_MAX_LENGTH];
> +};
> +
> +struct latency {
> + =A0 =A0 =A0 /* vid: if indicated, value=3D1+ms/2 with a max of 251 =
meaning 500ms */
> + =A0 =A0 =A0 int vid_latency;
> + =A0 =A0 =A0 int aud_latency;
> + =A0 =A0 =A0 int int_vid_latency;
> + =A0 =A0 =A0 int int_aud_latency;
> +};
> +
> +struct deep_color {
> + =A0 =A0 =A0 bool bit_30;
> + =A0 =A0 =A0 bool bit_36;
> + =A0 =A0 =A0 int max_tmds_freq;
> +};
> +
> +/* =A0Video Descriptor Block =A0*/
> +struct HDMI_EDID_DTD_VIDEO {
> + =A0 =A0 =A0 u16 =A0 =A0 pixel_clock; =A0 =A0 =A0 =A0 =A0 =A0/* 54-5=
5 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_active; =A0 =A0 =A0 =A0 =A0 /* 56 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_blanking; =A0 =A0 =A0 =A0 /* 57 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_high; =A0 =A0 =A0 =A0 =A0 =A0 /* 58=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0vert_active; =A0 =A0 =A0 =A0 =A0 =A0/* 59=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0vert_blanking; =A0 =A0 =A0 =A0 =A0/* 60 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0vert_high; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
61 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_sync_offset; =A0 =A0 =A0/* 62 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_sync_pulse; =A0 =A0 =A0 /* 63 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0vert_sync_pulse; =A0 =A0 =A0 =A0/* 64 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0sync_pulse_high; =A0 =A0 =A0 =A0/* 65 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_image_size; =A0 =A0 =A0 /* 66 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0vert_image_size; =A0 =A0 =A0 =A0/* 67 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0image_size_high; =A0 =A0 =A0 =A0/* 68 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0horiz_border; =A0 =A0 =A0 =A0 =A0 /* 69 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0vert_border; =A0 =A0 =A0 =A0 =A0 =A0/* 70=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0misc_settings; =A0 =A0 =A0 =A0 =A0/* 71 *=
/
> +};
> +
> +/* =A0 =A0 Monitor Limits Descriptor Block */
> +struct HDMI_EDID_DTD_MONITOR {
> + =A0 =A0 =A0 u16 =A0 =A0 pixel_clock; =A0 =A0 =A0 =A0 =A0 =A0/* 54-5=
5*/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0_reserved1; =A0 =A0 =A0 =A0 =A0 =A0 /* 56=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0block_type; =A0 =A0 =A0 =A0 =A0 =A0 /* 57=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0_reserved2; =A0 =A0 =A0 =A0 =A0 =A0 /* 58=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0min_vert_freq; =A0 =A0 =A0 =A0 =A0/* 59 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0max_vert_freq; =A0 =A0 =A0 =A0 =A0/* 60 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0min_horiz_freq; =A0 =A0 =A0 =A0 /* 61 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0max_horiz_freq; =A0 =A0 =A0 =A0 /* 62 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0pixel_clock_mhz; =A0 =A0 =A0 =A0/* 63 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0GTF[2]; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /=
* 64 -65 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0start_horiz_freq; =A0 =A0 =A0 /* 66 =A0 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0C; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* 67 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0M[2]; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* 68-69 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0K; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* 70 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0J; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* 71 */
> +
> +} __packed;
> +
> +/* Text Descriptor Block */
> +struct HDMI_EDID_DTD_TEXT {
> + =A0 =A0 =A0 u16 =A0 =A0 pixel_clock; =A0 =A0 =A0 =A0 =A0 =A0/* 54-5=
5 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0_reserved1; =A0 =A0 =A0 =A0 =A0 =A0 /* 56=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0block_type; =A0 =A0 =A0 =A0 =A0 =A0 /* 57=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0_reserved2; =A0 =A0 =A0 =A0 =A0 =A0 /* 58=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0text[13]; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
59-71 */
> +} __packed;
> +
> +/* DTD Union */
> +union HDMI_EDID_DTD {
> + =A0 =A0 =A0 struct HDMI_EDID_DTD_VIDEO =A0 =A0 =A0video;
> + =A0 =A0 =A0 struct HDMI_EDID_DTD_TEXT =A0 =A0 =A0 monitor_name;
> + =A0 =A0 =A0 struct HDMI_EDID_DTD_TEXT =A0 =A0 =A0 monitor_serial_nu=
mber;
> + =A0 =A0 =A0 struct HDMI_EDID_DTD_TEXT =A0 =A0 =A0 ascii;
> + =A0 =A0 =A0 struct HDMI_EDID_DTD_MONITOR =A0 =A0monitor_limits;
> +} __packed;
> +
> +/* =A0 =A0 EDID struct =A0 =A0 */
> +struct HDMI_EDID {
> + =A0 =A0 =A0 u8 =A0 =A0 =A0header[8]; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
00-07 */
> + =A0 =A0 =A0 u16 =A0 =A0 manufacturerID; =A0 =A0 =A0 =A0 /* 08-09 */
> + =A0 =A0 =A0 u16 =A0 =A0 product_id; =A0 =A0 =A0 =A0 =A0 =A0 /* 10-1=
1 */
> + =A0 =A0 =A0 u32 =A0 =A0 serial_number; =A0 =A0 =A0 =A0 =A0/* 12-15 =
*/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0week_manufactured; =A0 =A0 =A0/* 16 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0year_manufactured; =A0 =A0 =A0/* 17 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0edid_version; =A0 =A0 =A0 =A0 =A0 /* 18 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0edid_revision; =A0 =A0 =A0 =A0 =A0/* 19 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0video_in_definition; =A0 =A0/* 20 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0max_horiz_image_size; =A0 /* 21 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0max_vert_image_size; =A0 =A0/* 22 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0display_gamma; =A0 =A0 =A0 =A0 =A0/* 23 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0power_features; =A0 =A0 =A0 =A0 /* 24 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0chroma_info[10]; =A0 =A0 =A0 =A0/* 25-34 =
*/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0timing_1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
35 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0timing_2; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
36 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0timing_3; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
37 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0std_timings[16]; =A0 =A0 =A0 =A0/* 38-53 =
*/
> + =A0 =A0 =A0 union =A0 HDMI_EDID_DTD DTD[4]; =A0 /* 54-125 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0extension_edid; =A0 =A0 =A0 =A0 /* 126 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0checksum; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
127 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0extension_tag; =A0 =A0 =A0 =A0 =A0/* 00 (=
extensions follow EDID) */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0extention_rev; =A0 =A0 =A0 =A0 =A0/* 01 *=
/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0offset_dtd; =A0 =A0 =A0 =A0 =A0 =A0 /* 02=
 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0num_dtd; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* 03 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0data_block[123]; =A0 =A0 =A0 =A0/* 04 - 1=
26 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0extension_checksum; =A0 =A0 /* 127 */
> +
> + =A0 =A0 =A0 u8 =A0 =A0 =A0ext_datablock[256];
> +} __packed;
> +
> +struct hdmi_timings {
> +
> + =A0 =A0 =A0 u16 x_res;
> + =A0 =A0 =A0 u16 y_res;
> + =A0 =A0 =A0 u32 pixel_clock; =A0 =A0 =A0 =A0/* pixel clock in KHz *=
/
> + =A0 =A0 =A0 u16 hsw; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Horizontal s=
ynchronization pulse width */
> + =A0 =A0 =A0 u16 hfp; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Horizontal f=
ront porch */
> + =A0 =A0 =A0 u16 hbp; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Horizontal b=
ack porch */
> + =A0 =A0 =A0 u16 vsw; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Vertical syn=
chronization pulse width */
> + =A0 =A0 =A0 u16 vfp; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Vertical fro=
nt porch */
> + =A0 =A0 =A0 u16 vbp; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Vertical bac=
k porch */
> +};
> +
> +int get_edid_timing_info(union HDMI_EDID_DTD *edid_dtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
hdmi_timings *timings);
> +void get_eedid_timing_info(int current_descriptor_addrs, u8 *edid ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
hdmi_timings *timings);
> +int hdmi_get_datablock_offset(u8 *edid, enum extension_edid_db datab=
lock,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *of=
fset);
> +int hdmi_get_image_format(u8 *edid, struct image_format *format);
> +int hdmi_get_audio_format(u8 *edid, struct audio_format *format);
> +void hdmi_get_av_delay(u8 *edid, struct latency *lat);
> +void hdmi_deep_color_support_info(u8 *edid, struct deep_color *forma=
t);
> +bool hdmi_tv_yuv_supported(u8 *edid);
> +
> +#ifdef __cplusplus
> +};
> +#endif
> +
> +#endif
> diff --git a/drivers/video/edid.c b/drivers/video/edid.c
> new file mode 100644
> index 0000000..4eb2074
> --- /dev/null
> +++ b/drivers/video/edid.c
> @@ -0,0 +1,340 @@
> +/*
> + * edid.c
> + *
> + * Copyright (C) 2011 Texas Instruments
> + * Author: Mythri P K <mythripk@ti.com>
> + * =A0 =A0 =A0 =A0 With EDID parsing for DVI Monitor from Rob Clark =
<rob@ti.com>
> + *
> + * EDID.c to parse the EDID content.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
> + * History:
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <asm/edid.h>
> +
> +/* Standard HDMI/VESA timings */
> +const struct hdmi_timings standard_hdmi_timings[STANDARD_HDMI_TIMING=
S_NB] =3D {
> + =A0 =A0 =A0 {640, 480, 25200, 96, 16, 48, 2, 10, 33},
> + =A0 =A0 =A0 {1280, 720, 74250, 40, 440, 220, 5, 5, 20},
> + =A0 =A0 =A0 {1280, 720, 74250, 40, 110, 220, 5, 5, 20},
> + =A0 =A0 =A0 {720, 480, 27027, 62, 16, 60, 6, 9, 30},
> + =A0 =A0 =A0 {2880, 576, 108000, 256, 48, 272, 5, 5, 39},
> + =A0 =A0 =A0 {1440, 240, 27027, 124, 38, 114, 3, 4, 15},
> + =A0 =A0 =A0 {1440, 288, 27000, 126, 24, 138, 3, 2, 19},
> + =A0 =A0 =A0 {1920, 540, 74250, 44, 528, 148, 5, 2, 15},
> + =A0 =A0 =A0 {1920, 540, 74250, 44, 88, 148, 5, 2, 15},
> + =A0 =A0 =A0 {1920, 1080, 148500, 44, 88, 148, 5, 4, 36},
> + =A0 =A0 =A0 {720, 576, 27000, 64, 12, 68, 5, 5, 39},
> + =A0 =A0 =A0 {1440, 576, 54000, 128, 24, 136, 5, 5, 39},
> + =A0 =A0 =A0 {1920, 1080, 148500, 44, 528, 148, 5, 4, 36},
> + =A0 =A0 =A0 {2880, 480, 108108, 248, 64, 240, 6, 9, 30},
> + =A0 =A0 =A0 {1920, 1080, 74250, 44, 638, 148, 5, 4, 36},
> + =A0 =A0 =A0 /* Vesa frome here */
> + =A0 =A0 =A0 {640, 480, 25175, 96, 16, 48, 2 , 11, 31},
> + =A0 =A0 =A0 {800, 600, 40000, 128, 40, 88, 4 , 1, 23},
> + =A0 =A0 =A0 {848, 480, 33750, 112, 16, 112, 8 , 6, 23},
> + =A0 =A0 =A0 {1280, 768, 79500, 128, 64, 192, 7 , 3, 20},
> + =A0 =A0 =A0 {1280, 800, 83500, 128, 72, 200, 6 , 3, 22},
> + =A0 =A0 =A0 {1360, 768, 85500, 112, 64, 256, 6 , 3, 18},
> + =A0 =A0 =A0 {1280, 960, 108000, 112, 96, 312, 3 , 1, 36},
> + =A0 =A0 =A0 {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38},
> + =A0 =A0 =A0 {1024, 768, 65000, 136, 24, 160, 6, 3, 29},
> + =A0 =A0 =A0 {1400, 1050, 121750, 144, 88, 232, 4, 3, 32},
> + =A0 =A0 =A0 {1440, 900, 106500, 152, 80, 232, 6, 3, 25},
> + =A0 =A0 =A0 {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30},
> + =A0 =A0 =A0 {1366, 768, 85500, 143, 70, 213, 3, 3, 24},
> + =A0 =A0 =A0 {1920, 1080, 148500, 44, 88, 80, 5, 4, 36},
> + =A0 =A0 =A0 {1280, 768, 68250, 32, 48, 80, 7, 3, 12},
> + =A0 =A0 =A0 {1400, 1050, 101000, 32, 48, 80, 4, 3, 23},
> + =A0 =A0 =A0 {1680, 1050, 119000, 32, 48, 80, 6, 3, 21},
> + =A0 =A0 =A0 {1280, 800, 79500, 32, 48, 80, 6, 3, 14},
> + =A0 =A0 =A0 {1280, 720, 74250, 40, 110, 220, 5, 5, 20}
> +};
> +
> +int get_edid_timing_info(union HDMI_EDID_DTD *edid_dtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct hdmi_timings *timings)
> +{
> + =A0 =A0 =A0 if (edid_dtd->video.pixel_clock) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct HDMI_EDID_DTD_VIDEO *vid =3D &ed=
id_dtd->video;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->pixel_clock =3D 10 * vid->pixe=
l_clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->x_res =3D vid->horiz_active |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((u16)=
vid->horiz_high & 0xf0) << 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->y_res =3D vid->vert_active |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((u16)=
vid->vert_high & 0xf0) << 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->hfp =3D vid->horiz_sync_offset=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((u16)=
vid->sync_pulse_high & 0xc0) << 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->hsw =3D vid->horiz_sync_pulse =
|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((u16)=
vid->sync_pulse_high & 0x30) << 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->hbp =3D (vid->horiz_blanking |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((u16)=
vid->horiz_high & 0x0f) << 8)) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing=
s->hfp + timings->hsw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->vfp =3D ((vid->vert_sync_pulse=
 & 0xf0) >> 4) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((vid->=
sync_pulse_high & 0x0f) << 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->vsw =3D (vid->vert_sync_pulse =
& 0x0f) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((vid->=
sync_pulse_high & 0x03) << 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->vbp =3D (vid->vert_blanking |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((u16)=
vid->vert_high & 0x0f) << 8)) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing=
s->vfp + timings->vsw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (edid_dtd->monitor_name.block_type) {
> + =A0 =A0 =A0 case HDMI_EDID_DTD_TAG_STANDARD_TIMING_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "standard timing data\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 case HDMI_EDID_DTD_TAG_COLOR_POINT_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "color point data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 case HDMI_EDID_DTD_TAG_MONITOR_NAME:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "monitor name: %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 edid_dtd->monitor_name.text);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 case HDMI_EDID_DTD_TAG_MONITOR_LIMITS:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i, max_area =3D 0, best_idx =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct HDMI_EDID_DTD_MONITOR *limits =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &edid_dtd->monitor_limits;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG " =A0monitor limits\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG " =A0min_vert_freq=3D=
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 limits->min_vert_freq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG " =A0max_vert_freq=3D=
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 limits->max_vert_freq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG " =A0min_horiz_freq=3D=
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 limits->min_horiz_freq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG " =A0max_horiz_freq=3D=
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 limits->max_horiz_freq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG " =A0pixel_clock_mhz=3D=
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 limits->pixel_clock_mhz * 10);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* find the highest matching resolution=
 (w*h) */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* XXX since this is mainly for DVI m=
onitors, should we only
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* support VESA timings? =A0My monito=
r at home would pick
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1920x1080 otherwise, but that seem=
s to not work well (monitor
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* blanks out and comes back, and pic=
ture doesn't fill full
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* screen, but leaves a black bar on =
left (native res is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 2048x1152). However if I only cons=
ider VESA timings, it picks
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1680x1050 and the picture is stabl=
e and fills whole screen
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D STANDARD_HDMI_TIMINGS_VESA_S=
TART;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 i < STANDARD_HDMI_TIMINGS_NB; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct hdmi_timin=
gs *timings =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0&standard_hdmi_timings[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int hz, hscan, pixclock=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int vtotal, htotal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 htotal =3D timings->hbp=
 + timings->hfp +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 timings->hsw + timings->x_res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vtotal =3D timings->vbp=
 + timings->vfp +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 timings->vsw + timings->y_res;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTE: We don't suppo=
rt interlaced mode for VESA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixclock =3D timings->p=
ixel_clock * 1000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hscan =3D (pixclock + h=
total / 2) / htotal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hscan =3D (hscan + 500)=
 / 1000 * 1000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hz =3D (hscan + vtotal =
/ 2) / vtotal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hscan /=3D 1000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixclock /=3D 1000000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pixclock < (limits=
->pixel_clock_mhz * 10)) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (limits=
->min_horiz_freq <=3D hscan) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hscan =
<=3D limits->max_horiz_freq) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (limits=
->min_vert_freq <=3D hz) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hz <=3D=
 limits->max_vert_freq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int are=
a =3D timings->x_res * timings->y_res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_INFO " -> %d: %dx%d\n", i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 timings->x_res, timings->y_res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (are=
a > max_area) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 max_area =3D area;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 best_idx =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (best_idx > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *timings =3D standard_h=
dmi_timings[best_idx];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "foun=
d best resolution: %dx%d (%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings=
->x_res, timings->y_res, best_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case HDMI_EDID_DTD_TAG_ASCII_STRING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "ascii string: %s\n", =
edid_dtd->ascii.text);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 case HDMI_EDID_DTD_TAG_MONITOR_SERIALNUM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "monitor serialnum: %s=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edid_dtd->monitor_seria=
l_number.text);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "unsupported EDID desc=
riptor block format\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +}
> +
> +void get_eedid_timing_info(int current_descriptor_addrs, u8 *edid ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hdmi_timings *ti=
mings)
> +{
> + =A0 =A0 =A0 timings->x_res =3D (((edid[current_descriptor_addrs + 4=
] & 0xF0) << 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | edid[=
current_descriptor_addrs + 2]);
> + =A0 =A0 =A0 timings->y_res =3D (((edid[current_descriptor_addrs + 7=
] & 0xF0) << 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | edid[=
current_descriptor_addrs + 5]);
> + =A0 =A0 =A0 timings->pixel_clock =3D ((edid[current_descriptor_addr=
s + 1] << 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | edid[=
current_descriptor_addrs]);
> + =A0 =A0 =A0 timings->pixel_clock =3D 10 * timings->pixel_clock;
> + =A0 =A0 =A0 timings->hfp =3D edid[current_descriptor_addrs + 8];
> + =A0 =A0 =A0 timings->hsw =3D edid[current_descriptor_addrs + 9];
> + =A0 =A0 =A0 timings->hbp =3D (((edid[current_descriptor_addrs + 4] =
& 0x0F) << 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | edid[=
current_descriptor_addrs + 3]) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing=
s->hfp + timings->hsw);
> + =A0 =A0 =A0 timings->vfp =3D ((edid[current_descriptor_addrs + 10] =
& 0xF0) >> 4);
> + =A0 =A0 =A0 timings->vsw =3D (edid[current_descriptor_addrs + 10] &=
 0x0F);
> + =A0 =A0 =A0 timings->vbp =3D (((edid[current_descriptor_addrs + 7] =
& 0x0F) << 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | edid[=
current_descriptor_addrs + 6]) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timing=
s->vfp + timings->vsw);
> +}
> +
> +int hdmi_get_datablock_offset(u8 *edid, enum extension_edid_db datab=
lock,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *offset)
> +{
> + =A0 =A0 =A0 int current_byte, disp, i =3D 0, length =3D 0;
> +
> + =A0 =A0 =A0 if (edid[0x7e] =3D=3D 0x00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 disp =3D edid[(0x80) + 2];
> + =A0 =A0 =A0 if (disp =3D=3D 0x4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 i =3D 0x80 + 0x4;
> + =A0 =A0 =A0 printk(KERN_INFO "%x\n", i);
> + =A0 =A0 =A0 while (i < (0x80 + disp)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_byte =3D edid[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((current_byte >> 5) =3D=3D databloc=
k) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *offset =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "datab=
lock %d %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 datablock, *offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D (current_byt=
e &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 HDMI_EDID_EX_DATABLOCK_LEN_MASK) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i +=3D length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +int hdmi_get_image_format(u8 *edid, struct image_format *format)
> +{
> + =A0 =A0 =A0 int offset, current_byte, j =3D 0, length =3D 0;
> + =A0 =A0 =A0 enum extension_edid_db vsdb =3D =A0DATABLOCK_VIDEO;
> + =A0 =A0 =A0 format->length =3D 0;
> +
> + =A0 =A0 =A0 memset(format->fmt, 0, sizeof(format->fmt));
> + =A0 =A0 =A0 if (!hdmi_get_datablock_offset(edid, vsdb, &offset)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_byte =3D edid[offset];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D current_byte & HDMI_EDID_EX_=
DATABLOCK_LEN_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length >=3D HDMI_IMG_FORMAT_MAX_LEN=
GTH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->length =3D HDMI=
_IMG_FORMAT_MAX_LENGTH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->length =3D leng=
th;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 1 ; j < length ; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_byte =3D edid[o=
ffset+j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->fmt[j-1].code =3D=
 current_byte & 0x7F;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->fmt[j-1].pref =3D=
 current_byte & 0x80;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int hdmi_get_audio_format(u8 *edid, struct audio_format *format)
> +{
> + =A0 =A0 =A0 int offset, current_byte, j =3D 0, length =3D 0;
> + =A0 =A0 =A0 enum extension_edid_db vsdb =3D =A0DATABLOCK_AUDIO;
> +
> + =A0 =A0 =A0 format->length =3D 0;
> + =A0 =A0 =A0 memset(format->fmt, 0, sizeof(format->fmt));
> +
> + =A0 =A0 =A0 if (!hdmi_get_datablock_offset(edid, vsdb, &offset)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_byte =3D edid[offset];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D current_byte & HDMI_EDID_EX_=
DATABLOCK_LEN_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length >=3D HDMI_AUDIO_FORMAT_MAX_L=
ENGTH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->length =3D HDMI=
_AUDIO_FORMAT_MAX_LENGTH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->length =3D leng=
th;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 1 ; j < length ; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (j%3 =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
_byte =3D edid[offset + j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format-=
>fmt[j-1].format =3D current_byte & 0x78;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format-=
>fmt[j-1].num_of_ch =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (current_byte & 0x07) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +void hdmi_get_av_delay(u8 *edid, struct latency *lat)
> +{
> + =A0 =A0 =A0 int offset, current_byte, length =3D 0;
> + =A0 =A0 =A0 enum extension_edid_db vsdb =3D =A0DATABLOCK_VENDOR;
> +
> + =A0 =A0 =A0 if (!hdmi_get_datablock_offset(edid, vsdb, &offset)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_byte =3D edid[offset];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D current_byte & HDMI_EDID_EX_=
DATABLOCK_LEN_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length >=3D 8 && ((current_byte + 8=
) & 0x80)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lat->vid_latency =3D (e=
did[offset + 8] - 1) * 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lat->aud_latency =3D (e=
did[offset + 9] - 1) * 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length >=3D 8 && ((current_byte + 8=
) & 0xC0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lat->int_vid_latency =3D=
 (edid[offset + 10] - 1) * 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lat->int_aud_latency =3D=
 (edid[offset + 11] - 1) * 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +void hdmi_deep_color_support_info(u8 *edid, struct deep_color *forma=
t)
> +{
> + =A0 =A0 =A0 int offset, current_byte, length =3D 0;
> + =A0 =A0 =A0 enum extension_edid_db vsdb =3D DATABLOCK_VENDOR;
> + =A0 =A0 =A0 memset(format, 0, sizeof(*format));
> +
> + =A0 =A0 =A0 if (!hdmi_get_datablock_offset(edid, vsdb, &offset)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_byte =3D edid[offset];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D current_byte & HDMI_EDID_EX_=
DATABLOCK_LEN_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length >=3D 6) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->bit_30 =3D (edi=
d[offset + 6] & 0x10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->bit_36 =3D (edi=
d[offset + 6] & 0x20);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (length >=3D 7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format->max_tmds_freq =3D=
 (edid[offset + 7]) * 5;
> + =A0 =A0 =A0 }
> +}
> +
> +bool hdmi_tv_yuv_supported(u8 *edid)
> +{
> + =A0 =A0 =A0 if (edid[0x7e] !=3D 0x00 && edid[0x83] & 0x30) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "YUV supported");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return false;
> +}
> --
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
