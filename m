From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 02/10] OMAPDSS: HDMI: OMAP4: Remove CEA-861 audio
 infoframe and IEC-60958 enums
Date: Mon, 23 Apr 2012 16:12:49 +0300
Message-ID: <1335186769.1535.30.camel@lappy>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-3-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-mPGTc8BlzoEy08Jj/M4e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55932 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635Ab2DWNM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 09:12:57 -0400
Received: by laap9 with SMTP id p9so10411907laa.24
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 06:12:54 -0700 (PDT)
In-Reply-To: <1332974305-4578-3-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org


--=-mPGTc8BlzoEy08Jj/M4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
> In order to avoid duplication of definitions. Use the definitions provide=
d
> by asoundef.h. Furthermore, as CEA-861 and IEC-60958 are used by both
> DisplayPort and HDMI, this helps to make the code more generic.

The first two sentences should probably be just one sentence.

> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   15 +++---
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   80 ++---------------------=
------
>  2 files changed, 12 insertions(+), 83 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index 4740e64..4ab3b19 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -29,7 +29,6 @@
>  #include <linux/string.h>
>  #include <linux/seq_file.h>
>  #include <linux/gpio.h>
> -

Unrelated change.

>  #include "ti_hdmi_4xxx_ip.h"
>  #include "dss.h"
> =20
> @@ -1156,7 +1155,7 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip=
_data,
>  }
> =20
>  void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
> -		struct hdmi_core_infoframe_audio *info_aud)
> +		struct snd_cea_861_aud_if *info_aud)
>  {
>  	u8 val;
>  	u8 sum =3D 0, checksum =3D 0;
> @@ -1172,22 +1171,24 @@ void hdmi_core_audio_infoframe_config(struct hdmi=
_ip_data *ip_data,
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AUDIO_LEN, 0x0a);
>  	sum +=3D 0x84 + 0x001 + 0x00a;
> =20
> -	val =3D (info_aud->db1_coding_type << 4)
> -			| (info_aud->db1_channel_count - 1);
> +	val =3D (info_aud->coding_type << CEA861_AUDIO_INFOFRAME_DB1CT_SHIFT)
> +			| (info_aud->channel_count - 1);
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(0), val);
>  	sum +=3D val;
> =20
> -	val =3D (info_aud->db2_sample_freq << 2) | info_aud->db2_sample_size;
> +	val =3D (info_aud->sample_freq << CEA861_AUDIO_INFOFRAME_DB2SF_SHIFT)
> +			| (info_aud->sample_size);
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(1), val);
>  	sum +=3D val;
> =20
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(2), 0x00);
> =20
> -	val =3D info_aud->db4_channel_alloc;
> +	val =3D info_aud->channel_alloc;
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(3), val);
>  	sum +=3D val;
> =20
> -	val =3D (info_aud->db5_downmix_inh << 7) | (info_aud->db5_lsv << 3);
> +	val =3D (info_aud->st_downmix << CEA861_AUDIO_INFOFRAME_DB5_DM_INH_SHIF=
T)
> +		| (info_aud->lsv << CEA861_AUDIO_INFOFRAME_DB5_LSV_SHIFT);
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_DBYTE(4), val);
>  	sum +=3D val;
> =20
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.h
> index a442998..d6b49b6 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> @@ -28,6 +28,8 @@
>  	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>  #include <sound/soc.h>
>  #include <sound/pcm_params.h>
> +#include <sound/asound.h>
> +#include <sound/asoundef.h>

You don't need to include these in the header file.

