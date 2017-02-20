From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 21:20:20 +0100
Message-ID: <49742A64-7392-4DEB-898E-F8EBCC72317C@goldelico.com>
References: <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com> <20170219221930.GA1568@amd> <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com> <20170220192933.GA23745@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_28AF0B62-F4B0-4262-8F9D-40CF710C821B"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170220192933.GA23745@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_28AF0B62-F4B0-4262-8F9D-40CF710C821B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

HI Pavel,

> Am 20.02.2017 um 20:29 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
>=20
> Hi!
>=20
>> As long as it is small (I expect <1.01 =3D 1% error in scale) it is
>> barely noticeable.
>>=20
>> Therefore, I asked before: how big in pixels is your finger or =
stylus?
>> Does this effect matter?
>=20
> If I draw a line in gimp, I don't expect it to have steps because of
> "barely noticeable" errors.

You can't draw a line with exactly 1 pixel distance on such a touch =
screen.

>=20
>> A resistive touch is a man-machine-interface where people press =
buttons of at
>> least 12x12 pixels size (or they are no longer visually =
recognizable).
>=20
> Resistive touch is used for drawing, too.

Yes, for taking handwritten notes but not for high-precision graphics =
design.
For that you take a bigger screen and zoom the relevant areas.

>=20
>> So the discussion boils down to "what gives the better usability?":
>> a) getting rid of the nasty user-space calibration step (and plethora =
of different tools)
>> b) getting highest theoretical precision which has a low practical =
relevance
>>=20
>> I am in favor of a). Like most users we ask. A minority is in favor =
of b).
>> Since we don't exclude b) users from reconfiguring their system to =
get it done
>> as they like. I think this is the best we can achieve.
>=20
> Do you even read what I wrote?
>=20
> Because I presented way to have both a) _and_ b).

I am not aware that you did this. You made a proposal for the X system =
but not
for others, e.g. Replicant.

>=20
>>>>> No. You have to design interface such that they _can_ be improved, =
and
>>>>> what you propose does not work that way.
>>>>=20
>>>> It works. Please do real world tests...
>>>=20
>>> You do a real world test on N900, and propose upgrade path.
>>=20
>> I have no N900 running. But since it uses a tsc2004/5 controller =
which seems
>> to be quite similar, you can likely copy&paste some code or add the =
algorithm:
>>=20
>> ABS_X =3D (touchscreen-size-x * (adc_x - adc_min_x)) / (adc_max_x - =
adc_min_x)
>>=20
>> Thats it.
>>=20
>> If you set touchscreen-size-x =3D (adc_max_x - adc_min_x) you get =
maximum precision
>> you can achieve with integer arithmetic. And if you set adc_min_x =3D =
0 your
>> user-space gets what it would have got before adding such a formula =
and then you
>> can and must do calibration there.
>>=20
>> Taking this as the defaults if none of the new properties is =
specified, makes
>> the scaling feature completely disappear. And I don't care about 2 =
additional
>> subtractions, one multiplication and one division per axis.
>>=20
>> So the upgrade path is:
>> 1. introduce new optional properties, parse and store them in the =
struct
>> 2. set defaults for the optional properties as described above
>> 3. add the formula to the code (1 line for each axis)
>> 4. deploy - nobody will notice
>=20
> Good so far.

Ok!

>=20
>> 5. update the DT and remove user-space calibration - people will be =
happy
>>   that they do not have to calibrate first any more
>=20
> You can't do this. And this is fatal problem with your proposal.

>=20
> If I update the DT in the kernel, my users will be very unhappy,
> because their screens will now be miscalibrated.

If you tell them that they should recalibrate once, after they upgrade
to Linux 4.12 because they no longer need it I doubt they will not be =
very
unhappy.

And as said I do not expect or force you to take step 5 for the N900 =
touch
screen. Not even step 1.

I would take this more sensitive if you would use the same chip.

> New kernel must not
> force users to update their userland at the same time.

Yes, it shouldn't. But to be honest, this is not my experience. I have =
to
tweak userland a little almost every time a new kernel merge window is =
done.
Admittedly not in the input system. And I may be using the wrong =
distribution.

But if you ever want to deploy better features it is really difficult to =
avoid.

Nevertheless, what problem do you have to implement steps 1-4 in kernel
and step 5 outside?

BR and thanks,
Nikolaus


--Apple-Mail=_28AF0B62-F4B0-4262-8F9D-40CF710C821B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq0+FAAoJEIl79TGLgAm648oP/3tar4MTnmH4NtOttrH4m7+2
x7ADuwCv+TXmbcvNFQ+a3hVUvmFlOkkLrpkBUijRbV40rRCn/HiBeDbdsQ6N+z0p
jl3mDrDAwo76Po8JoijmwJAzLBkSKtkkmSmZK+KN98JDSLVyNmsTugzZLJHTTIEW
yJdQsA2+uTrqqLTUpXenVTfpM6p9eytQ1BBut4FuevcIgDbnnu9l8cwkpn7vAJvJ
a66KjwFiC8T1g7gD08YhCnsBNwgoCpb7fY9luzv1IP4hLhJ3iPl3ErA180Zphtgd
82MskhquCUQx+ghZTkzTqX2XKN+18bdKs5gBPPE7oKrxemtvRuP5VJs6qqsb+bMK
XX5m7ucVE/sBCGwKGjZ+4JBK6qXJSbb1VKRaZ3IQS1q523wTyMPbA/xQ6dMP2EvC
1NEjleJMLRN9b5A0vqvKQbHI59054w0NKFLwierAKKxyrZzDu+4eGRhcVZSVcpb0
VPeTCRonukpLGFhEgpg7mwzOOrqkDnByDFSKqeDCtx4sc2+o9fUbtmBb14EFitQw
ge6lCsMSdTuQnT1uUT1/coH/0BxNSh6xqKFJSwQKeWwe2qrfPe084FhksXVkYQ98
Y9oE4Re3rzZNj7EfKTmkr1AyId7aNfNtYP9VCAWGPKDzGgT00AGO0eiVG94w3gBI
BnB/olupPH10W8s0LUOc
=gYKJ
-----END PGP SIGNATURE-----

--Apple-Mail=_28AF0B62-F4B0-4262-8F9D-40CF710C821B--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
