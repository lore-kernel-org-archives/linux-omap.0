From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Tue, 25 Jun 2013 19:02:43 +0300
Message-ID: <20130625160243.GE22312@arwen.pp.htv.fi>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0604529552677696958=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tom Rini <trini@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0604529552677696958==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline

--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
> Boot to userspace:
>     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt

Paul, we have at least 2 different folks who can't reproduce your bone
and bone black boot to userspace failures. I wonder how you're trying to
boot them.

Care to share your test scripts ?

Also, if you could share the entire thing, we will add your scripts to
our nightly tests as to try and avoid future regressions.

--=20
balbi

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyb8jAAoJEIaOsuA1yqRE67sP/3Ymw/bJensgenbTx2Oo+ZIx
gm+8MdBF/M2XvYRvN2lAzF5L/PbW1AfMPrBlgAkuZFy574isEmGFNh5f/8V29ccO
fvi/RigZz/DMxYJiQDWSpuP7rWE2yIKpTEpfmkkNf5HG2JZDL5uilozMOjSUt+Af
ph30JSYeCga4sSUqWOmlF8hCV+lTR3A0485ufwB+MBPXx/XQo3c0oTuhiIb1Vsa+
6Wou8vu5Kbc5w3gVY5jffuhMy5tIlXg30FLv6iaE8meaI+yx2Iytpz/Zfod72b9u
rGeNvydJgwHxLz5OTmvImep0ODOMBzO4sQq1LCUQ4UJG9WOWsarHgTPSQWGqZzWH
c8AZ+McY6gf8c+A3YGwFky3LioHJE5wjOHRQxNoMEJWLyXfbRV4db8dV4OhN/0fV
pGsx1G5vhY9qh6v3x+48/uToMd1C5+XkkbmyFb9XfTyGJ1ZSZGRtw8YpK/32DZu9
viliG6EtUNvm6xoTv57GyP8s3HN4nnMO/PPnXnD8j9lIzE003qBGVimVrx4oF1XO
kcBnR/NOF6UavcDWOr9HyXAbLbbxcsSO7MrbLMHsmHiXNCpPWjrIqLZN/zc0mQJJ
N1xrz/m9L5j7Ffmi9/76xg/Q1t3hc+55nKph7bcoC4w6pUp6jMFT33C1NcIR5d9G
6KJCcZd+8Cviyfsjyux/
=0iMI
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--


--===============0604529552677696958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0604529552677696958==--