>  #endif
> =20
>  /* HDMI Wrapper */
> @@ -284,35 +286,6 @@ enum hdmi_core_infoframe {
>  	HDMI_INFOFRAME_AVI_DB5PR_8 =3D 7,
>  	HDMI_INFOFRAME_AVI_DB5PR_9 =3D 8,
>  	HDMI_INFOFRAME_AVI_DB5PR_10 =3D 9,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_FROM_STREAM =3D 0,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_IEC60958 =3D 1,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_AC3 =3D 2,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_MPEG1 =3D 3,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_MP3 =3D 4,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_MPEG2_MULTICH =3D 5,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_AAC =3D 6,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_DTS =3D 7,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_ATRAC =3D 8,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_ONEBIT =3D 9,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_DOLBY_DIGITAL_PLUS =3D 10,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_DTS_HD =3D 11,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_MAT =3D 12,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_DST =3D 13,
> -	HDMI_INFOFRAME_AUDIO_DB1CT_WMA_PRO =3D 14,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_FROM_STREAM =3D 0,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_32000 =3D 1,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_44100 =3D 2,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_48000 =3D 3,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_88200 =3D 4,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_96000 =3D 5,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_176400 =3D 6,
> -	HDMI_INFOFRAME_AUDIO_DB2SF_192000 =3D 7,
> -	HDMI_INFOFRAME_AUDIO_DB2SS_FROM_STREAM =3D 0,
> -	HDMI_INFOFRAME_AUDIO_DB2SS_16BIT =3D 1,
> -	HDMI_INFOFRAME_AUDIO_DB2SS_20BIT =3D 2,
> -	HDMI_INFOFRAME_AUDIO_DB2SS_24BIT =3D 3,
> -	HDMI_INFOFRAME_AUDIO_DB5_DM_INH_PERMITTED =3D 0,
> -	HDMI_INFOFRAME_AUDIO_DB5_DM_INH_PROHIBITED =3D 1
>  };
> =20
>  enum hdmi_packing_mode {
> @@ -322,17 +295,6 @@ enum hdmi_packing_mode {
>  	HDMI_PACK_ALREADYPACKED =3D 7
>  };
> =20
> -enum hdmi_core_audio_sample_freq {
> -	HDMI_AUDIO_FS_32000 =3D 0x3,
> -	HDMI_AUDIO_FS_44100 =3D 0x0,
> -	HDMI_AUDIO_FS_48000 =3D 0x2,
> -	HDMI_AUDIO_FS_88200 =3D 0x8,
> -	HDMI_AUDIO_FS_96000 =3D 0xA,
> -	HDMI_AUDIO_FS_176400 =3D 0xC,
> -	HDMI_AUDIO_FS_192000 =3D 0xE,
> -	HDMI_AUDIO_FS_NOT_INDICATED =3D 0x1
> -};
> -
>  enum hdmi_core_audio_layout {
>  	HDMI_AUDIO_LAYOUT_2CH =3D 0,
>  	HDMI_AUDIO_LAYOUT_8CH =3D 1
> @@ -393,31 +355,10 @@ enum hdmi_audio_i2s_config {

Are the defines left in the hdmi_audio_i2s_config something that are IP
specific? Are they even used? I'm just wondering why many of the defines
are in sound headers, but some are left here.

>  	HDMI_AUDIO_I2S_LSB_SHIFTED_FIRST =3D 1,
>  	HDMI_AUDIO_I2S_MAX_WORD_20BITS =3D 0,
>  	HDMI_AUDIO_I2S_MAX_WORD_24BITS =3D 1,
> -	HDMI_AUDIO_I2S_CHST_WORD_NOT_SPECIFIED =3D 0,
> -	HDMI_AUDIO_I2S_CHST_WORD_16_BITS =3D 1,
> -	HDMI_AUDIO_I2S_CHST_WORD_17_BITS =3D 6,
> -	HDMI_AUDIO_I2S_CHST_WORD_18_BITS =3D 2,
> -	HDMI_AUDIO_I2S_CHST_WORD_19_BITS =3D 4,
> -	HDMI_AUDIO_I2S_CHST_WORD_20_BITS_20MAX =3D 5,
> -	HDMI_AUDIO_I2S_CHST_WORD_20_BITS_24MAX =3D 1,
> -	HDMI_AUDIO_I2S_CHST_WORD_21_BITS =3D 6,
> -	HDMI_AUDIO_I2S_CHST_WORD_22_BITS =3D 2,
> -	HDMI_AUDIO_I2S_CHST_WORD_23_BITS =3D 4,
> -	HDMI_AUDIO_I2S_CHST_WORD_24_BITS =3D 5,
>  	HDMI_AUDIO_I2S_SCK_EDGE_FALLING =3D 0,
>  	HDMI_AUDIO_I2S_SCK_EDGE_RISING =3D 1,
>  	HDMI_AUDIO_I2S_VBIT_FOR_PCM =3D 0,
>  	HDMI_AUDIO_I2S_VBIT_FOR_COMPRESSED =3D 1,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_NA =3D 0,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_16 =3D 2,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_17 =3D 12,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_18 =3D 4,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_19 =3D 8,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_20 =3D 10,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_21 =3D 13,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_22 =3D 5,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_23 =3D 9,
> -	HDMI_AUDIO_I2S_INPUT_LENGTH_24 =3D 11,
>  	HDMI_AUDIO_I2S_FIRST_BIT_SHIFT =3D 0,
>  	HDMI_AUDIO_I2S_FIRST_BIT_NO_SHIFT =3D 1,
>  	HDMI_AUDIO_I2S_SD0_EN =3D 1,
> @@ -486,19 +427,6 @@ struct hdmi_core_infoframe_avi {
>  	/* Pixel number start of right bar */
>  	u16	db12_13_pixel_sofright;
>  };
> -/*
> - * Refer to section 8.2 in HDMI 1.3 specification for
> - * details about infoframe databytes
> - */
> -struct hdmi_core_infoframe_audio {
> -	u8 db1_coding_type;
> -	u8 db1_channel_count;
> -	u8 db2_sample_freq;
> -	u8 db2_sample_size;
> -	u8 db4_channel_alloc;
> -	bool db5_downmix_inh;
> -	u8 db5_lsv;	/* Level shift values for downmix */
> -};
> =20
>  struct hdmi_core_packet_enable_repeat {
>  	u32	audio_pkt;
> @@ -559,7 +487,7 @@ struct hdmi_core_audio_i2s_config {
> =20
>  struct hdmi_core_audio_config {
>  	struct hdmi_core_audio_i2s_config	i2s_cfg;
> -	enum hdmi_core_audio_sample_freq	freq_sample;
> +	u32 freq_sample;

Try to keep consistent code formatting. If the original code indents the
field names, indent your field name also.

 Tomi


--=-mPGTc8BlzoEy08Jj/M4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlVVRAAoJEPo9qoy8lh713asP/iqbAC9Gr7f/V4KtehGC45ak
2bdu87zsQl7ETWnYmOIWwPUkOpjc4kk/+5LbY7LqWfasEEy9n8Y/3bEVzL/r8CJp
+Np50Ip7ksAHNnfuiH2sDYp+QqTfde4ru0630eMCWMqnlp7JsPEQlrNNWRpOod1U
SdBJd/9hTagHoWaQIFVTT7QfrsSctqUNGzzPklnewJMuwGR+1FS5inhtvn5I1GWS
xYwYsbcfnJCysOG7j38K2OYrZqcra0/AwXlfOWdYZosUMC2dyVSHBrWFPzbK315b
Qk+i/qtXH1kYgzfchcOK/9wRERXWY6Yv8yvf/9Ar+XCBlD4JixcRsxKNsw1kokLF
K05wLKnzOgFW4j0z3E0a/g9G57sa+AYkSGlqJnHva1o6RFHJYu6F9RjQ4cJ1r4fP
vTGgZG6Y47Gex4/zT5IUi+xdhR9m8ak87Y8IPQd5N4jkYQwTcq/HuMQehnoCjATr
H79MzLTypXJ/QvW6NCgkLXHPXngnK99YgHFUkLgkrZzujEVlcMyMh3KpxFbB3qzZ
thMafbotdeKAJcNsNszJ0VVe8jsoNnW3Vvx9Ygie20EvddipyzVpvyHUTCcGz5K5
Gp9N2D5D30ySM1nBn1T1Myc5Wzl0PYOCY+17XsP876MJTjQ2tr9Gm0XUktnETepg
BjtUDEdGrk4BcwaROdjt
=/RIB
-----END PGP SIGNATURE-----

--=-mPGTc8BlzoEy08Jj/M4e--

