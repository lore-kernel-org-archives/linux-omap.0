From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/17] OMAPDSS: Add some new fields to omap_video_timings
Date: Wed, 27 Jun 2012 15:42:13 +0300
Message-ID: <1340800933.2649.72.camel@deskari>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
	  <1340703414-1915-7-git-send-email-archit@ti.com>
	 <1340797733.2649.48.camel@deskari> <4FEAFC02.2070006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BnORb4fqG+ZybuQVPOct"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:42746 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755803Ab2F0MmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 08:42:19 -0400
Received: by lbol5 with SMTP id l5so1723489lbo.34
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 05:42:16 -0700 (PDT)
In-Reply-To: <4FEAFC02.2070006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Archit Taneja <archit@ti.com>, rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-BnORb4fqG+ZybuQVPOct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 17:56 +0530, Archit Taneja wrote:
> On Wednesday 27 June 2012 05:18 PM, Tomi Valkeinen wrote:
> > On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
> >> Some panel timing related fields are contained in omap_panel_config in=
 the form
> >> of flags. The fields are:
> >>
> >> - Hsync logic level
> >> - Vsync logic level
> >> - Data driven on rising/falling edge of pixel clock
> >> - Output enable/Data enable logic level
> >> - HSYNC/VSYNC driven on rising/falling edge of pixel clock
> >>
> >> Out of these parameters, Hsync and Vsync logic levels are a part of th=
e timings
> >> in the Xorg modeline configuration. So it makes sense to move the to
> >> omap_video_timings. The rest aren't a part of modeline, but it still m=
akes
> >> sense to move these since they are related to panel timings.
> >>
> >> These fields stored in omap_panel_config in dssdev are configured for =
LCD
> >> panels, and the corresponding LCD managers in the DISPC_POL_FREQo regi=
sters.
> >>
> >> Add the above fields in omap_video_timings. Represent their state via =
new enums.
> >> The parameter pclk_edge is configured via omap_dss_signal_level, howev=
er it
> >> actually configures whether data is driven on the rising or falling ed=
ge. This
> >> is a bit unclean, but it prevents us from creating another enum.
> >
> > Hmm, why can't omap_dss_signal_edge be used for pclk_edge? I think it'd
> > fit fine, except OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES would be an illegal
> > value for it.
>=20
> I think my paragraph is a bit misleading. The issue is more about the=20
> default value. For hsync_vsync_edge(which programs ONOFF and RF), the=20
> default value is OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES, and is the case for=
=20
> most panels. But for pclk_edge, the value for most panels is=20
> OMAPDSS_DRIVE_SIG_ACTIVE_HIGH.
>=20
> So if I use the same enum for both, I'll need to populate either=20
> pclk_edge or hsync_vsync_edge for almost every panel. With my approach,=
=20
> I only need to populate these fields for panels having the non-default=
=20
> requirements. The negative thing is that it's a bit misleading to=20
> represent pclk_edge with the omap_dss_signal_level enum.

Ah, I see.

I really think using the ACTIVE_LOW/HIGH for pclk_edge is quite ugly =3D).

Well, one option is to add new entry for the enums, "UNDEFINED" or
perhaps "DEFAULT", which would have value 0. Then omapdss would know
that it should use the default value, whatever that is.

Another option is to have all panels define the pclk_edge, so that
there's no default value needed.

Also, related thing, I see you're writing enum values directly to the
registers. If you do that, it'd be good to explicitly set the number
value of the enums. Otherwise it's quite easy to add a new enum value
later between the old ones, breaking everything (perhaps not a problem
here, though).

 Tomi


--=-BnORb4fqG+ZybuQVPOct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6v+mAAoJEPo9qoy8lh71eTgQAKL1xqDmb89/GITIVtFvDVCv
cWy3pdjvcy8KaVmRo9FfXkYRS44hlJa1KMUdC3ruKHiTOY2sLkmw8kZLEVYfpAR2
PYEkBp2XeZv3nhjQ0e3Tccp/8t+96jBkaOCmWlIeXdPw2Lz5h6cjRScHX+pDELOv
1ElwN13RLsTHF0u0yEOgdS7M52eKBsGTUqkWEYJ830pKykV8LSNIvL2Od3jspmnO
kCEnDhX5UhDPLPa6fYbGA7+48gk5HBY/9/HoOGyUyYqymDfMvny5zEFufr5Ina1o
cZ9QVgnQSpkBVFw7hFcRMrC07su6dPeICEs/efQi+n+NKnGAls1ltrFDpunpHBHV
m8bLNmmMd8j3sa9N56axr+CpI/fZwo9WGnwWg5/pqJTprOuLI8CAENb0I8REYhgd
DK8F0mi9jKtyZBG0x0VFoyTjAAWoMrYYni46ig/eeEaPQ+b7GypbJypfzJs5Ha6/
sXZlkNTtsNRTx9iMtx8UXeS+iIqck3B0+YKdMtlmDUbDzwXAnyUKG5/qk4ltdQFT
YStymTlYJLdNHxsMN9okdtG/ONzkP/TAaggFZQiJ6CWYlQ63wuGP+RYzPpE3qXsy
0QiyIGtfAq42X/E5JgahtRLh+QXvIvRRdZZE2YBEjVgGwXQVyJruaSLqVigIrFZF
jrXDZDhkdmoFE6z0ahFp
=if8k
-----END PGP SIGNATURE-----

--=-BnORb4fqG+ZybuQVPOct--

