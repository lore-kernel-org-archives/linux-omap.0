From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 14:13:49 +0300
Message-ID: <526A526D.3010108@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3960914802311038689=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <526A4DEA.3050505@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3960914802311038689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="l54kjo22vcpI21TiX4cwHHO9cI72ljPNd"

--l54kjo22vcpI21TiX4cwHHO9cI72ljPNd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/10/13 13:54, Nishanth Menon wrote:

>>> would you not be depending on the weak IO pull done using mux to driv=
e
>>> these GPIO pins since the GPIO is not requested and held?
>>
>> Yes. Is that not enough?
>=20
> It depend on what the signal draw is and io drive strength which
> varies - original intent of weak pulls were to have a non-active
> default state which are overriden by GPIOs as needed. Else we would
> not be having strong pulls here in pads.
>=20
> Typical padmux drive strength for OMAP4460 is around 100uA, min is
> around 50uA. meanwhile as Documentation/gpio.txt generically states,
> the buffers driving at 1.8v on OMAP4460 could be around 6mA or upto
> 8mA. Again, these depend on the specific pin in discussion and Data
> manual explain is larger detail
>=20
> Lower current is fine if the switch is ok with it and risk for
> transients are reasonably safe. However, board designs generally
> assume the stronger GPIO drive strength.

Ok. Well, it definitely sounds safer to have a proper gpio pull there, th=
en.

>>> Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
>>> binding to map to the right GPIO and drive it using the GPIO module?
>>
>> Hmm, what do you mean?
>>
>> I do mux the pins to gpios, but there's nothing in the kernel that wou=
ld
>> use those gpios. That's why we had the hack above, but I'd love to get=

>> rid of it.
>>
>> Can I set the pins to GPIO mode, and set the GPIO to high/low in the .=
dts?
>>
>> If things were perfect, we probably would have a driver for the "switc=
h"
>> part. I have no idea what kind of driver that would be, though, so at
>> the moment we've just gone with the use-LCD2-by-default route.
>=20
> I meant you could, in theory provide the gpio numbers and pull
> directions in dts and allow the init to drive them as needed.
>=20
> Something like:
> drivers/i2c/busses/i2c-gpio.c as a reference and use
> of_get_named_gpio/of_get_gpio to pick themup..

I'm still not quite following... What init are you referring to?

The problem here is that the gpios don't really belong to anyone in the
kernel, as we don't have a driver for the switch.

Or did you mean that we'd still have the code in dss-common.c, but just
get the gpio numbers from the .dts instead? That makes sense, although
I'd want to get rid of that code altogether.

Should we have support in the gpio-controller to define default values
for gpios? I don't think we can rely on the boot loader to set things
correctly.

 Tomi



--l54kjo22vcpI21TiX4cwHHO9cI72ljPNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSalJtAAoJEPo9qoy8lh71lT0P/iOyXfvPILma7z/MauZLjfNs
ULBM9CjaAFvNTRXE0GSeNDBkNNkXy8/21MOyASPTT2rmkQBKGN1U8i16uol1J0Na
Fqio5NZfvuOd/xy9kUeniQ3Aagkw0dDbxs8jKuAoKZ7eKvqD1zl9MmnEnyy4Fpcp
77vUsxlj/46Ib2fZSWZECCzNTMHYd/6AAx47kxhSgsSATWcN1QB/JoaSej1YCZMq
h4x42FPfOGKMUAwkzu51gZ+apzhB0X8MGXkvhbOfmVNmCgyuxVoLQeLm5NZmhqEU
4DWkoTiazfyGFYfOFJKa1KTj0pBdTkHMsnavwFqwO5RJDd6RyvUJWxf+g1w/29qI
dcsnDms8+1BpwqraEdzk/+SfHZ6ydeF5zrpfD0zojXkk3mBI9UO2mjQm3gtjpNK8
Zg/QnnnBMy7aVpaLKbldjFGPZCJfWIqWywDgWqgAQ+zym+NnJOg2FRPL/1kEkYvK
n8OQ5OzJ2m80/NcbBSp9FUKfpTQQJKqGxhpc3t2BDsvw90RTv2bFacY8zafq8nJZ
TrcVlQowp7ZyuFkRsDEI3J8afe7mqQjksup1aZXADv8eODw8EbToQKo5UXYE/pad
4KD7CYhd8YcZIK85vC44jSyXIZI3QbEKL3bDIC9cNa+fUFH8XCE23FqrXzYC1K+U
RJOf6xjuQcTrQi4myL52
=fV3G
-----END PGP SIGNATURE-----

--l54kjo22vcpI21TiX4cwHHO9cI72ljPNd--


--===============3960914802311038689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3960914802311038689==--
