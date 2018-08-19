From: Alban <albeu@free.fr>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Sun, 19 Aug 2018 13:31:06 +0200
Message-ID: <20180819133106.0420df5f@tock>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TQqb4/k1M=FtYu85dR=ch4z"; protocol="application/pgp-signature"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180817182720.6a6e5e8e@bbrezillon>
Sender: netdev-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Aban Bedel <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.c>
List-Id: linux-omap@vger.kernel.org

--Sig_/TQqb4/k1M=FtYu85dR=ch4z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Aug 2018 18:27:20 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Bartosz,
>=20
> On Fri, 10 Aug 2018 10:05:03 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>=20
> > From: Alban Bedel <albeu@free.fr>
> >=20
> > Allow drivers that use the nvmem API to read data stored on MTD devices.
> > For this the mtd devices are registered as read-only NVMEM providers.
> >=20
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > [Bartosz:
> >   - use the managed variant of nvmem_register(),
> >   - set the nvmem name]
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com> =20
>=20
> What happened to the 2 other patches of Alban's series? I'd really
> like the DT case to be handled/agreed on in the same patchset, but
> IIRC, Alban and Srinivas disagreed on how this should be represented.
> I hope this time we'll come to an agreement, because the MTD <-> NVMEM
> glue has been floating around for quite some time...

These other patches were to fix what I consider a fundamental flaw in
the generic NVMEM bindings, however we couldn't agree on this point.
Bartosz later contacted me to take over this series and I suggested to
just change the MTD NVMEM binding to use a compatible string on the
NVMEM cells as an alternative solution to fix the clash with the old
style MTD partition.

However all this has no impact on the code needed to add NVMEM support
to MTD, so the above patch didn't change at all.

Alban

--Sig_/TQqb4/k1M=FtYu85dR=ch4z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbeVT7AAoJEHSUmkuduC28SdMP/3+kDayzSjsABxnvDQU4p5lQ
NA13kysUhSl4DlckghrBsgoq9/Jwg+jFjOWflojpHLDKAWpQyzZQU/pd+M99JorF
StfVexTlBJqB0gz0wOktfK2XCspxhXSlUa5oWKPDdvVPPNNdVDhfNaQXo6m1SWPg
DH4Dqmc58UUX0VtLVjPscQLECINAbhvb0T6axgnyev7GXhoV8BJGZs9D+Ap3MAUW
afsXgaAOaQ8W8W14m8KJ3FsJnj78vXVKoZSbWDvhAt67gt8nN/7SMtEx/vT1ceYD
vlaWHNMi/6Vsx4SsrdfP2OD9mjj17J61UFjtdXgJDLMgX+Xligr+/uGJSYSCXCwD
skxKnfs9B391RVeH76q1fIFE1sTBNTO7/3uwl9zF5vDKoPrLtVEu8RpN0SDxZMHJ
qQy05vA8FoG33IeUAUQ0URiDHH9BaYOmMT735CCtsJD2lujQWU93MXIgb7/5lb0u
FzYH5lpWnqeP8NJnLplr9g2LG7ucE4IjUoKjp5OHEwv798HWUILmCK4TZRWDwrGx
cV7a7p0jXiRgkw5haBA7zs3bjYo0p7k46F+6CZFznQEndOKReOsiYT9kdr53V2qK
sjleNX8U24LXgPeTibUkCfDsk2o9vbB0qd07Afc4div8Blm3pUbd/g1XxTdJsv4a
zX3GoEXnpt5VB6qK13EN
=kqAD
-----END PGP SIGNATURE-----

--Sig_/TQqb4/k1M=FtYu85dR=ch4z--
