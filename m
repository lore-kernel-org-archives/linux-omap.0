From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 02/23] OMAPDSS: outputs: Create and initialize output
 instances
Date: Mon, 27 Aug 2012 09:44:39 +0300
Message-ID: <1346049879.4912.9.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	  <1345528711-27801-3-git-send-email-archit@ti.com>
	 <1345814042.9287.72.camel@lappyti> <503B115C.7040904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ixRL449vZIPwSUO9uvCN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:54027 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752053Ab2H0Gou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 02:44:50 -0400
Received: by lbbgm13 with SMTP id gm13so2063686lbb.4
        for <linux-omap@vger.kernel.org>; Sun, 26 Aug 2012 23:44:46 -0700 (PDT)
In-Reply-To: <503B115C.7040904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com


--=-ixRL449vZIPwSUO9uvCN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-27 at 11:49 +0530, Archit Taneja wrote:
> On Friday 24 August 2012 06:44 PM, Tomi Valkeinen wrote:
> > On Tue, 2012-08-21 at 11:28 +0530, Archit Taneja wrote:
> >> Create output instances by having an init function in the probes of th=
e platform
> >> device drivers for different interfaces. Create a small function for e=
ach
> >> interface to initialize the output entity's fields type and id.
> >>
> >> In the probe of each interface driver, the output entities are created=
 before
> >> the *_probe_pdata() functions intentionally. This is done to ensure th=
at the
> >> output entity is prepared before the panels connected to the output ar=
e
> >> registered. We need the output entities to be ready because OMAPDSS wi=
ll try
> >> to make connections between overlays, managers, outputs and devices du=
ring the
> >> panel's probe.
> >
> > You're referring to the recheck_connections stuff? I have a patch that
> > moves that to omapfb side. But of course it doesn't hurt to initialize
> > the output early.
>=20
> I've seen that patch. omapfb would need to take care of connecting=20
> outputs to displays, and managers to outputs. This is added in=20
> recheck_connections done in a patch #9 of the series.
>=20
> The question is whether we want some initial connections made between=20
> outputs and displays by DSS, or should that be left completely to=20
> omapfb/omapdrm?

Good question. I don't know. Perhaps we should set initial connections
there, as the cases where we have multiple displays per output are quite
rare.

> > We should generally do the initialization in output driver's probe more
> > or less so that we first setup everything related to the output driver,
> > and after that we register the dssdevs. But I think that's what is
> > already done.
> >
> > So, no complaints =3D).
>=20
> Another thing that comes up with delaying the recheck_connections stuff=
=20
> is that we can't assume that at the point of panel driver's probe, there=
=20
> is an output connected to the display. That makes it a bit tricky to=20
> call an output function in the panel's probe, since it isn't connected=
=20
> to any output at all. An example is when we request for a VC in=20
> taal_probe. Since the panel isn't connected to any output yet, we can't=
=20
> really call a dsi function to request for the VC. This particular case=
=20
> can be solved by requesting VCs only when we enable the panel(probably=
=20
> makes more sense this way), but there might be other situations which=20
> could get tricky to tackle.

Right. Well, as you said, we can easily move the stuff from taal's probe
to enable. There shouldn't be any problems to that.

However, this problem is part of the bigger problem that I haven't been
able to solve properly: how to manage the probe/enable stuff for panels.
Everything would be simple and easy if we had just one panel per output,
and we could just get and configure everything at probe. But we can have
multiple panels per output, of which only one can be used at a time...

That's why we currently acquire most of the display resources at enable,
instead of probe.

 Tomi


--=-ixRL449vZIPwSUO9uvCN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQOxdXAAoJEPo9qoy8lh71mQ4P/3yldbKxfTqx+OzGK4pawrhJ
opYe6ZTqeIiQPX0XOKoKm8pDLRDAuUGEqqy0SWkIkAwxNtVgMklr1ogcqu2vq2p0
KG1FSJl8R9rPjEfZ5KcCgm0OBqgirmswb7VFdrVRsoN7S+qL2c106iMntI06KlVC
E3IqG9y2I8C5c1rxeaslSQSkWmHc0Jg8MaFz4ZiW85tC0nL9fHXp2gwG2HyEGIFb
wMl5hJLE63wKvT30uhtz70A1yT+pqiZWbPtm+5HZii34CL38o1Ou0dHgnpeQVX8W
7PpTjKtkyo1isv3SrGcP5NTlQOYTDOMkVTUAThhKXGrNzIoCOf+AHh3fXlf36OtG
jOJmHYoybS7ZsZmx3DqQfkUQLAH0jMsLm9Heb1WtcGIoUxpuI3PFTGt3dLLfc+8T
xfg5ydPYVG83w/Cdj8OtKp1eolLCzq9SH5ddw+EXlfBlQU5NTSBcxin/Zu2BqLSz
uAo0IXOt3i+0uBiyfy+1281xnbHFX3kezGpQ67QazD2D74yeA5Gl1wlOzQ7zDa2O
u18npYH3cGanIA9AoNCT6yV81qZl0F/XpPVutzJHxkC8yWQmb2s5Nh2mqF3X/fRj
YxsPq3KMt2agPlRF/lf9RGPWhOlN5Don54MCTSgKkBqrPNyPZPRg9iH0Qvqmj3rn
hW7LO54E29Ilg8aKBnO+
=GZ45
-----END PGP SIGNATURE-----

--=-ixRL449vZIPwSUO9uvCN--

