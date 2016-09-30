From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Fri, 30 Sep 2016 16:40:19 +0200
Message-ID: <29036A28-9997-4ED6-81FE-3ABC659EEEEB@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <20160923224726.GA4639@rob-hp-laptop> <20160924003133.htaaiphjrm7vy52t@earth> <E8C59C6C-23D4-4417-8A9E-3E9AE5D2D100@goldelico.com> <20160930141603.mlo5v75oy72j64d5@earth>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_17A3A56E-D310-4AE4-B81F-E5FECC959022"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160930141603.mlo5v75oy72j64d5@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_17A3A56E-D310-4AE4-B81F-E5FECC959022
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 30.09.2016 um 16:16 schrieb Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>=20
> Hi,
>=20
> On Sat, Sep 24, 2016 at 07:55:27AM +0200, H. Nikolaus Schaller wrote:
>>> So ti,max-[xy] is basically the same as touchscreen-size-[xy],
>>=20
>> No it is not the same and should be kept separate.
>>=20
>>> except, that the generic bindings don't support min-[xy] !=3D 0.
>>=20
>> What would be the purpose of this? Every user-space I know
>> about (X11, Replicant) expects coordinates in some range
>> 0..max so setting min in device tree makes no sense to me.
>>=20
>>>=20
>>> So maybe change the generic bindings like this:
>>>=20
>>> touchscreen-min-x: minimum value reported by X axis ADC (default 0)
>>> touchscreen-max-x: maximum value reported by Y axis ADC
>>> touchscreen-min-y: minimum value reported by Y axis ADC (default 0)
>>> touchscreen-max-y: maximum value reported by Y axis ADC
>>> touchscreen-size-x: deprecated alias for touchscreen-max-x
>>> touchscreen-size-y: deprecated alias for touchscreen-max-y
>>>=20
>>=20
>> Initially I had thought about this but it does not solve the problems
>> with touch pre-calibration. Since it mixes raw coordinates with
>> system coordinates.
>=20
> touchscreen-size-x was actually refering to your definition of
> touchscreen-max-x and not system coordinates.

Ah, ok I see. It looks as if you have provided a hidden feature by =
mis-using
it to describe LCD size.

> For that it would
> make much more sense to use a phandle to the screen IMHO.

Well... phandles are evil as I have learned in different context.
And, there are many LCD devices that do not specify screen sizes in
pixels.

I would more see it as a definition like a key matrix. You still have
both, the x/y raw coordinates and the processed KEY_something codes
in a single table.

>=20
>> To achieve the goal of having a roughly precalibrated touch which
>> should provide (0,0) at the lower left corner and
>> (touchscreen-size-x,touchscreen-size-y) in pixel coordinates of
>> the panel. Hence it roughly works without a calibration matrix in
>> user space (e.g. xorg.conf or Replicant).
>=20
> well I did not mean to use touchscreen-size-x/y for describing the
> size of screen, as visible in n900.dts (first implementation of the
> common binding), which sets the value to 4096.

Well, for my scheme it still works if you use it that way. Like keycodes
which can still be mapped in user space to anything desired.

>=20
>> Why do we need pre-calibration? Because some systems might need
>> touch interaction before they can offer (force) the user into
>> a touch calibration step. We use these drivers and approach in
>> our production kernels for GTA04, OpenPandora and Pyra for a while
>> and nobody was even missing a user-space calibration tool any more.
>=20
> I have nothing against the feature. OTOH I'm quite in of kernel
> based TS calibration. Note, that you can only add it for hardware
> without pre-existing touchscreen support, since you break peoples
> systems otherwise (We have that problem for N900).

Unless it takes missing ADC values as the same defaults that have been
the assumption. I.e. if it is missing, take e.g. 0 and 4095.

>=20
>> The underlaying problem is that you can have the same controller chip
>> in different board designs and there are different touch panel types.
>> Each one has certain physical properties but they can differ.
>> But you certainly want touchscreen-size-x/y to be a constant.
>>=20
>> Now if we make touchscreen-max-x/y the same as touchscreen-size-x/y
>> and change the panel, we have to adjust user space transformation
>> each time we change the panel. This does not seem to be right
>> and can be done better by keeping them separately.
>>=20
>> This is what this approach does: the roughly correct scaling of
>> raw values to pixel values.
>>=20
>> ti,min-x   ->   0
>> ...
>> x          ->   some value between 0 and touchscreen-size-x
>>                calculated by
>> 			touchscreen-size-x * (x - min-x) / (max-x - =
min-x)
>> ...
>> ti,max-x   ->   touchscreen-size-x
>>=20
>> Hence the ti,min/max values describe the range of expected input
>> values from the ADC and the touchscreen-size-x describes the touch
>> in LCD pixels passed as input events.
>=20
> so basically you use touchscreen-size-x to describe the screen and
> not the touchscreen.

