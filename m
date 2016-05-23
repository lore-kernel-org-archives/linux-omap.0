From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Mon, 23 May 2016 15:18:08 +0200
Message-ID: <20160523131808.GN23704@pengutronix.de>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160522102606.GB23704@pengutronix.de>
 <5742E710.9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5742E710.9-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Timo Teras <timo.teras-X3B1VOXEql0@public.gmane.org>, Clifton Barnes <clifton.a.barnes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap@>
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, May 23, 2016 at 04:48:40PM +0530, R, Vignesh wrote:
> On 5/22/2016 3:56 PM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
> >> There are rotary-encoders where GPIO lines reflect the actual posi=
tion
> >> of the rotary encoder dial. For example, if dial points to 9, then=
 four
> >> GPIO lines connected to the rotary encoder will read HLLH(1001b =3D=
 9).
> >> Add support for such rotary-encoder.
> >> The driver relies on rotary-encoder,absolute-encoder DT property t=
o
> >> detect such encoders.
> >> Since, GPIO IRQs are not necessary to work with
> >> such encoders, optional polling mode support is added using
> >=20
> > I don't understand this. It's necessary in the same way as with the
> > already supported devices. I.e. you want to trigger an irq when the
> > encoder is moved and then check for it's position in the handler.
> >=20
>=20
> Unlike already supported device, there is no need to count steps or
> determine the direction of rotation. Hence, IRQ is not a requirement,
> periodically polling the gpio lines is more than sufficient. With
> absolute encoder, you are able to determine the current position at a=
ny
> time just by looking at the gpio inputs.

The timing might not be that critical, but there is no reason to operat=
e
this device without irqs, is there?

> Suppose we poll device at t=3D0ms and see gpio values are LLLH(1), if=
 we
> again poll device at t=3D500ms(which is what input_poll_dev helps to =
do)
> and see that gpio values is LLHH(3), then we know that rotary encoder
> has changed to 3. This can be done w/o IRQ for absolute encoders.
>=20
> >> diff --git a/Documentation/devicetree/bindings/input/rotary-encode=
r.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> >> index 6c9f0c8a846c..9c928dbd1500 100644
> >> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> >> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> >> @@ -12,6 +12,10 @@ Optional properties:
> >>  - rotary-encoder,relative-axis: register a relative axis rather t=
han an
> >>    absolute one. Relative axis will only generate +1/-1 events on =
the input
> >>    device, hence no steps need to be passed.
> >> +- rotary-encoder,absolute-encoder: support encoders where GPIO li=
nes
> >> +  reflect the actual position of the rotary encoder dial. For exa=
mple,
> >> +  if dial points to 9, then four GPIO lines read HLLH(1001b =3D 9=
).
> >> +  In this case, rotary-encoder,steps-per-period needed not be def=
ined.
> >=20
> > IMHO this is wrong, I'd formalize this device as:
> >=20
> > 	{
> > 		compatible =3D "rotary-encoder";
> > 		gpios =3D <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
> > 		rotary-encoder,encoding =3D "binary";
> > 		rotary-encoder,steps =3D <16>;
> > 		rotary-encoder,steps-per-period =3D <16>;
>=20
> The above bindings essential means quarter_period device. I would not
> like to bother with all the logic in rotary_encoder_quarter_period_ir=
q()
> when we can know encoder->pos by directly reading state of gpio lines=
=2E

OK, we have code that is more complex than it needs to be for your
device. But your device is a special case of the supported devices, so
I'd say don't bother that there is more logic in the driver than you
need and be lucky.

> > 		rotary-encoder,rollover;
> > 	}
> >=20
> > and support this with a v4 of
> >=20
> > 	http://thread.gmane.org/gmane.linux.kernel.input/48892
> >=20
> >
>=20
> IMHO, there needs to be separate IRQ handler for absolute encoders so
> that the driver logic is greatly simplified.

As above, the added complexity can handle your case just fine. So just
use it.

One thing I see to improve is to make use of the additional GPIOs, but
this is orthogonal to the different encoding and the question if pollin=
g
is enough here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
