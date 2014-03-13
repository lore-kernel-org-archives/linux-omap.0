From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Thu, 13 Mar 2014 20:22:54 +0200
Message-ID: <5321F77E.9000302@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com> <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6JUqa9KiRKcS1rmHgaDIA4K5vWWuDwoBV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33305 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510AbaCMSXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 14:23:05 -0400
In-Reply-To: <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

--6JUqa9KiRKcS1rmHgaDIA4K5vWWuDwoBV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/03/14 19:46, Mark Rutland wrote:
> On Thu, Mar 13, 2014 at 08:58:29AM +0000, Sathya Prakash M R wrote:
>> Add device node for DSS module for AM4372. Both the
>> AM437x-Gp evm and Am43x-Epos evm use the same LCD panel.
>> The lcd timings are added in respective dts files.
>> Adds display pinctrl and enables required gpio.
>> Also set the right parent clock to the DSS clock.
>>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi        |   28 +++++++++++++
>>  arch/arm/boot/dts/am437x-gp-evm.dts  |   77 +++++++++++++++++++++++++=
+++++++++
>>  arch/arm/boot/dts/am43x-epos-evm.dts |   73 +++++++++++++++++++++++++=
+++++++
>>  arch/arm/boot/dts/am43xx-clocks.dtsi |    2 +
>>  4 files changed, 180 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.=
dtsi
>> index ea55a4e..b72a7df 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -684,6 +684,34 @@
>>  			num-cs =3D <4>;
>>                          status =3D "disabled";
>>                  };
>> +
>> +		dss: dss@4832A000 {
>> +			compatible =3D "ti,omap3-dss", "simple-bus";
>=20
> This doesn't look right to me. I'm not sure it makes sense for
> "simple-bus" to be in the compatible list.
>=20
> Are the child nodes usable in isolation, or are they dependent on the
> "ti,omap3-dss" node? What exactly does the "ti,omap3-dss" node
> represent?

The child nodes are dependent on the dss node.

The "ti,omap3-dss" represents the dss_core block of the OMAP display
subsystem. The dss_core is a small IP, a wrapper for the submodules,
handling things like clock and video path routing between the submodules
and the OMAP's other components (like the PRCM where we get clocks). It
also handles reset, so when dss_core is reset, all the submodules are res=
et.

The HW design is a bit odd, in my opinion, as the submodules are proper
IP blocks, and as far as I see, they could be designed to be independent
of each others. But they have not been designed so.

Having dss_core as the parent node for the submodules gives us automatic
runtime-pm handling, so when one submodule is enabled, it forces
dss_core to be enabled first. This makes the reset work right (i.e. we
don't accidentally reset dss_core when one of the submodules is in use),
and, as the dss_core is always needed to setup the clock and video path
routing, it gets properly initialized before any of the submodules will
use it.

What "simple-bus" mostly gives us here is automatic creation of the
platform devices for the submodules. We could also create the devices
for submodules in the driver of the dss_core. I did have that at some
point, but the "simple-bus" does identical job, and it seemed to make
sense to me.

Note that the same method is used for omap2/3/4 also, in the patches
that have been going around for some time in the lists.

 Tomi



--6JUqa9KiRKcS1rmHgaDIA4K5vWWuDwoBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIfd+AAoJEPo9qoy8lh71F3oP/RE/j8sH73v1XGPT1k2Ko0O1
6IOAtYGBNLn63X3JJ1CJXM2UjsGu3dzmVMEuhUzXpHaD7PESmK46Qz9c8hPG8ie+
uFcTNxqTZMwJ8KJj5oNiMT1catSadaEB8HZ7X7OtQx0hEC8Wv7RP8F12cFokEDOx
faQj6gZe3QzOUsZ3uoOU+rNEaMvuJtbVAIDoKXCi63eC2HwebjkfH72TaIxkYHX9
xXo+KWOzbGFfB/t0TosGO2oNAFZ7/OO62apx/V0wl+D5kbETfViJsdhDQVfJE6JF
yd92uIoezBQFk3usa2Fz+4OVR4x+QVCFjWpqFZFApe6UooDV6pFrfKFjrQwBL1O6
Ovp/Nl2J7+c/s3fqxGOC2L2RreWNDnAYcdBOQ00IjRwtYsAxUdLhfmEALIatSGFW
v9qNG5oWc2MYxrJ45mGOJmnwPxxBAjwDvEX6nI9NOAWHl9FLFs2w2b6uGTM58WJL
RGyiek2i8LjRxzgftUPUI5GQiFM5dPfqA6DlngaxA7q7O8cPiQRQgvD02a2wBMBT
Vn7/x07EbSC8Z/jBLV27esOLRaCRBQycOrL/3gBJIIWjqgEYgmf+En9OwhZ0AJIy
LNVEJqCPwzXkX6GNBFkVELV6qq2wXOusJJeqc0CqTGv5gDQizeYB24XbRtS7Q5N9
pXrOMy+14IbpnUDBopIe
=lKzX
-----END PGP SIGNATURE-----

--6JUqa9KiRKcS1rmHgaDIA4K5vWWuDwoBV--
