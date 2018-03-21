From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.16-rc5 on Motorola Droid 4
Date: Wed, 21 Mar 2018 20:32:26 +0100
Message-ID: <20180321193225.GA20561@amd>
References: <20180318220418.GA22880@amd> <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4546404309295099787=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: mpartap@gmx.net, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, nekit1000@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============4546404309295099787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Maybe get somebody to help you locally with the debug cable
> > soldering? :)
>=20
> I suppose people from your hackerspace can help you. It's really
> easy to do. Soldering can be avoided btw. You can just use a pair
> of scissors to cut a USB -> Micro USB cable and use a knife to remove
> isolation. Then screw each of the 4 wires into a terminal strip.
> There are USB-TTL adapters available, that have an attached cable.
> If you also cut the connector from such a cable and connect it to
> the other side of the terminal strip you are done. No soldering
> involved ;)

Hehe. After some more experiments, it looks like hardware hacking can
not be avoided :-(.

I should have enough connectors, but I don't know the pinouts. I also
seem to have D-SUN USB to TTL from you (thanks again!).

You say TTL, Tony says 3V3... so I guess the port can survive both?

Ok, I guess I really only need to connect GND, and then D- to RXD?

So... where is the D-.. aha, got it. I hope USB has to be robust
enough against me making experiments?

I connected it the best way I could, but I do not get data in minicom,
and RXD led stays lit. I guess that is not a good thing :-(.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqys0kACgkQMOfwapXb+vIbjwCgup8PiEEfkJqaWogVhqzrXDG8
aJ0An0AgTYkzmez/uIroKAKUsBkBcQ51
=Z4FU
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--


--===============4546404309295099787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4546404309295099787==--
