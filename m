From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Thu, 21 Jul 2011 12:39:33 +0300
Message-ID: <20110721093932.GN23253@legolas.emea.dhcp.ti.com>
References: <1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
	<20110718090710.GZ5783@atomide.com>
	<20110719213458.GO6848@ponder.secretlab.ca>
	<4E27E967.7090501@ti.com>
	<20110721090918.GI23253@legolas.emea.dhcp.ti.com>
	<4E27F264.4040409@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2834071597553286848=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4E27F264.4040409-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============2834071597553286848==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4OpS+d6oOtUQaRm1"
Content-Disposition: inline


--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2011 at 03:03:24PM +0530, Rajendra Nayak wrote:
> >IMHO, all omap_hwmod_*_data.c files become pretty much useless if we
> >move completely to DT. All hwmod data is passing today, can be passed
> >via DT and in a similar Hierarchical manner.
>=20
> Would the data representation be equally readable?
> That's one of the problems I faced when I started
> looking at it initially trying to move a lot of these
> structures.

not to my eyes, heh. I'm too used to C, though.

--=20
balbi

--4OpS+d6oOtUQaRm1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJ/PUAAoJEAv8Txj19kN1CtMH/RUo+oS8FC8pQDi78fTIKvWu
cyj+vUA3c6tgGcIkHcN6qbzOLQMfoNEk4kI+ieLCIslC4ZtTcL9yxskc0cwvYY5s
Cci4lq0QB2j9BnqNbrcjkY7bFZAqiasQQsSZlDmlmSSBNm6FAeGvrRALEQF97puX
zSldRpTrJmWCCrY8ntPeNzxlQTVfnJ8B4SesP+m+H9PkF+wZUGapZ4zTxQl0g4Mh
9RXbXBSfqKU1+VjS2wXh5IPBzFrNBKWLyvZjBAiH78Niv58QFBi1x03wInY5rPXh
FEDk4KQGHEHqdwQOqjfylBtFJw4lQVLHXGY4i1GhyaWiWtG1PnAQ+Mh9wz6eDjE=
=KOpK
-----END PGP SIGNATURE-----

--4OpS+d6oOtUQaRm1--

--===============2834071597553286848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2834071597553286848==--
