From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv3 2/6] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Thu, 27 Jul 2017 11:01:41 +0200
Message-ID: <20170727090141.sxzm6mq5cv4jzucg@earth>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
 <20170725151030.26863-3-sebastian.reichel@collabora.co.uk>
 <20170726114827.pye3jm2b7x2nqo5v@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i5k4nbhcxf6tu2yc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170726114827.pye3jm2b7x2nqo5v-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--i5k4nbhcxf6tu2yc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 26, 2017 at 12:48:28PM +0100, Mark Brown wrote:
> On Tue, Jul 25, 2017 at 05:10:26PM +0200, Sebastian Reichel wrote:
> > Motorola CPCAP is a PMIC with audio functionality, that can be
> > found on Motorola Droid 4 and probably a few other phones from
> > Motorola's Droid series.
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

Right, I did not notice, that ASoC does not follow general
"dt-bindings: <subsys>:" DT bindings subject style. How
do Rob and Mark find them?

> > +&cpcap {
> > +	audio-codec {
> > +		compatible =3D "motorola,cpcap-audio-codec";
> > +		vdd-supply =3D <&vaudio>;
> > +	};
> > +};
>=20
> I'd expect supplies (especially generically named supplies like this) to
> be looked up at the chip level - aside from my general concerns with MFD
> subnodes like this in the case of supplies it's especially problematic
> as it makes it harder to do the generic chip level hookup in the DT and
> it precludes other parts of the chip using the same supply (which seems
> especially likely with a generically named supply like this).

I don't follow you here. Why can't other parts of the chip use the
same supply? Regarding the other point: Handling the audio-codec
differently than all other sub-modules of cpcap seems much more
problematic to me and the codec is basically the last one
missing:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/motorola-cpcap-mapphone.dtsi

-- Sebastian

--i5k4nbhcxf6tu2yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll5q/IACgkQ2O7X88g7
+pqNKQ/7BJo2CmgEm13k1dLTu2NjNudBLCUwyvMa2N1Kdh7++p9fvETKtzAsMVmA
fVSXvbm7ngvo935weBcvqoq2Y/uCLYXNugJThBJvJjKWo6sc4tF8XMkW9pXTf3Ta
6otB1P0sYlqsjSkpNG3fBc67MsLUgjkMyKTMhL5QUq/2/UuRzD8HCAqL7P3Bld74
5i/qF3zhGoYcxrcciugJMrP2l47OLlMhV0gqaS/5fGgv5mjfm5/gMQ8vd1xHaQo+
LJJgBZ06iHGygn43N2mSqLklYyEpuMVxsSLAaGm98dybVjou+7N/dmtVPVG58pzP
QCD7CdeI+pnQCzljGkg+F8h7PmyEeEg2TRZnpspX8Ga1eyxRn+xfu3/Kav+NO1u0
28sHGIwTb6VziGpTGcw91t+DvilYv2ArOtz/sI38jJjZYjy100n1/8hibEYn7Meq
Z2TW76mwsvhik4MpU+paH8GPkRFiMSeA9TNYv3x0lcgV3Rnkp3EW/hvQNnjdrnbr
NTvnMzQncvVZdwV3r5SwMKD2Zx4XozBdiaUqD8s0e9T8YYXy2RVh6+qFHxedRDYi
nm9wRsvJOHygYIuEqU4x+LRM6hHp1pttcrzkf4tvGGaUVfQmkJdSA4216xYT7HZw
whmNpnJ+at/lG4kSrfSNb95tpHZA4GMUljH4gJeUhNzOF1c7jPA=
=2pSy
-----END PGP SIGNATURE-----

--i5k4nbhcxf6tu2yc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
