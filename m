From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: mixers changed between 4.6 and 4.10,
 no longer can use in-call speaker
Date: Thu, 12 Jan 2017 19:34:19 +0100
Message-ID: <201701121934.19810@pali>
References: <20170112181826.GA28290@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2317656153361420370=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170112181826.GA28290@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, abcloriens@gmail.com, jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

--===============2317656153361420370==
Content-Type: multipart/signed;
  boundary="nextPart5781762.yLUakYvzvQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5781762.yLUakYvzvQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 12 January 2017 19:18:26 Pavel Machek wrote:
> Hi!
>=20
> In v4.10 (and probably v4.9, too) I can no longer use the in-call
> speaker. I can no longer use the wired headset, either.
>=20
> v4.4 (and probably v4.6) works ok.
>=20
> Any ideas? Does wired headset / in-call speaker work for you?
>=20
> "Mono" and "Mono DAC" options are still there.. but something else
> changed, as alsamixer now shows way many more options (meaning they
> are shorter?) and I get complains from alsactl:
>=20
> alsactl: set_control:1328: failed to obtain info for control #49 (No
> such file or directory)
> ...
> alsactl: set_control:1328: failed to obtain info for control #229 (No
> such file or directory)
>=20
>=20
>=20
> 								Pavel

Looks like there are not so much commits related to=20
sound/soc/omap/rx51.c Maybe it can be one of these twos?

cb7e62256e99d285e415cf75db67558f0f8bb107
6d2de5ab4328718302c54b20222c6b1a574c3fce

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5781762.yLUakYvzvQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlh3zCsACgkQi/DJPQPkQ1LSEwCcCfOuos9mbO0uwlqEAT2JcjwJ
vtIAn2tF6pSPvCibRJfGCH9Y3QrJUxwt
=Tsxx
-----END PGP SIGNATURE-----

--nextPart5781762.yLUakYvzvQ--


--===============2317656153361420370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2317656153361420370==--
