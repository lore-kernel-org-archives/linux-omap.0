From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Fri, 16 Mar 2012 12:23:31 +0200
Message-ID: <1331893411.1653.5.camel@lappy>
References: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
	 <20120315230446.GO17132@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:58509 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760906Ab2CPKXj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 06:23:39 -0400
Received: by lahc1 with SMTP id c1so3368800lah.26
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 03:23:36 -0700 (PDT)
In-Reply-To: <20120315230446.GO17132@sci.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, 2012-03-16 at 01:04 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Thu, Mar 15, 2012 at 05:18:52PM +0530, Chandrabhanu Mahapatra wrot=
e:
> > In OMAP3 DISPC video overlays suffer from some undocumented horizon=
tal position
> > and timing related limitations leading to SYNCLOST errors. Whenever=
 the image
> > window is moved towards the right of the screen SYNCLOST errors bec=
ome
> > frequent. Checks have been implemented to see that DISPC driver rej=
ects
> > configuration exceeding above limitations.
> >=20
> > This code was successfully tested on OMAP3. This code is written ba=
sed on code
> > written by Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> in Lin=
ux OMAP kernel. Ville
> > Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> had added checks for vi=
deo overlay horizontal
> > timing and DISPC horizontal blanking length limitations.
> >=20
> > Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> > ---
> >  drivers/video/omap2/dss/dispc.c |   67 +++++++++++++++++++++++++++=
++++++++++--
> >  1 files changed, 64 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/=
dss/dispc.c
> > index 5a1963e..ebfa613 100644
> > --- a/drivers/video/omap2/dss/dispc.c
> > +++ b/drivers/video/omap2/dss/dispc.c
> > @@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rota=
tion, bool mirror,
> >  	}
> >  }
> > =20
> > +static int check_horiz_timing(enum omap_channel channel, u16 pos_x=
,
> > +		u16 width, u16 height, u16 out_width, u16 out_height)
> > +{
> > +	int DS =3D DIV_ROUND_UP(height, out_height);
> > +	struct omap_dss_device *dssdev =3D dispc_mgr_get_device(channel);
> > +	struct omap_video_timings t =3D dssdev->panel.timings;
> > +	int pcd =3D REG_GET(DISPC_DIVISORo(channel), 7, 0);
>=20
> pcd doesn't exist for TV out, which is the reason why you see
> 'lclk/pclk' ratio used instead in the harmattan kernel.

I'm surprised you still remember these things =3D). And even more
surprised that you actually bothered to review it, thanks for that.

Chandrabhanu, do you have an omap3 board with composite/svideo tv-out?
It'd be good to test on that also, as, like Ville points out, the above
code can't work for tv-out. Hmm, then again, it shouldn't work for HDMI
on OMAP4 either. Did you test with HDMI?

Or is the above code called for TV-manager at all? If not, perhaps it
could be named *_lcd or something. Or perhaps have a BUG_ON(channel !=3D
lcd1 or lcd2);

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