> When I added it, I did mean the max ADC value.
> Actually I was under the impression, that X drivers would scale this
> to screen size automatically.

There is some default calibration or it can be set by entries in =
xorg.conf,
but since there is no intermediate "constant" scale, you promote any =
hardware
variation (different ADC max values) to user space.

> Since all my touchscreen HW required
> calibration I did never test this, though.
>=20
>> Example:
>>=20
>> ti,min-x =3D 64
>> ti,max-x =3D 4016
>> touchscreen-size-x =3D 480
>>=20
>> If we change the panel type which presents a slightly different ADC =
range:
>>=20
>> ti,min-x =3D 100
>> ti,max-x =3D 3900
>> touchscreen-size-x =3D 480
>>=20
>> and we still get a coordinate range (0 .. 480).
>>=20
>> Note that this feature can be effectively disabled if ti,min-x=3D0 =
and
>> ti,max-x=3D4095 and touchscreen-size-x=3D4095, i.e. reports the full
>> range of ADC values because then it multiplies by 1.
>>=20
>> Our proposed driver does use these values if they are missing from DT
>> and therefore it should not break old DT files which expect raw =
values
>> to be reported.
>>=20
>> I hope this clarifies what we need to achieve and you can
>> agree.
>=20
> I did understand what you want, but I disagreed about
> using touchscreen-size-x/y for system coordinates. I
> now see, that it's too late for that, as other people
> already did so.
>=20
> I do agree with Rob, that the ti,min/max-x/y should become common,
> though. Also I would do s/minimum value/minimum raw value/g.

Yes, that is a good idea!

To me it seems as if "minimum-raw-value-x", "maximum-raw-value-y" could =
be good.

Or is the string too long (then we can drop the "-value" or the "imum")? =
It
might blow up the DTB and string constant for finding the property?

If we come to some consensus on this, I can update the patch set.

> Additionally touchscreen-size-x/y should mention, that it's used to
> scale the raw values.

Ok. It is also used as the default for maximim-raw-value-x/y if not =
specified
which means 1:1 scaling.

BR and thanks,
Nikolaus


--Apple-Mail=_17A3A56E-D310-4AE4-B81F-E5FECC959022
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX7nlVAAoJEIl79TGLgAm6p3cQAI/NS4ZMeA7mfXA3VMjG+OBD
WTgonTsy1jxUgZAvutAYA1jGLNaZgJJcEXDFIBPJUPNAGzgx3qpKfc+xoBUi0Q44
wFrioOY1EHOQLFQGbTQVEjdHig8/vf0qy66yP4uNm0hdJhpIVhsnU7Y2NFlNdmrn
lbmBErH5fhH89Zc9rgI5RlgqM5W4onPibDib2Ix0ptTJvnJlgpVgG87+8USPEhu7
hdaEQqc7LOhnqItXxyYs114gYYRdomPUsNXyXua3kElnDQcGNg6i5rLiMa4RVXd0
c1B/1eE0zK89L0x7XMPZNl9jLPZZXm8/clotfEnOeFiIT5sfUVfKjz3jAdnM1IJe
ajwXd1L9k8DBmiBmvAsD5M5JjRPzSSLPmoKUh2NHi2WsUUZk2rpwPoNvc7FFm6cl
9sAnde7zFCiVtUwQLU1RVgrRVSJdJY64UW0SAK/MutOEGULXFUgUoEPPbsuSMEb5
5wncW3BeLFiMLyVUiYe33UZx/uHiOmJXcxmC3Ktvh6oYcW4uDHoKKaB23T4VJjyy
kE9R45PNMvbyH+lQtJCJKfzNQmwUFqOX6FO1JtKbDaAmsRhn/0GMLXFOuX2Gq4SF
qE5cv0V547mq/VbYZBhb1k7Em9vy0zBV33j45fZpqC4YK1RVKG1jdtjnCpcVtmgt
1q8fYXiXw6yg3lqiuM8O
=IJkg
-----END PGP SIGNATURE-----

--Apple-Mail=_17A3A56E-D310-4AE4-B81F-E5FECC959022--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
