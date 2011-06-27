From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Mon, 27 Jun 2011 11:35:09 +0300
Message-ID: <20110627083507.GG2508@legolas.emea.dhcp.ti.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
	<20110627080036.GB2508@legolas.emea.dhcp.ti.com>
	<BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0187468532=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: patches@linaro.org, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0187468532==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 27, 2011 at 01:38:54PM +0530, Jaswinder Singh wrote:
> Hi Felipe,
>=20
> On 27 June 2011 13:30, Felipe Balbi <balbi@ti.com> wrote:
>=20
> >> >
> >> > +static struct regulator_consumer_supply sdp4430_vusb_supply =3D
> >> > + =A0 =A0 =A0 REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
> >
> > this should be an array.
> Ok, I can make it an array of _one_ element.
> Though I am not sure why is that a good thing, or are we to use another
> possible VUSB supply on Panda/SDP boards ?  Please suggest so that
> I can add that too.

same comment I gave before to another patch:

it makes the diff a lot easier to understand should anyone modify this
later. It's also a matter of consistency.

--=20
balbi

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOCEC7AAoJEAv8Txj19kN1WcsH/3gyvc8dIiUW/iwV5DePtjSN
cuXUbNATkijF6auIw95XXvg8b8lH2HDQf/3lofrQqspOUNhOtRApHs5DgXPHCxi6
AkCjh0h8ajUqdUwtRFUPFlJ5g5XHgLOzpEM3eaoHHowJy1ozXdpP8s8uAGO/9Shy
ceoc8w881GB7slLZsbiCEFPpzR7UojnTceGzBjCbdoLYL98W3Bl0m1sahOb5v96q
+OEchsB7CNCu/kwp8GfjEPd1kCWsKf4tv92fWrvqML2F4oZzW3sjy5MHLrX0zJXc
sPATOPDPIfIzX6ZT3odiQxtr8Q6zyuN//dIO4h0mRVq5wMM3XN4J4ynb8bnz+hw=
=STQ6
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--


--===============0187468532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0187468532==--
