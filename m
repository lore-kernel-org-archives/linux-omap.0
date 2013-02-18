From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from
 driver
Date: Mon, 18 Feb 2013 12:11:13 +0200
Message-ID: <20130218101113.GB32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com>
 <20130218101032.GA32688@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab3BRKLg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 05:11:36 -0500
Content-Disposition: inline
In-Reply-To: <20130218101032.GA32688@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2013 at 12:10:32PM +0200, Felipe Balbi wrote:
> > HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
> > Also considering UART also needs async wakeup enabled as it implements
> > another such hook and attaches that through function pointer.
>=20
> this is exactly what I said at [1], which I quote:
>=20
> "Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
> there is still the regression of UART never being wakeup capable.
>=20
> I wonder what are your ideas to sort that part out, I mean, how do you
> plan to implement ->set_wake() for the tty port ?"

[1] http://marc.info/?l=3Dlinux-omap&m=3D136093334914275&w=3D2

--=20
balbi

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIf5BAAoJEIaOsuA1yqRESCwP/A8AD3cq1wz4lN+1YtBpaiLB
ReSemwQFgX+skkOb8zC4bBEbEqDs1JOAn1+kMCrRQ5DIKHGyOw8WJZPUJIXXYAwi
9MsFA7dN3snFLWstL/EgpGxsh938IQ33bvHnIz7IUk23NlvGLGK8DcNBLVqI0SAt
LKYKqYlSlX8LAlW4lLhdBNbDmzuM6sqpU0nGVyk0Hj77kLFYgI9rCLfDAbYXsd3+
/73MguarpQ7JKyae9IfY9lI9CTx+ZcyQNPZXFJuKMZvLxpy62nuHof3wRd53jrIE
mg354wF8tNf6Gsm5vvJZqztFSfpC7u69mV6JWEEFZ3MS/hUTen/zkTyWt2hsGjEA
NZZcZyZXSWeQ9wuw3QoepMH7S+g3W9InJqgl7ZZqp1zUudGy57jMuG8iB13HNZsq
BrcpDjmmMvsYmUtmeGuz5KPLKN548M3PwoAF0olHpH34AZaVaDc4MpaTDUpwuxpK
d7ZvPk7im9H+BNeu7izdy2dPFSfrq2Fe1jz93hmF4Avc+xdKNcbCepkDluX3q81+
uwAkw637+UZxeeWrB1M+x8uWtmxdv7t5yJGsLsCVJU5K65a9m9WypDincKlqnNfX
VsK5l3VZbMPWogPsvgBfnyqVmR6QbFG5ppL32CJrAiX0isiOlmEyUKFZIfF/MakI
8yflQE58hv5ET40hCOew
=/Q9Y
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
