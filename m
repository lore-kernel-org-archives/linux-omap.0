From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Tue, 28 Feb 2017 09:04:21 +0100
Message-ID: <215a254c-610d-24c1-0bd0-b047f3ebf063@pengutronix.de>
References: <1487346753-19286-1-git-send-email-yegorslists@googlemail.com>
 <1487346753-19286-3-git-send-email-yegorslists@googlemail.com>
 <20170227164452.3y3ilfxcb2s5ltnt@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XQ8cR5WVcdstb697diix8dNMc72cXi2rB"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <20170227164452.3y3ilfxcb2s5ltnt@rob-hp-laptop>
Sender: linux-can-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, andrej.skvortzov@gmail.com, Anton Glukhov <anton.a.glukhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQ8cR5WVcdstb697diix8dNMc72cXi2rB
Content-Type: multipart/mixed; boundary="BFePjH2wbDMRaUaDKLOAaj00w3cV77u6b";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rob Herring <robh@kernel.org>, yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, tony@atomide.com, andrej.skvortzov@gmail.com,
 Anton Glukhov <anton.a.glukhov@gmail.com>
Message-ID: <215a254c-610d-24c1-0bd0-b047f3ebf063@pengutronix.de>
Subject: Re: [PATCH v5 2/3] can: ti_hecc: Add TI HECC DT binding documentation
References: <1487346753-19286-1-git-send-email-yegorslists@googlemail.com>
 <1487346753-19286-3-git-send-email-yegorslists@googlemail.com>
 <20170227164452.3y3ilfxcb2s5ltnt@rob-hp-laptop>
In-Reply-To: <20170227164452.3y3ilfxcb2s5ltnt@rob-hp-laptop>

--BFePjH2wbDMRaUaDKLOAaj00w3cV77u6b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:44 PM, Rob Herring wrote:
> On Fri, Feb 17, 2017 at 04:52:32PM +0100, yegorslists@googlemail.com wr=
ote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> DT binding documentation for TI High End CAN Controller
>>
>> Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  .../devicetree/bindings/net/can/ti_hecc.txt        | 33 +++++++++++++=
+++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.=
txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/D=
ocumentation/devicetree/bindings/net/can/ti_hecc.txt
>> new file mode 100644
>> index 0000000..a7c601e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
>> @@ -0,0 +1,33 @@
>> +Texas Instruments High End CAN Controller (HECC)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>> +
>> +This file provides information, what the device node
>> +for the hecc interface contains.
>> +
>> +Required properties:
>> +- compatible: "ti,am3517-hecc"
>> +- reg: addresses and lengths of the register spaces for 'hecc', 'hecc=
-ram'
>> +       and 'mbx'
>> +- reg-names :"hecc", "hecc-ram", "mbx"
>> +- interrupts: interrupt mapping for the hecc interrupts sources
>> +- clocks: clock phandles (see clock bindings for details)
>> +
>> +Optional properties:
>> +- ti,use-hecc1int: if provided configures HECC to produce all interru=
pts
>> +		   on HECC1INT interrupt line. By default HECC0INT interrupt
>> +		   line will be used.
>> +- xceiver-supply: regulator that powers the CAN transceiver
>> +
>> +Example:
>> +
>> +For am3517evm board:
>> +	hecc: can@0x5c050000 {
>=20
> Drop the '0x'.
>=20
>> +		compatible =3D "ti,am3517-hecc";
>> +		status =3D "disabled";
>=20
> No need to put status in examples.
>=20
> With that,
>=20
> Acked-by: Rob Herring <robh@kernel.org>

I've updated the patch.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BFePjH2wbDMRaUaDKLOAaj00w3cV77u6b--

--XQ8cR5WVcdstb697diix8dNMc72cXi2rB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli1LwUACgkQHv7KIOw4
HPYgnQf/Tm7qMxPAJitc/S+IPYloe0lQPB722S9ukm3AJJKYhDoR6NUgp+2LuFBw
M0uUR3+XzpTXaSJIV2c1jTnMAFUCSMGa79euMWaA0WeWFRcyzNPj62KpjIFruD89
OhSaBICcPPM5c2g21DH8K0iZ94VQ4RyBS3BpPGnC4OYemoT6uw/dZO8wieqlcAh6
dM1t79SzmUlObdB4+FyzNS/113LAiGeZ+jGD39aC4eME7OkIq9mAFQggc1USQKDB
NNSXgVuS8cR6ixszFjove4aUeRRkkAZnsUqvxs6IZ7IGEDcfJFHhAwNIuoQyKUja
rXgyQvfyDxhyxfrULf3cS3qsM0lfjQ==
=ed/T
-----END PGP SIGNATURE-----

--XQ8cR5WVcdstb697diix8dNMc72cXi2rB--
