From: InKi Dae <daeinki@gmail.com>
Subject: Re: [PATCH] enabled alpha blender for OMAP2/3 DSS2 driver.
Date: Sun, 26 Apr 2009 01:00:39 +0900
Message-ID: <90b950fc0904250900k1cd29363l282e0eb81bd9cee6@mail.gmail.com>
References: <90b950fc0904240213x70f66891j7dc587f09445e2f3@mail.gmail.com>
	 <87skjyxiyr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:17100 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZDYQGF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Apr 2009 12:06:05 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1358060qwd.37
        for <linux-omap@vger.kernel.org>; Sat, 25 Apr 2009 09:06:04 -0700 (PDT)
In-Reply-To: <87skjyxiyr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

To use WARN() instead of BUG() is more appropriate.
it's my mistake. those functions aren't critical as BUG() is used.

Thank you Kevin.

2009/4/24 Kevin Hilman <khilman@deeprootsystems.com>:
> InKi Dae <daeinki@gmail.com> writes:
>
>> - Added global alpha value for GFX and VIDEO2 layer.
>> - Modified dispc_alpha_blending_enabled function.
>> =A0 -> for OMAP_DSS_CHANNEL_DIGIT, it has to get DISPC_CONFIG[19], n=
ot 18.
>>
>> For alpha channel, dispc_enable_alpha_blending() is called by
>> omapfb_fb_init() in case of only XXX_ARGB16, RGBA32 or ARGB32
>>
>> Signed-off-by: InKi Dae <inki.dae@samsung.com>
>> --
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index 9bab6cf..c5335e5 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1846,8 +1846,10 @@ void dispc_enable_trans_key(enum omap_channel
>> ch, bool enable)
>> =A0 =A0 =A0 =A0 =A0 enable_clocks(1);
>> =A0 =A0 =A0 =A0 =A0 if (ch =3D=3D OMAP_DSS_CHANNEL_LCD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0REG_FLD_MOD(DISPC_CONFIG,=
 enable, 10, 10);
>> - =A0 =A0 =A0 =A0 =A0else /* OMAP_DSS_CHANNEL_DIGIT */
>> + =A0 =A0 =A0 =A0 else if (ch =3D=3D OMAP_DSS_CHANNEL_DIGIT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0REG_FLD_MOD(DISPC_CONFIG,=
 enable, 12, 12);
>> + =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>
> BUG() will halt the whole kernel. =A0I don't think you want to do tha=
t
> for this issue. =A0I think WARN() is more appropriate here and the ot=
her
> cases in this patch as well.
>
> Kevin
>
>> =A0 =A0 =A0 =A0 =A0 enable_clocks(0);
>> =A0}
>> =A0void dispc_enable_alpha_blending(enum omap_channel ch, bool enabl=
e)
>> @@ -1855,8 +1857,10 @@ void dispc_enable_alpha_blending(enum
>> omap_channel ch, bool enable)
>> =A0 =A0 =A0 =A0 =A0 enable_clocks(1);
>> =A0 =A0 =A0 =A0 =A0 if (ch =3D=3D OMAP_DSS_CHANNEL_LCD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0REG_FLD_MOD(DISPC_CONFIG,=
 enable, 18, 18);
>> - =A0 =A0 =A0 =A0 =A0else /* OMAP_DSS_CHANNEL_DIGIT */
>> + =A0 =A0 =A0 =A0 else if (ch =3D=3D OMAP_DSS_CHANNEL_DIGIT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0REG_FLD_MOD(DISPC_CONFIG,=
 enable, 19, 19);
>> + =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> =A0 =A0 =A0 =A0 =A0 enable_clocks(0);
>> =A0}
>> =A0bool dispc_alpha_blending_enabled(enum omap_channel ch)
>> @@ -1867,7 +1871,7 @@ bool dispc_alpha_blending_enabled(enum omap_ch=
annel ch)
>> =A0 =A0 =A0 =A0 =A0 if (ch =3D=3D OMAP_DSS_CHANNEL_LCD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enabled =3D REG_GET(DISPC=
_CONFIG, 18, 18);
>> =A0 =A0 =A0 =A0 =A0 else if (ch =3D=3D OMAP_DSS_CHANNEL_DIGIT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enabled =3D REG_GET(DISPC_C=
ONFIG, 18, 18);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enabled =3D REG_GET(DISPC_CONF=
IG, 19, 19);
>> =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG();
>> =A0 =A0 =A0 =A0 =A0 enable_clocks(0);
>> @@ -1876,6 +1880,18 @@ bool dispc_alpha_blending_enabled(enum omap_c=
hannel ch)
>>
>> =A0}
>>
>> +void dispc_set_global_alpha(int layer, int alpha)
>> +{
>> + =A0 =A0 =A0 =A0 enable_clocks(1);
>> + =A0 =A0 =A0 =A0 if (layer =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(DISPC_GLOBAL_ALPHA=
, alpha, 7, 0);
>> + =A0 =A0 =A0 =A0 else if (layer =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_FLD_MOD(DISPC_GLOBAL_ALPHA=
, alpha, 23, 16);
>> + =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> +
>> + =A0 =A0 =A0 =A0 enable_clocks(0);
>> +}
>>
>> =A0bool dispc_trans_key_enabled(enum omap_channel ch)
>> =A0{
>> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
>> b/drivers/video/omap2/omapfb/omapfb-main.c
>> index 76e7c6c..98cad35 100644
>> --- a/drivers/video/omap2/omapfb/omapfb-main.c
>> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
>> @@ -1583,6 +1583,17 @@ int omapfb_fb_init(struct omapfb2_device
>> *fbdev, struct fb_info *fbi)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 r =3D mode;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mod=
e =3D=3D OMAP_DSS_COLOR_ARGB16 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D=3D
>> OMAP_DSS_COLOR_RGBA32 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D=3D
>> OMAP_DSS_COLOR_ARGB32) {
>> +
>> +
>> dispc_enable_alpha_blending(OMAP_DSS_CHANNEL_LCD, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* Set global alpha value to
>> fully apaque */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 dispc_set_global_alpha(id, 255);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D=
 dss_mode_to_fb_mode(mode, var);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
r < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 goto err;
>> diff --git a/drivers/video/omap2/omapfb/omapfb.h
>> b/drivers/video/omap2/omapfb/omapfb.h
>> index 43f6922..56c303e 100644
>> --- a/drivers/video/omap2/omapfb/omapfb.h
>> +++ b/drivers/video/omap2/omapfb/omapfb.h
>> @@ -147,4 +147,8 @@ static inline int omapfb_overlay_enable(struct
>> omap_overlay *ovl,
>> =A0 =A0 =A0 =A0 =A0 return ovl->set_overlay_info(ovl, &info);
>> =A0}
>>
>> +extern void dispc_enable_alpha_blending(enum omap_channel ch,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int enable);
>> +extern void dispc_set_global_alpha(int layer, int alpha);
>> +
>> =A0#endif
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at =A0http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
