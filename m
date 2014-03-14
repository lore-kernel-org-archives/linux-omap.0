From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 11:42:26 +0200
Message-ID: <5322CF02.4060705@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com> <20140313174623.GD25870@e106331-lin.cambridge.arm.com> <5321F77E.9000302@ti.com> <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="94oWdbDhAN9UXid7fHXh4PWhiLLUktFiG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60270 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740AbaCNJmn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 05:42:43 -0400
In-Reply-To: <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

--94oWdbDhAN9UXid7fHXh4PWhiLLUktFiG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 11:10, Mark Rutland wrote:

> The "simple-bus" compatible string is intended for busses which are
> transparent (bar some address remapping expressed via ranges), and is
> not intended as an annotation to get Linux to probe child nodes.
>=20
> Any node with a "simple-bus" entry in the compatible list should either=

> be handled as a transparent bus, or optionally as the more specific bus=

> it claims to be (where some hardware configuration may be required
> before children can be probed). Unfortunately Linux probes chidlren
> regardless, which is arguable a Linux bug.
>=20
> There's no reason to leak this issue into dts files. Please remove the
> "simple-bus" string, and get the dss driver to probe children as
> required -- as described above the dss node never makes sense as a
> simple-bus.

Ok. I'll remove the simple-bus, and make the dss_core register the
devices. I presume of_platform_populate() is fine for this? Seems to
work fine for registration, but I haven't figured out yet how to
unregister the devices (I get a crash in platform_device_del() if I just
call platform_device_unregister for the submodules).

 Tomi



--94oWdbDhAN9UXid7fHXh4PWhiLLUktFiG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIs8FAAoJEPo9qoy8lh71HK8P+gI5LTBKtvGrxIndW4lE1WNr
qw1qgkyBxPsjx6pLW5BaFrIaw7qZXWmCb9VAt8wG/FLuwrrk0dF7QsJ0azrgjSKs
gjhigWnfHyxob/62DASfpZ+8+8a1L1fM3w4t/v4A3V2DbVzzxVcELhrAAthIaR1g
mY4KyVyMAQN8yvWhO0nzjvI3H+xc4xRUvUgSF2juHHowingMvPFSbJzOiHmD88zm
VoT3EkjYWdN4IrwwyKJuJ4HOBAqjgtjnsEk64E+HLLKzzu8ae0SvLmg5E3JGDBQ2
fBr+fQs+Py1SWmk4c5lXIyQAx4Y4mabFeqBeqie8czTPiijczEcWrbxeNLiman1m
0RiWKhGzXCRwp1VVTF6YY9pE/4hdf7HuAmD8QwapUMXiJLZo+35KhMfiiXL97FLH
1vKVRTEQzKwA1DK9XaQ9/KIf/zx9PKlRXPZKqVIZt6U++VN/ZuW0BurZML5usc2O
gk1hxWNjzM6+9Nrq8/58VfAEnFEHwAssehr3GyZazx3pGu0gu8LVrrFCEKYb7QBf
PkFXER0Dtxiq6vEctYG8R9fzSseZuJASDr1EzEs5zQmTAC73olEHHQgJZIsstwpq
pAxHD9ZtqDnmTtE52gYW6AwrI5BNwV1HoLIsT7ThlpT1e6gR3TLDEDdvsp54jlPu
wLtrCoV2BsquXX45iV/f
=kgfZ
-----END PGP SIGNATURE-----

--94oWdbDhAN9UXid7fHXh4PWhiLLUktFiG--
