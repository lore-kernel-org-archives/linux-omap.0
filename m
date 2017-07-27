From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv2 1/2] dt-bindings: backlight: add ti-lmu-backlight
 binding
Date: Thu, 27 Jul 2017 12:29:04 +0200
Message-ID: <20170727102904.4l6atdtjsas2lhri@earth>
References: <20170717133956.20691-1-sebastian.reichel@collabora.co.uk>
 <20170717133956.20691-2-sebastian.reichel@collabora.co.uk>
 <20170724165826.3jcnrsirfqzefldj@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktyhrqn7nvqjzwlh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724165826.3jcnrsirfqzefldj@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ktyhrqn7nvqjzwlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 24, 2017 at 11:58:26AM -0500, Rob Herring wrote:
> On Mon, Jul 17, 2017 at 03:39:55PM +0200, Sebastian Reichel wrote:
> > +Required property:
> > + - compatible: Should be one of:
> > +        "ti,lm3532-backlight"
> > +        "ti,lm3631-backlight"
> > +        "ti,lm3632-backlight"
> > +        "ti,lm3633-backlight"
> > +        "ti,lm3695-backlight"
> > +        "ti,lm3697-backlight"
>=20
> Some of the parts only do backlight, so drop the "-backlight" on those.=
=20
> And having a sub-node makes no sense in that case. Perhaps it should be=
=20
> 2 binding documents separating the single function devices and MFDs. The=
=20
> binding doc(s) doesn't have to align with the driver(s). You can have 1=
=20
> driver serve 2 bindings.

Yes, there is LM3532 and LM3695, which is backlight only as far as I
can see. Your suggestion contradicts with existing binding, though:

Documentation/devicetree/bindings/mfd/ti-lmu.txt

-- Sebastian

--ktyhrqn7nvqjzwlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll5wG0ACgkQ2O7X88g7
+ppL6A//VBoz3ze7o0WsOqYtBGkJFPcs9+2tBICwTrzi1hxCDd1g0TlRQiLD8Pc8
/L/Q97nRi3qIhLbsm6Eu8f7NhA1pEFIGvEYejvD15F/BMw5RF6/Oxm2YjED715+4
Kg7ImbUx/XJMyW4udJIcGlKqE8QZXsF6wNwhWPiZuy97/N42S1DMpwdF7cFhjBUy
oZQ/mboXN8+gDK2xWj0y6ukDowY7Z+QZ5PsP4hDUxdQM6LHwrrhZ1U7diRV+W5+2
Wc9HTXcnDBUK7SK9XBnP4Fhg99HvzInuizhBofmvqh0RGx5Usn3S7vuuLlnNZD0X
PMKnDmqy6a2qJKtejTVaVOCNCVIPoS6N46rlnxuZ4TvwkHFFsusZW543gNagFkjs
FpHona2+m1YYizxidjzHL7G0EbkNA0ghYMYj0OFl8jtGshXcDdonW8NC150vUgwV
g8Xt0Fwer7GNsLGM1ECtCVcPoHXH4t++09uKkxMGu1Z9xNN2kyAYwg/NDkHJTFLg
7DUhzM42izWnO0MbqDJfUQ9h6jeLVGyZdYU8ruukIcMgcV8P0dsGXIGraqJzQ+UX
6rhn8j/MxKx1po1ts+regAeqxJ1wfecyE5syZ9mHEBZ1xOS18r76WHbSje3iAFeS
IIoB8Avxs3CtioyEEvL0tc5QZR891dP6VGzQG8JJhvmCWL/SXX4=
=8N4p
-----END PGP SIGNATURE-----

--ktyhrqn7nvqjzwlh--
