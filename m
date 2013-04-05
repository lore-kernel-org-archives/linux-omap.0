From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: regulator: query on regulator re-entrance
Date: Fri, 5 Apr 2013 10:44:12 +0100
Message-ID: <20130405094411.GA6597@opensource.wolfsonmicro.com>
References: <1365138582-10409-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8089943007161918235=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365138582-10409-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Guyotte <gguyotte@ti.com>, lkml <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============8089943007161918235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 12:09:42AM -0500, Nishanth Menon wrote:

> If we ignore the details of the class 1.5 implementation, we will notice
> a) regulator set_voltage equivalent set_voltage() is required.
> b) this set_voltage does some 'magic stuff' depending on the SoC and AVS =
class
> and calls the 'real regulator' which talks to the PMIC over i2c/spi etc..
> in short the call sequence is more or less:
>=20
> driver (cpufreq) -> AVS -> PMIC regulator.
>=20
> By modeling AVS class drivers as an regulator, we then do not need to int=
roduce
> SoC specific hacks and APIs.

But you're shoehorning something into the regulator API which isn't
supposed to be there and causing yourself problems.  This just isn't a
good idea.  The regulator API already has a mechanism for supporting
regulators which are supplied by other regulators, if you can't model in
terms of that (adding something to support variability better) then
you're not using a regulator.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXpzfAAoJELSic+t+oim9RaoP/iU25GrbgzdsFkKLALHexFZ3
uhkGuGcJxYRQa9La6f/LRCWWmCX+QL/qAuXXK8UYaeYWHpNOLYvODN13NpxRwTk+
FtvK4M02/AnKSh3j2uIGkgqzAiufYlRx++jNgrlAp38kvLATJdDZWavqHOgsvv6W
x34cWQtJ9hROm6KEPea0nRmILK6CXkqIUOB3/dcEXVI8P6jYp7tZJdxvHvfuZVAi
9aJK9+/pz7L7aqxo3N85xCtzxZEan7fhYArc4emA/ZPr/R2qDIRiqQwvhQM83PUv
4ifA4ls1g0ILKXAsQkuJH/FrX4jSY9zN3ZT9UvbLpmJMYwfgc8fE0MsfL2RJ8kXv
2mZZJTtKdrObysEW0L0oTxR58B1cEjayWKQl0DdF4ig8DVHTdUrV2FbGkS8f1CkG
73OPekcO6l4zxpH1Ep7NEmRYBGQO3/Zde8LTZVHjIGtsBRs9jQMoqVF6bZLdTiwZ
B4qZDpKHGkdazIcPg8Ewvvn7pKR+lUUk+qSnSNUMAdyvqXraRn+yTm/6UYltMb3h
oV72n9gi4aRcdzIL0dL5/STPi0C8v6GZ7dno1i6afifP9wTgc1HWbctqlmRB1fq1
5nKMb4aCoSdGR9L6sGULU7iRBGc7E2R9H1Qti8Xq2qM/Nkvsi8kwQc53dw0LaC37
KRos2uwxeVx5zIkyMCMW
=yICT
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


--===============8089943007161918235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8089943007161918235==--
