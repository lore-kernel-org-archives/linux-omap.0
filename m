From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
Date: Mon, 17 Sep 2012 15:37:08 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E2F0@dolphin.TIGRIS.local>
References: <20120917131723.GB25899@glitch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2428144771262612631=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120917131723.GB25899@glitch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Domenico Andreoli <cavokz@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2428144771262612631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-5XOQDs/JdOqaJR95x9Dg"

--=-5XOQDs/JdOqaJR95x9Dg
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: Domenico Andreoli=20
> [mailto:domenico.andreoli.it@gmail.com] Im Auftrag von=20
> Domenico Andreoli
> Gesendet: Montag, 17. September 2012 15:17
> An: Maximilian Schwerin
> Cc: linux-arm-kernel@lists.infradead.org
> Betreff: Re: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
>=20
> On Mon, Sep 17, 2012 at 03:08:44PM +0200, Maximilian Schwerin wrote:
> > This change allows preventing the message "Uncompressing=20
> Linux..." from
> > being sent to serial port. This is necessary if the primary=20
> serial port is
> > used for something other than kernel debugging (e.g. some=20
> external device
> > controlled by serial commands).
>=20
> Disabling CONFIG_DEBUG_LL doesn't work?
>=20
> Regards,
> Domenico
>=20

No (never had that enabled), but that may be a bug or omission in the =
platform (omap3) code?!

Regards, m.

--=-5XOQDs/JdOqaJR95x9Dg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBXJ4YACgkQ6nqkzTWctv55iACgpEtWetMb5B1x/PfsP7tDb9Rw
hMUAnj0QMoZH7yaLHlB6caTNshKzTYlY
=vxH3
-----END PGP SIGNATURE-----

--=-5XOQDs/JdOqaJR95x9Dg--


--===============2428144771262612631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2428144771262612631==--
