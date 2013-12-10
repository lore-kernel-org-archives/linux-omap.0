From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80
 serial flash.
Date: Tue, 10 Dec 2013 18:29:04 +0000
Message-ID: <20131210182904.GG11468@sirena.org.uk>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <201312101349.13564.marex@denx.de>
 <20131210161143.GK29268@sirena.org.uk>
 <201312101922.10618.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4392418581915827359=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <201312101922.10618.marex@denx.de>
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


--===============4392418581915827359==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 07:22:10PM +0100, Marek Vasut wrote:
> On Tuesday, December 10, 2013 at 05:11:43 PM, Mark Brown wrote:

> > There is some stuff that pushes up into the controller in that while the
> > device is in memory mapped mode as far as I can tell it's not safe to do
> > other accesses so if someone's put more than one device on the SPI bus
> > we need to handle interactions there.

> OK, so it's either-or . That seems OK, you might want to have two drivers=
 for=20
> this ip block, one to handle it as a SPI block and one to handle it as a =
SPI-NOR=20
> block. ... that is of course, if these two modes can't work together.

Or the client disables the memory map when it's not actively being used
and the stops other transfers starting while the mapping is in place.
I'd expect we'll have to cope with shared use at some point, hardware
engineers will probably build such systems.

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSp11tAAoJELSic+t+oim9U8cQAJAVjZ2XhqRvvnydfHYWdmvb
zBXaj0rmK1LWxO8gEeDQ6dE+oOnZvFD7inV+lX7vgvReAho9cIAtQfIHRlzlhqh0
RhoEIETcu6vCUebJuTCU6U6XHt9xhBTzqpqr2BWmmRQEqwp6200+fJ0oAhG6WkfC
j2SIUqoBkqxG+1gSE9SN42RXbXw6euKY7WP7NFfoBX4lG2x6/ADSsydy3RPTUKnX
MGsKzp21ycN90KeGv1T7Bc3MSKfbKQ5mmwhFF/zXBMxLr++ZFhPgRSKk8UKwdloW
+Rk9FdqQXwqkEA6sDW8bqx+0w9e8qPVcUCXfWy1rTSqTOIqSUJGgj2U9xQvVhb8M
1iJlWX52G0gv/9S0nhCR2NEZzoCrXfTd9AtiS2cg4YSYt2cVzZQzLGk4MqU7ct1A
ZlsqMaItbbM4JRRKYLuIPLy4VN5wxv7fTmad89WQwnV0DJazgL87KnDzaqrBHWt7
B5WVsrXryhuXssl9MzWOzVxyfpnuo5NWjw6P8FkQfjqwtt7YXjPu7UOEV35GTvwu
uBhl7RCwgIujDq2FTq1TjtXY1X1wS/gSTLp9TgDWVWLBCyZbtt9byg/+zyA8uHGK
kI7L7K+N23Sxz0K5JMBCcnaxIsERooi6C84N3o6JxjfpG4eEsygcBXCCq4QXbdli
F1NW2d4tzoIpWs1xkKgR
=PObm
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--


--===============4392418581915827359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4392418581915827359==--
