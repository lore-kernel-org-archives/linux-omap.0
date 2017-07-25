From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 1/3] dt-bindings: input: add pwm-vibrator
Date: Tue, 25 Jul 2017 10:59:49 +0200
Message-ID: <20170725085949.2v3b373p5xkje47a@earth>
References: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
 <20170714100151.31234-2-sebastian.reichel@collabora.co.uk>
 <20170724192017.GE32425@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj2fo7nfy4g724kh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724192017.GE32425@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--gj2fo7nfy4g724kh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 24, 2017 at 09:20:17PM +0200, Pavel Machek wrote:
> On Fri 2017-07-14 12:01:49, Sebastian Reichel wrote:
> > Add DT binding document for PWM controlled vibrator devices.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> > index 000000000000..09145d18491d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> > @@ -0,0 +1,66 @@
> > +* PWM vibrator device tree bindings
> > +
> > +Registers a PWM device as vibrator. It is expected, that the vibrator's
> > +strength increases based on the duty cycle of the enable PWM channel
> > +(100% duty cycle meaning strongest vibration, 0% meaning no vibration).
> > +
> > +The binding supports an optional direction PWM channel, that can be
> > +driven at fixed duty cycle. If available this is can be used to increa=
se
> > +the vibration effect of some devices.
>=20
> Actually what "direction" does would be nice to explain, because I
> don't know. Does it make the motor turn the other way around?

Yes, at least that's how I understand it. IIUIC this will increase
the imbalance effect and thus the vibration.

> > +Required properties:
> > +- compatible: should contain "pwm-vibrator"
>=20
> should->Should.
>
> > +- pwm-names: Should contain "enable" and optionally "direction"
> > +- pwms: Should contain a PWM handle for each entry in pwm-names
> > +
> > +Optional properties:
> > +- vcc-supply: Phandle for the regulator supplying power
> > +- direction-duty-cycle-ns: Duty cycle of the direction PWM channel in
> > +                           nanoseconds, defaults to 50% of the channel=
's
> > +			   period.
>=20
> Is nanoseconds right unit here? It drives a motor...

Yes, for the driving the motor the values will be very big
and we could use milliseconds. But the PWM specifier [0] uses
nanoseconds for the period and I think period and duty cycle
should be described in the same scale.

[0] Documentation/devicetree/bindings/pwm/pwm.txt

-- Sebastian

--gj2fo7nfy4g724kh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3CIIACgkQ2O7X88g7
+poeDg//efMooQSkEg59ZZ2bwL3s1NuVIbz/TNcA8qYzqOIycTh5ZAEaU6HNprlE
SD1JAzj/VpTcV3bpZG85jghmYVdFMxMZWBHQCo29A5A5k+0BFF9BU8nOIHth44aa
Yb5iee0sf45Ye5DqVJrdmQLFGN9ykQTuHZdw0rebOCOfiuUq6cer2Doiq93pHPk0
HeFrvOn1pe2ExQkxWKO5w4pdKpAsFMmkmaPKzvf0JtbZ66ebpQM9u2GzTZlfr6Wg
Cf0qEGRMj7W63LQ9PhpnZNSQXMOV1uvP9rBGLNPKDqLnVAQAvGy5drC88KZ3PXWA
reltaAgX3xdwb4SFz3RU5Oa/keWadu9Ok03Xj8fPsijLVT/W789d/GjQ2suCu2iV
SXQ7+vY9KOGeJyFSNo/8XRZTEm+Xnm1tLK0tRs09BcNIXjM5uyyG2MgpJ2reTcFg
b15iOgOlDmMGXr/fdTkql/6Y4aeLj741yxgBCv5saU4/l3A09qlyRtzyu4qi+3Wi
igeWvo07e6aNLZ1OOpykpKELNjfDpkOuN9kXCoxZKPluNspst6/k/931V6KRlZ9h
y1ZUpF0IBJilhautAn4csNQgmvDf+H1bZ/ykXonFHdQiDwqBLJD3soIRFohIyMV3
teTXijvdXRX3qqcKpFS/+ydDmzpJLUAlCkJ8b9IcaHmp8vcdhBw=
=FHp6
-----END PGP SIGNATURE-----

--gj2fo7nfy4g724kh--
