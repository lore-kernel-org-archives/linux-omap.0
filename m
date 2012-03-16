From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Fri, 16 Mar 2012 19:36:27 +0530
Message-ID: <CAF0AtAtYv_J0qBUeKQtb0zueJuLj7BCDMw0oiDVFC9MAtgq8CA@mail.gmail.com>
References: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
	<20120315230446.GO17132@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:40440 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1031972Ab2CPOGb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 10:06:31 -0400
Received: by mail-lb0-f170.google.com with SMTP id gg13so2216429lbb.29
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 07:06:27 -0700 (PDT)
In-Reply-To: <20120315230446.GO17132@sci.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 16, 2012 at 4:34 AM, Ville Syrj=E4l=E4 <syrjala@sci.fi> wro=
te:
> On Thu, Mar 15, 2012 at 05:18:52PM +0530, Chandrabhanu Mahapatra wrot=
e:
>> In OMAP3 DISPC video overlays suffer from some undocumented horizont=
al position
>> and timing related limitations leading to SYNCLOST errors. Whenever =
the image
>> window is moved towards the right of the screen SYNCLOST errors beco=
me
>> frequent. Checks have been implemented to see that DISPC driver reje=
cts
>> configuration exceeding above limitations.
>>
>> This code was successfully tested on OMAP3. This code is written bas=
ed on code
>> written by Ville Syrj=E4l=E4 <ville.syrjala@nokia.com> in Linux OMAP=
 kernel. Ville
>> Syrj=E4l=E4 <ville.syrjala@nokia.com> had added checks for video ove=
rlay horizontal
>> timing and DISPC horizontal blanking length limitations.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 67 ++++++++++++++++++++++++=
+++++++++++++--
>> =A01 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index 5a1963e..ebfa613 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rotat=
ion, bool mirror,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 width, u16 height, u16 out_width, u16 =
out_height)
>> +{
>> + =A0 =A0 int DS =3D DIV_ROUND_UP(height, out_height);
>> + =A0 =A0 struct omap_dss_device *dssdev =3D dispc_mgr_get_device(ch=
annel);
>> + =A0 =A0 struct omap_video_timings t =3D dssdev->panel.timings;
>> + =A0 =A0 int pcd =3D REG_GET(DISPC_DIVISORo(channel), 7, 0);
>
> pcd doesn't exist for TV out, which is the reason why you see
> 'lclk/pclk' ratio used instead in the harmattan kernel.
>
Yes, you are right. It's a very important point which I had missed.

> Another thing which still seems to be wrong in the upstream code is t=
he
> use of fclk in the scaling checks. It should be checking lclk instead=
=2E

Thanks for sighting this out. I will implement it in the future.

>> + =A0 =A0 unsigned long nonactive, val, blank;
>> + =A0 =A0 static const u8 limits[3] =3D { 8, 10, 20 };
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 nonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Atleast DS-2 lines must have already been fetched
>> + =A0 =A0 =A0* before the display active video period starts.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 val =3D (nonactive - pos_x) * pcd;
>> + =A0 =A0 DSSDBG("(nonactive - pos_x) * pcd =3D %lu,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 " max(0, DS - 2) * width =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 val, max(0, DS - 2) * width);
>> + =A0 =A0 if (val < max(0, DS - 2) * width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Only one line can be fetched during the overlay activ=
e
>> + =A0 =A0 =A0* period, the rest have to be fetched during the inacti=
ve
>> + =A0 =A0 =A0* period.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 val =3D nonactive * pcd;
>> + =A0 =A0 DSSDBG("nonactive * pcd =A0=3D %lu, max(0, DS - 1) * width=
 =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 val, max(0, DS - 1) * width);
>> + =A0 =A0 if (val < max(0, DS - 1) * width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Atleast Ceil(DS) lines should have been loaded during
>> + =A0 =A0 =A0* PPL (screen width) + blanking period.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 i =3D 0;
>> + =A0 =A0 if (out_height < height)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 if (out_width < width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 blank =3D (t.hbp + t.hsw + t.hfp) * pcd;
>> + =A0 =A0 DSSDBG("blanking period + ppl =3D %lu (limit =3D %u)\n", b=
lank, limits[i]);
>> + =A0 =A0 if (blank <=3D limits[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> The comment and code here are totally out of sync. IIRC the hblank
> length check came directly from the TRM. I have no idea if it's corre=
ct
> for more recent OMAPs, or if it was just copy pasted from the
> old TRM when the TRM got adjusted for more recent chips. That is why =
I
> stuck it into a separate function in harmattan.
>

This patch is only for OMAP3 and this errata is present upto OMAP4 ES1
which we are currently not supporting.

> --
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/



--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
