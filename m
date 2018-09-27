From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [GIT PULL 3/3] dts changes for omaps for v4.20
Date: Thu, 27 Sep 2018 16:59:56 +0200
Message-ID: <20180927165956.1fa539de@kemnade.info>
References: <pull-1537983432-167273@atomide.com>
 <pull-1537983432-167273@atomide.com-3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904324207086901411=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1537983432-167273@atomide.com-3>
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
Cc: hns@goldelico.com, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1904324207086901411==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tFLZrD5gippjZZ7+gBf14f+"; protocol="application/pgp-signature"

--Sig_/tFLZrD5gippjZZ7+gBf14f+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 26 Sep 2018 10:40:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> From: "Tony Lindgren" <tony@atomide.com>
>=20
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343f=
f3:
>=20
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/om=
ap-for-v4.20/dt-signed
>=20
> for you to fetch changes up to e4ab928957a3173d5d8e7fc78df6a3a63be0f60d:
>=20
>   ARM: dts: omap3-gta04: add pulldown/up settings for twl4030 gpio (2018-=
09-24 15:17:14 -0700)
>=20
> ----------------------------------------------------------------
> Devicetree changes for omap variants
>=20
> This branch contains a series of improvments for omap3-gta04 phone,
> and a series of clean-up for am335x to remove the deprecated phy_id
> property.
>=20
> The rest is to configure am57xx-idk boards for leds, load trigger,
> and smps, am3517-evm audio configuration, beaglebone hdmi cec support,
> coresight binding update, and fixes for i2c and spi warnings.
>=20
> ----------------------------------------------------------------
[...]
> H. Nikolaus Schaller (32):
[...]
>       ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
That new file was not added no the makefile. Somehow that got lost
 and I thought a separate patch was sent by Nikolaus as a straggler but
I cannot find it at the moment.

Regards,
Andreas

--Sig_/tFLZrD5gippjZZ7+gBf14f+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlus8GwACgkQfb1qx03i
kyQerxAAqDmHg77yWZJ+DP9XAYVYJpJIxGWLIxTiTGOYZv6iPOU8S60zkp9bManW
Mi24Bo5hpzHiaMpjgX/G8voWeOWUHUVA8UsOB24NPgvaFRKakJBWwTMMqSW7yVhg
eo2W9ZQS74so3lK7IoynU9aNq0bUUM7yGk1euEEs0tLQ4NjlPs28Ld7VQx2T86TJ
o0Ktgfyqyun4/7hoB1bJPl2qbwCTPCqzCf0RFOxlLt6yZV0s67QbIxnE4tAls5sX
Ubf04XR2/Pmkz90WGdDYqtCzSCVdiPbF3ZuW4OQ77FidYRCp9C1HgW/O0nou+59p
vO76uOxkal+Si8nbwPSrOlA9o6CjKwNwJf1m0emBxIiiAcEuBwUtkUxgn8DPMRMx
2yds0wLdNcV0LIYHFOPpRFGqLivviQmicgnUWExtWv/MrCBrIRrj86/e+wB9WD9R
jN8GBv10JY9WFRClPkM+LPbfo6r+XmkkzM0L88efGWRk8OSmbfXcQkQTIA0v0YOS
lTLf/dV5MhZF7PxqcazAvGBur6hJdyTg4luBdkniZ3NXa8sOESFsXVccDkwowMmy
aFfIUsh9yC9MUdNJnh4wLW4G5bxq1Cl8M9JkRjiI8vsBiOdcjE+zJaRWaFnMtqo9
qmg8lQo+wi6QgMhEZ49DcF4iodGXI5VOeyZx17niMr9z/XhRa/A=
=0Nw1
-----END PGP SIGNATURE-----

--Sig_/tFLZrD5gippjZZ7+gBf14f+--


--===============1904324207086901411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1904324207086901411==--
