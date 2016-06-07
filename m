From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 7 Jun 2016 12:28:54 +0300
Message-ID: <575693D6.2010903@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <8737oxl4dn.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iT8lkeTJWViCsVCLXC4S62DgtMqF9N26X"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8737oxl4dn.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--iT8lkeTJWViCsVCLXC4S62DgtMqF9N26X
Content-Type: multipart/mixed; boundary="WInuaa3HUIM8US08mCwClG5Apr8GHFW5Q"
From: Roger Quadros <rogerq@ti.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com,
 sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com,
 jun.li@freescale.com, grygorii.strashko@ti.com,
 yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <575693D6.2010903@ti.com>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
 <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com>
 <8737oxl4dn.fsf@linux.intel.com>
In-Reply-To: <8737oxl4dn.fsf@linux.intel.com>

--WInuaa3HUIM8US08mCwClG5Apr8GHFW5Q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Felipe,

On 01/06/16 11:06, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Roger Quadros <rogerq@ti.com> writes:
>> Implementations might use different IRQs for
>> host, gadget and OTG so use named interrupt resources
>> to allow Device tree to specify the 3 interrupts.
>>
>> Following are the interrupt names
>>
>> Peripheral Interrupt - peripheral
>> HOST Interrupt - host
>> OTG Interrupt - otg
>>
>> We still maintain backward compatibility for a single named
>> interrupt for all 3 interrupts (e.g. for dwc3-pci) and
>> single unnamed interrupt for all 3 interrupts (e.g. old DT).
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>> v9: rebased on top of balbi/testing/next
>=20
> breaks dwc3:
>=20
> [  222.776504] dwc3 dwc3.0.auto: failed to request irq #-6 --> -22
>=20
> please test
>=20

I couldn't reproduce the failure at my end.
Could it be specific to your setup?

cheers,
-roger


--WInuaa3HUIM8US08mCwClG5Apr8GHFW5Q--

--iT8lkeTJWViCsVCLXC4S62DgtMqF9N26X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVpPWAAoJENJaa9O+djCThQQP+wXQOE/wejZI7AyD1YEq746j
5O9E3tsfMHsO1ba1EDaAlsGwDwpBj+Aw9royyZkz5BrgGgyJwleEQ9kkpyMc+KZv
EtE2/omPToYqIUXh6wVduefplVwiHK8C8vqiia06PWWphxOe5Ebjih7DnYu9SzI1
/pXaz2oghHCqInAT5wcns+mHGPoxvkRZRbZfmu40vqg/mS66X8heEH3noNdM3+Od
Mnqeu/FrymO6dwUl7gbJX1RpjjiTMpkkTvR8sm5mpsQvBOcI8Wl0PBUUnjZtE9Kq
D2YqKBKgy1ET1E5UCU1uVEaDim5n8LcgX8PiCe/UNgXxzdwC96SUlT/pP32DaCxY
0LT4/MV26XHo/0pro895Dodz6SV9Eykat5FqrgO9JveYcClG2uviLWQUvLDaSMI/
52bcl2yPk3vmlpm0RRzc9z+0vmTcahdNL46AfTbu+Pamlqxk11bYXs3VxyuVVbJA
p9+7WcIvHO2Oyq5idQ4360tn9Cu47ZV5wIqIIkZ6v1iYrEPYyC1XusbaGG8TxkLy
VmccIeDispUE/mcklPgkf9KcY1wVRgSUu3sojZMSFBdixDZFsajL4waqYI9heMCz
yEOWY5JPIDgGNxgjaCA7wFdxLi+7NkrRYW1++b/O9YmbzldUvh4W3RyZqvwsFpXi
fd6g4VXNbF3tNByfPF4G
=y9ru
-----END PGP SIGNATURE-----

--iT8lkeTJWViCsVCLXC4S62DgtMqF9N26X--
