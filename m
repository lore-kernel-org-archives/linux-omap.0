From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Tue, 27 Mar 2012 14:17:39 +0300
Message-ID: <1332847059.1867.140.camel@deskari>
References: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
	 <1332845843.1867.126.camel@deskari>
	 <CAF0AtAtOSw73YuKyTxc6=RwN75oQaFxRCBW3_=PTmUoxgAFyew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-BEGGvpaJbisiPmqGLBvk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:48265 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753817Ab2C0LRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 07:17:43 -0400
Received: by mail-lb0-f180.google.com with SMTP id n10so4059718lbo.25
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 04:17:42 -0700 (PDT)
In-Reply-To: <CAF0AtAtOSw73YuKyTxc6=RwN75oQaFxRCBW3_=PTmUoxgAFyew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org


--=-BEGGvpaJbisiPmqGLBvk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-27 at 16:37 +0530, Mahapatra, Chandrabhanu wrote:
> On Tue, Mar 27, 2012 at 4:27 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
> >> In OMAP3 DISPC video overlays suffer from some undocumented horizontal=
 position
> >> and timing related limitations leading to SYNCLOST errors. Whenever th=
e image
> >> window is moved towards the right of the screen SYNCLOST errors become
> >> frequent. Checks have been implemented to see that DISPC driver reject=
s
> >> configuration exceeding above limitations.
> >>
> >> This code was successfully tested on OMAP3. This code is written based=
 on code
> >> written by Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> in Linux =
OMAP kernel. Ville
> >> Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> had added checks for video=
 overlay horizontal
> >> timing and DISPC horizontal blanking length limitations.
> >>
> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dispc.c |   97 +++++++++++++++++++++++++++++-=
---------
> >>  1 files changed, 72 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss=
/dispc.c
> >> index 5a1963e..d8a1672 100644
> >> --- a/drivers/video/omap2/dss/dispc.c
> >> +++ b/drivers/video/omap2/dss/dispc.c
> >> @@ -1622,6 +1622,57 @@ static void calc_dma_rotation_offset(u8 rotatio=
n, bool mirror,
> >>       }
> >>  }
> >>
> >> +static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
> >> +             u16 width, u16 height, u16 out_width, u16 out_height)
> >
> > I think the function could be named check_horiz_timing_omap3 or
> > something. It's kinda hard to realize that this is an omap3 work-around=
.
> > Perhaps a short comment above the function would be in order.
> >
>=20
> Yes, you are right! Do you mean to include some comments within the
> code definition itself? The patch description includes all that this
> function does.

I mean just a short comment above the function that mentions that this
function is used to avoid the synclosts on omap3, because yadda yadda,
so that the reader will immediately realize that this is doing some
special handling.=20

> > I don't the change to dispc_mgr_lclk_rate has anything to do with this
> > patch (fixing omap3 sync lost error). Shouldn't it be a separate fix?
> >
> >  Tomi
> >
> I am thinking to to move this fix to the third patch in the series
> "OMAPDSS: DISPC: Correct DISPC functional clock usage" and make it
> separate patch from the series and if possible move it ahead of the
> predecimation patch series. What do you say?

This patch is using dispc_mgr_lclk_rate. Does it depend on the change?
If so, it needs to be fixed before this patch. But yes, separating it
sounds fine.=20

 Tomi


--=-BEGGvpaJbisiPmqGLBvk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAABAgAGBQJPcaHTAAoJEPo9qoy8lh71X4AP+OzsW6OWVBkfA92evCKJWQc3
l8GUw1C+Zup7QZJ3B7VrtxfSpYgkZwTi3vavg70OpQGCjwC4mE7eFPROdPc/9sQG
2mnr7sfuFYpn+9vWjB25A+DVGXvqGYV7qYAnA7KIsQcJ5Ntf8fGOCMS1YnLKioYU
LFSv3/Sq8Qlkt+zlNBcmFNtC1/CUnp7lzogYYmcKolM02nudws8+ZUsqHTAw1XQG
77OLXL+Hja5noAP+7GomCcIEVb3FpJBVN/sElo1wg6oiJ7/0rsed2RJMqfn+yV6r
VHNWcDm7s8pL26GuZzz1n+R/0GVb+iqvutcBkaM/Hulub5qwQ8tgekW55b1XvhlU
Getn9bdAZ4YU+erU/fhkZbIjp11fg6o1VM2rnc5R7AGu4gdkAf9E9bqqJlXAR8Gm
DCP0f11mGqYfODGtSaJseIZE3ur2T5W7l5N8OP3WIaOCgCW/bHwZaaOAtBg6opuo
34+7uH8cEdRNxeaEJ379DxkbaGAbro2hLR6ufwdywlfTLHG97+vGDtXNsmeRVuGf
PUuT/yKpNV23eHdZw7XmzdoN90/LxgZcM6ulr/O2wRW2DBSEextoSMr2dbbVivDq
raQR5ue9QosDDswEPcwYJ+bnOYUGxT4MQY8eO5C/bu9m40jGKUXFyvwlLlwXLt9s
EGzvrSP1YTFNjPiTIJY=
=77tG
-----END PGP SIGNATURE-----

--=-BEGGvpaJbisiPmqGLBvk--

