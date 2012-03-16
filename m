From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Fri, 16 Mar 2012 19:45:41 +0530
Message-ID: <CAF0AtAv7+y_e8Z6hDQ5jMB=0axnQdNwWtyEaB=htPi-Tro+PFg@mail.gmail.com>
References: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
	<20120315230446.GO17132@sci.fi>
	<1331893411.1653.5.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36992 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753489Ab2CPOPm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 10:15:42 -0400
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so4279667laa.24
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 07:15:41 -0700 (PDT)
In-Reply-To: <1331893411.1653.5.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

2012/3/16 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On Fri, 2012-03-16 at 01:04 +0200, Ville Syrj=E4l=E4 wrote:
>> On Thu, Mar 15, 2012 at 05:18:52PM +0530, Chandrabhanu Mahapatra wro=
te:
>> > In OMAP3 DISPC video overlays suffer from some undocumented horizo=
ntal position
>> > and timing related limitations leading to SYNCLOST errors. Wheneve=
r the image
>> > window is moved towards the right of the screen SYNCLOST errors be=
come
>> > frequent. Checks have been implemented to see that DISPC driver re=
jects
>> > configuration exceeding above limitations.
>> >
>> > This code was successfully tested on OMAP3. This code is written b=
ased on code
>> > written by Ville Syrj=E4l=E4 <ville.syrjala@nokia.com> in Linux OM=
AP kernel. Ville
>> > Syrj=E4l=E4 <ville.syrjala@nokia.com> had added checks for video o=
verlay horizontal
>> > timing and DISPC horizontal blanking length limitations.
>> >
>> > Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> > ---
>> > =A0drivers/video/omap2/dss/dispc.c | =A0 67 ++++++++++++++++++++++=
+++++++++++++++--
>> > =A01 files changed, 64 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2=
/dss/dispc.c
>> > index 5a1963e..ebfa613 100644
>> > --- a/drivers/video/omap2/dss/dispc.c
>> > +++ b/drivers/video/omap2/dss/dispc.c
>> > @@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rot=
ation, bool mirror,
>> > =A0 =A0 }
>> > =A0}
>> >
>> > +static int check_horiz_timing(enum omap_channel channel, u16 pos_=
x,
>> > + =A0 =A0 =A0 =A0 =A0 u16 width, u16 height, u16 out_width, u16 ou=
t_height)
>> > +{
>> > + =A0 int DS =3D DIV_ROUND_UP(height, out_height);
>> > + =A0 struct omap_dss_device *dssdev =3D dispc_mgr_get_device(chan=
nel);
>> > + =A0 struct omap_video_timings t =3D dssdev->panel.timings;
>> > + =A0 int pcd =3D REG_GET(DISPC_DIVISORo(channel), 7, 0);
>>
>> pcd doesn't exist for TV out, which is the reason why you see
>> 'lclk/pclk' ratio used instead in the harmattan kernel.
>
> I'm surprised you still remember these things =3D). And even more
> surprised that you actually bothered to review it, thanks for that.
>
> Chandrabhanu, do you have an omap3 board with composite/svideo tv-out=
?
> It'd be good to test on that also, as, like Ville points out, the abo=
ve
> code can't work for tv-out. Hmm, then again, it shouldn't work for HD=
MI
> on OMAP4 either. Did you test with HDMI?
>
> Or is the above code called for TV-manager at all? If not, perhaps it
> could be named *_lcd or something. Or perhaps have a BUG_ON(channel !=
=3D
> lcd1 or lcd2);
>

Yes, I do have a Beagle board and I have tested on HDMI which works
without synclost errors upto 640 * 480 resolution.
The above errata exists only upto OMAP4430 ES1 which is currently not
supported. Please refer to errata 2.14 Downscaling Limitations in
errata sheet.
This patch is only for Omap3.

> =A0Tomi
>
>



--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
