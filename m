From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
Date: Fri, 2 Aug 2013 17:22:56 +0300
Message-ID: <51FBC0C0.2060207@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com> <51FBAC21.2040609@ti.com> <51FBAD64.5090600@ti.com> <51FBB461.7010209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BFfMxPopW4FMOqALAHjvEn4TCOgnuEASw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43666 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481Ab3HBOXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 10:23:22 -0400
In-Reply-To: <51FBB461.7010209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--BFfMxPopW4FMOqALAHjvEn4TCOgnuEASw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/08/13 16:30, Nishanth Menon wrote:
> On 08/02/2013 08:00 AM, Tomi Valkeinen wrote:

>> Feel free to help me develop the DT support for DSS =3D). When that's
>> done, we can remove all this code.
>=20
> suggesting here - but it will be nice we have some steps towards this
> direction - is there anything you'd suggest we do first?

I do have a DSS-DT branch, which works. I've had such a branch for
almost a year, although I've been refining it all the time. But I'm
still not happy with the DT bindings I have there, and I haven't had any
clear ideas how to solve those issues. And, as the DT bindings are an
external API, I've been very cautious with it.

I'm currently cleaning the branch up, and I hope I can send the series
next week. Hopefully I'll receive some ideas for the problematic parts.
I'll cc you =3D).

>>> Example: if -EPROBEDEFER is incurred due to some unexpected dependenc=
y,
>>> we'd have to redo the numbering in the kernel yet again.
>>
>> Hmm, sorry? Do you mean that the i2c bus numbers can change "randomly"=
?
>>
>> With board files they were numbered 1, 2, 3, 4, but with DT boot they
>> seem to be 0, 1, 2, 3. And as we have the current situation where omap=
4
>> boots with DT, but DSS does not have DT support, we add the DSS relate=
d
>> devices in a board-file-like-fashion.
>=20
> Aah we are then depending on the following
> i2c-omap.c:
>  adap->nr =3D pdev->id;
>  r =3D i2c_add_numbered_adapter(adap);
>=20
> mach-omapx/i2c.c:
> .. i2c_bus_register..
> pdev->id =3D bus_id
> platform_device_register(pdev);
>=20
>=20
> I dont seem to see any similar numbering enforced in dtsi - if I reorde=
r
> the i2c entries in SoC dtsi, i'd have an issue as well, no?

I don't know, but yes, possibly. But you probably won't reorder them, as
they are in the HW I2C ID module order.

> probe deferral could create problems as well.. not saying it can change=

> random order on a given kernel between boots, but am saying that when
> new changes come in, deferral mechanism ensures proper ordering
> dynamically, which kind of messes up with expected device numbers. I ha=
d
> an issue with mmc sometime back where probe deferal on mmc1 made it
> registered as second device as the dependency was not present on the mm=
c2.

Yes, interesting point. If I got you right, you're saying that if a
single i2c device gets deferred, but the others not, the ID numbering
could change?

I don't if it's possible to get only single i2c device deferred. Maybe.

Anyway, we need some way to fix this for 3.11. As far as I understand,
it's rather unlikely that the bus number would change, so I think this
fix is the best I can do.

> No reason this cannot happen on other busses as well. To solve this on
> i2c dts, the usual convention is as follows (from omap3-beagle):
> &i2c1 {
>         clock-frequency =3D <2600000>;
>=20
>         twl: twl@48 {
>                 reg =3D <0x48>;
>                 interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
>                 interrupt-parent =3D <&intc>;
>         };
> };
>=20
> this ensures that probe success order is made independent of device
> expectation of i2c bus numbering or the order in which it was defined i=
n
> dts.

With dts, this is not a problem, it's handle with phandles. Although not
as you show above, because we don't really have an i2c device on the boar=
d.

The i2c in question goes through the DVI connector to the monitor. So
the monitor is the i2c device. Thus we just get a handle to the i2c bus
going to the monitor, and send messages to it directly, without having a
linux i2c device.

 Tomi



--BFfMxPopW4FMOqALAHjvEn4TCOgnuEASw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+8DAAAoJEPo9qoy8lh71a6cQAIiuvTb/ao6EivZPgDgtozhk
iVS3xRjqeBIzRnZEZK0FExDhC9CqBvFnRy31kiKEDXhQzh8cf2N6XMEW8CkFjI2N
0XGUo0kCfkUcHIscoqC3CqROIHZ29BrhYQKDIvdyWIZTfJDbHUBcBezhlwa0csiy
FHZjvaeGYUQnRKlz6vTZQaAlKkQDYDBnhfBi6BcPNDDw8BN+PdrlcUsY0g638mXS
jpqA1pU74Ttw9czgXCj2TbnKgN/yTVMagE6E5KUxeE1H7srwtRWpTVLiKRj4VpBt
pqeJLW7CZ00BhWoiYFDtw6kM0iCC8hR9fcSwQr0zPgavFymqvVlbgLseK8UVXygo
Uhoy5BVg/LVxsecjenH7onUFc0z5+M6thYWmdvyOx/39xRZ7vJWlNHQvuIn+ZwmI
dBp3wQev9pTEOvWbmOVBsjJxFprAh8t9issRi+E9CvCbd3Hrk2t/iqYu4hOF5n61
i1dShAT6XDMxuHU2CBW0uojLm9wgzeJ1thBFCRW+1G40BixhaZybvNmTsIXNR+RA
SIBOCxDhQvv0wuBhyIRdSRmqoWaeCoF+iXkQzOhdjrkOkOmp9QqFPlavHIJltFdA
uBs85kBB5vL5J3XdZ1PJb97Qcy554N13GynRncbsAj5zyTup+7q5IFNhhrV4h7AV
xOlIATTJy+f0NhRFlhjx
=GOl7
-----END PGP SIGNATURE-----

--BFfMxPopW4FMOqALAHjvEn4TCOgnuEASw--
