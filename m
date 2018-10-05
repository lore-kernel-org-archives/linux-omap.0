From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 1/4] i2c: core: remove outdated DEBUG output
Date: Fri, 5 Oct 2018 18:14:54 +0200
Message-ID: <20181005161454.usqywe3lbfqjqzb7@ninjato>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7096344634365894038=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920161423.13990-2-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============7096344634365894038==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rp6ctkos6whteo6v"
Content-Disposition: inline


--rp6ctkos6whteo6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 06:14:20PM +0200, Wolfram Sang wrote:
> The usefulness of this debug output is questionable. It covers only
> direct i2c_transfer calls and no SMBUS calls, neither direct nor
> emulated ones. And the latter one is largely used in the kernel, so a
> lot of stuff is missed. Also, we have a proper tracing mechanism for all
> these kinds of transfers in place for years now. Remove this old one.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I think we can have this clean up already.

Applied to for-next (with updated commit message), thanks!


--rp6ctkos6whteo6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3jf4ACgkQFA3kzBSg
KbaG7A/+IhzmCWs1kYes2Jw9B0ugqJbpR+A1XosxCrDQVX5Gpf+xdiab4TDkUbps
rX71fa+vWxIT6o+E0Ijj/bMdR2crOaV90Ij7m8CtvLYsPvo+xNiKbB2bZGiJf99f
PBM1snjcVO3LRBaEXl6lBv3UQ7l2EKHGbHkH3hIY2mqgh86WDjADXrvDzawXP173
VOI8j/ScSHJ/HEizTaHI0ZrmKnz09XO/lLmRGzQdYA+01sMU0BK/IyoiTAeCiECu
MUAz5nrrwuUgHriv9o4BUWVA2uRg8pIPEd0O0E5UnpXSVyIvenQkIKOyzRVFvNoH
nRg9KaTWtBsWjcml7SH8vHRPRza6Ba30zFN/HAqAzgLVdSGmfwvIll4RRCAUTJGx
7TZF6w246PxocBaVdZbqY/+hiqwi/eWDgkjr5fFh1Wv7CUrjog4J+l9eTeslEy2Q
bowoKjN1YGwZB2f1s5JN9vy8gBNqkbEM8GX+Isi7qBIzGDPOpYRfOW57lvM5NOm1
WmL0qD5GgBysjiVkq28n4v4/ulZtRft4M5tdeQ6hR68LPkBjnasFRYgRMNCYnRyk
DBPz2GQH5NQ7Sw8Qxx2+U3oDt3o0XxNcm1LGQqeOOKobQmtXm7nrUmFVvX4HT/Dt
rEE4YVlOSA1/l8b23lPiVAcUVwri68xUDDp6HXeDP/73mpp3eQA=
=IVUT
-----END PGP SIGNATURE-----

--rp6ctkos6whteo6v--


--===============7096344634365894038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7096344634365894038==--
