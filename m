From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80
 serial flash.
Date: Wed, 11 Dec 2013 12:01:57 +0000
Message-ID: <20131211120157.GS11468@sirena.org.uk>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <201312101349.13564.marex@denx.de> <52A7E7A5.5000909@ti.com>
 <201312111144.23012.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0473629712568931535=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <201312111144.23012.marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0473629712568931535==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZVTVymsHR1TEBjP"
Content-Disposition: inline


--4ZVTVymsHR1TEBjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2013 at 11:44:22AM +0100, Marek Vasut wrote:
> On Wednesday, December 11, 2013 at 05:18:45 AM, Sourav Poddar wrote:

> > I did a quad mode support for m25p80 which easily got cloned into the
> > new spi framework.
> > Same can be done for the memory mapped support too

> The quad mode didn't need any new hooks in the m25p80, did it ? That's th=
e=20
> difference here.

It did, there's explicit code in the flash driver for it.  However it's
rather more generic than this.

--4ZVTVymsHR1TEBjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqFQyAAoJELSic+t+oim9HKEQAJ0wkfL4oYPQ+BpyWVEIsX9V
tN9obu/c2zl+UGQlVMsaX3bfBt9r6wiNNr8g63qE7Osouoq0QD012BMfB6bMXo6H
KprLjBBgooiYfNZwPqESa7m20f5oPJ3Zf8gTQVkT1tmD2o/nuWDl5B1tNvxmYv06
5EDrVSRXbRgwA7WnUwziVJoYgy68EAZOIzUBIqVrXrpWbsWU40QGBUROhNr/9lqI
7cWxuZtXu5KAFrhPizQ9edP9m/ZT6eHQVHe1hQcJA1fSbbvSVlzQz9154qg25pUj
0cSVHscm/QqQNZF037RNO5pIhdKYIpVzMQ5JkjsVPNaM0ALbhzv3kDi4d99peXBP
YdvEAbcmjRKwxO0hTM95kUvHI0NibeGQMmjH9hvhcufPzIM8Dap06sNvxM91IfS2
sC47Oq3MXuEM1Uocxv0Ys0Bj9shOVDesIwpma/IW80rq15AzC0yas53duBfK5GG/
fZFe8ioTUzguFFRvZceZLuRt7fgRmU84sFjE99Q00+e1cohBv/hVSRLgt7mxMs33
le5LGwHEQQYPNO3njN86DfYwJo4wn8G+oC8F99SuPphFzU6VQ2hQHyMjUNRaqzXM
/iSYIN21TkZD//EMiDzvc6IwI5u1GKQATCRdghQu9zvOa5MyU6ZLOJw9Y12vPdVt
Fnkp22832HBo+uK1OIak
=SqgG
-----END PGP SIGNATURE-----

--4ZVTVymsHR1TEBjP--


--===============0473629712568931535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0473629712568931535==--
