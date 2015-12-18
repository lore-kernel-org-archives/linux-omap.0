From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display kconfig options changing
Date: Fri, 18 Dec 2015 18:14:19 +0200
Message-ID: <567430DB.4000507@ti.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com> <20151218160514.GK23396@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410187079347486633=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151218160514.GK23396@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1410187079347486633==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eUrFAKxpt8AOTCMPGXPkMN1QKDAl2Pq2b"

--eUrFAKxpt8AOTCMPGXPkMN1QKDAl2Pq2b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18/12/15 18:05, Tony Lindgren wrote:

>> Are you referring to Kconfig options? Or userspace?
>=20
> Well sounds like both need updating :)

Depends... For simple fb apps, omapdrm works fine, and X with the
standard fbdev driver should work with omapdrm too.

But if the userspace is using any omapfb specific apps, then yes, update
is necessary.

>> But no, I don't have links to either.
>=20
> So change the Kconfig options and then deal with the flood
> of angry emails? :) I think we need instructions..

Ok. I think it's then best that I just update the defconfig to enable
omapfb as modules, as it is currently.

We can look again at changing the default to omapdrm after we've tested
it on OMAP2 too, and we have a better idea what the user needs to take
care of.

 Tomi


--eUrFAKxpt8AOTCMPGXPkMN1QKDAl2Pq2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWdDDbAAoJEPo9qoy8lh71XDoP/3qYGAIDKRSd1CkZpH3yQYxk
FG6H3x7QPxYuU9hvEiyWUY0MLhbB4IW8A5JP5z9Iyv/yBqsnwn307alnETn4M2d4
NtMT7JWIqGgpBKJUeIoS9XHcwsu6JtBsbdpwtVM7XJOuhNiTVUfrjVz0+a9+Ahwg
tjYmQYnf6jOYRrO9JBlmy55o1mgC5NOCS9+UGFK6oJwgdEDcTffz9JgY4LLG1bzR
ou6GMbqoK85wSmfpEuZCaLSgjjPXW40Bv7+oFy0MqKCL6Sqm8vt85ruOiO4o0x2Y
+bAR/KisJ7Zwaeqi+JH8Mjk3MhVFJNCCJ4TTJnrhNsRCtsT5IpeBrpSAI9HcHMZd
tFHg0eCqvKVuDOG5d4xbbXAM2SeeTkXc2n2aod09ZHVWiHoyZzOpAs2FwnrwVrNk
MSD1HxfUXZNm+J7rhQRl82tMYWZYUHRNLSfKeT6Gga7mOenV6sn4TA/gd/Rk+m0X
nNpL5Va8bCYjHKku4fHx5xD9JkcTU7tRXRNJjjfQUBvmxMQLKvQvPzmGAonuST+6
FutwqgP7dSbPi1eivd6G4M9AM1gJDKe0ylr1iEewAEyvq4Wqh/CBSZgAnxVW9FFQ
UwZD96dYFlTeqvawLSQCliFbfkM5JyyvKMTRnCZnbbZgMYk6KwU10d644WB5MbY2
hieV6oJF6+L+NSidTtbS
=A2ZJ
-----END PGP SIGNATURE-----

--eUrFAKxpt8AOTCMPGXPkMN1QKDAl2Pq2b--


--===============1410187079347486633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1410187079347486633==--
