From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Alternative binding proposal for tda998x audio (Was: Re: [PATCH
 RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph of ports)
Date: Wed, 2 Mar 2016 13:29:24 +0900
Message-ID: <20160302042924.GA18327@sirena.org.uk>
References: <20160218143530.GB9654@rob-hp-laptop>
 <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk>
 <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk>
 <56D41F1A.2030100@ti.com>
 <56D5A6AA.2030907@ti.com>
 <20160301163553.3ef298fb2c0bb25ef662a41d@free.fr>
 <56D5BA6D.8090904@ti.com>
 <20160301171630.630a47dc00060645f89bb8ab@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tfR0eanJeEhQS6vO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160301171630.630a47dc00060645f89bb8ab-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--tfR0eanJeEhQS6vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 05:16:30PM +0100, Jean-Francois Moine wrote:

> As told many times, the simple card is a pure Linux specific entity.
> It does not describe any hardware. It should not appear in a DT, or,

The physical integration of audio systems is meaningful hardware that
physically exists and matters to software.  I am completely fed up of=20
having to go through this, I'm fairly sure I've been through it with you
before.

> if it does, its compatible should be "linux, simple-audio-card".

Documentation/SubmittingPatches.

> Then, how can the other OSs know the links between the audio
> devices and the audio encoders/connectors?

Documentation/devicetree/bindings/sound/simple-card.txt

> On the other way, the audio graph does not impose any particular
> software design. It just describes the links between the different
> hardware components and each OS is free to implement its own layout.

So long as there is no effort on actually upstreaming a graph based card
that shows realistic signs of getting merged in a useful form it doesn't
meaningfully exist.  Right now nobody is even trying to do that.

If you are concerned about simple-card being too Linux specific then by
all means add board specific bindings, preferably ones that can just be
added to simple-card as a compatible string.

--tfR0eanJeEhQS6vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1mwjAAoJECTWi3JdVIfQuE8H/RtAMzyTBBRjSOlqX5+4sq1l
FXbddNGOrgfJ0HOpic1ojljWjPngsQCn2dxtWf+VJ3AuS28zJ49M9jeoVVpXK5Ge
mNWUYOFG3KzsmD1QcQz3f5jNx/fPF/lzUaYt9fHRspcMHSXW5xSAguPfQsWbBlIp
5cNNajYNh5uGWr9pgr9NUCwx/UUvPs23F4N3tCtTC/5OOxzj7pUmKa+zxh09fplk
KbxdEOZKIkCcK6LZ0R4mWCp90KA9mLVDxNXZlyPbuqUFdW9dzXXM3g1GzrdZbohi
zCuYStKs6Nl0Y++0vcv+OIS8OnLn5AOe7aOsz0/217KgenwMXsClXLDTSwBimEc=
=zzXY
-----END PGP SIGNATURE-----

--tfR0eanJeEhQS6vO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
