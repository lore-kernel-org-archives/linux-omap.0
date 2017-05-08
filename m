From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 1/2] Input: pwm-vibra: new driver
Date: Mon, 8 May 2017 20:38:52 +0200
Message-ID: <20170508183852.k7tlnglxkl7dtsfy@earth>
References: <20170505092823.26009-1-sebastian.reichel@collabora.co.uk>
 <20170505092823.26009-2-sebastian.reichel@collabora.co.uk>
 <20170508173121.v45f76tyihk2x5xq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nbawnszmv3xbfyp2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170508173121.v45f76tyihk2x5xq@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--nbawnszmv3xbfyp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, May 08, 2017 at 12:31:21PM -0500, Rob Herring wrote:
> On Fri, May 05, 2017 at 11:28:22AM +0200, Sebastian Reichel wrote:
> > Provide a simple driver for PWM controllable vibrators. It
> > will be used by Motorola Droid 4.
> >=20
> > Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> > ---
> > Changes since PATCHv1:
> >  - move driver removal code to input->close function
> >  - mark PM functions __maybe_unused and drop #ifdef CONFIG_PM_SLEEP
> >  - remove duplicate NULL check for vibrator in probe function
> >  - cancel work in suspend function
> > Changes since PATCHv2:
> >  - Add Kconfig dependency on INPUT_FF_MEMLESS
> >  - Add Tested-by from Tiny Lindgren
> > ---
> >  .../devicetree/bindings/input/pwm-vibrator.txt     |  60 ++++
> >  drivers/input/misc/Kconfig                         |  12 +
> >  drivers/input/misc/Makefile                        |   1 +
> >  drivers/input/misc/pwm-vibra.c                     | 343 +++++++++++++=
++++++++
> >  4 files changed, 416 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrato=
r.txt
> >  create mode 100644 drivers/input/misc/pwm-vibra.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b=
/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> > new file mode 100644
> > index 000000000000..c35be4691366
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> > @@ -0,0 +1,60 @@
> > +* PWM vibrator device tree bindings
> > +
> > +Registers a PWM device as vibrator.
> > +
> > +Required properties:
> > +- compatible: should be
> > +  * "pwm-vibrator"
> > +    For vibrators controlled using the PWM channel's duty cycle (highe=
r duty means
> > +    the vibrator becomes stronger).
> > +  * "motorola,mapphone-pwm-vibrator"
> > +     For vibrator found in Motorola Droid 4. This vibrator generates a=
 pulse for
> > +     every rising edge, so its controlled using a duty cycle of 50% an=
d changing
>=20
> s/its/it's/
>=20
> > +     the period time.
>=20
> What does "controlled" mean? strength? Shorter period is stronger?

well it controls pulses / second. Basically more pulses / second
result in smother vibration effect, but reduced strength.

> > +- pwm-names: Should contain "enable" and optionally "direction"
>=20
> What does direction mean? Does that apply to both compatibles.

I don't know for sure (I took over the names from stock kernel), but
I assume, that the rotation direction of the vibrator is changed.

> > +- pwms: Should contain a PWM handle for each entry in pwm-names

-- Sebastian

> > +
> > +Example from Motorola Droid 4:
> > +
> > +&omap4_pmx_core {
> > +	vibrator_direction_pin: pinmux_vibrator_direction_pin {
> > +		pinctrl-single,pins =3D <
> > +		OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1) /* dmtimer8_pwm_evt (gpio=
_27) */
> > +		>;
> > +	};
> > +
> > +	vibrator_enable_pin: pinmux_vibrator_enable_pin {
> > +		pinctrl-single,pins =3D <
> > +		OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1) /* dmtimer9_pwm_evt (gpio=
_28) */
> > +		>;
> > +	};
> > +};
> > +
> > +/ {
> > +	pwm8: dmtimer-pwm {
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&vibrator_direction_pin>;
> > +
> > +		compatible =3D "ti,omap-dmtimer-pwm";
> > +		#pwm-cells =3D <3>;
> > +		ti,timers =3D <&timer8>;
> > +		ti,clock-source =3D <0x01>;
> > +	};
> > +
> > +	pwm9: dmtimer-pwm {
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&vibrator_enable_pin>;
> > +
> > +		compatible =3D "ti,omap-dmtimer-pwm";
> > +		#pwm-cells =3D <3>;
> > +		ti,timers =3D <&timer9>;
> > +		ti,clock-source =3D <0x01>;
> > +	};
> > +
> > +	vibrator {
> > +		compatible =3D "pwm-vibrator";
> > +		pwms =3D <&pwm8 0 1000000000 0>,
> > +		       <&pwm9 0 1000000000 0>;
> > +		pwm-names =3D "enable", "direction";
> > +	};
> > +};

--nbawnszmv3xbfyp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkQuzUACgkQ2O7X88g7
+prm2hAAg2aOlFj9ZqYWjcnb838c/+W8ah/fY84RhLqNnHtu89U4Rn811mFfuvi4
pCh7uEJu7SMmFk+KsdrpuUXxEMOnis/uz9tDNmNXCRzqzc3F86O9P4mXG5hhnvaU
ZoMyjhbr6rS45amNe/mg4hmV5ziiETwOToweAI2wBwwHlepIkQv6+UdMJDA37JOY
oiFvG4jlBitiV+cL1wDfiss+grI8Rq65SvUl6S3Uvf1N5GxfzBiSSP2JtynoKycK
r55+MoXZq7fMr6f41oSiIIgY0xIXrTRsFdtZzboGYggaEUFFRBYDLMckoWWUba8Z
KdJ8QIfcS2QB1H/Tdfvk0/H1MeQ3QZcKTimC3sPga5JceaQgsejQy1zmShvINBVe
WtLERupDRw2kNOfhSLW4s/zTJ9VPbzs52Nw44GkxOyOVK/UHWQowCEoQQJVXYQ0e
Xjt5iYRCSUvksWAybDp+yY9IyZKujDd3wlfnPmbP5X9Ybt1DGdAQr1zWpaZor7kG
MGpHqcXONvTNC5pGaf7rSQ3CFLSgAMJWC6U3NWUM2N66YGzrh/5NB0gszxtXZH2b
RJqRThjWWFI65upEN5dw3HSXIW7s2hvwc1AZcJFhKojpibXGScKO3PkkWuP5AUrC
9kpqhdeDgsPYRKlaPiU+c+j20Kq0Nnth7tN1SstkXo0VGxKBq2s=
=0w1y
-----END PGP SIGNATURE-----

--nbawnszmv3xbfyp2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
