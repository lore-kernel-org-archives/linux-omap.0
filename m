From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 12:59:08 +0200
Message-ID: <511CC37C.3020706@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com> <511CB1B3.80605@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC85C62F852EEAF099E9921BA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32904 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750Ab3BNK7O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 05:59:14 -0500
In-Reply-To: <511CB1B3.80605@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enigC85C62F852EEAF099E9921BA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-14 11:43, Igor Grinberg wrote:

>> True, it's generic, but does it work reliably? The panel hardware is n=
ow
>> partly handled in the backlight driver, and partly in the omap's panel=

>> driver (and wherever on other platforms).
>=20
> It works reliably on other platforms, but not on OMAP - because
> we need to cope with the OMAP specific framework...

How do you handle the gpios on other platform? Those are the ones
causing the issues here, right?

Or is there something else with OMAP DSS that you need to specifically
cope with?

>> Thinking about it, if you do move the gpio handling to the backlight
>> driver, the panel driver will only handle the DPI video stream. Then i=
t
>> should not have any effect on the SPI side (presuming the panel doesn'=
t
>> use the pixel clock as func clock), although there's probably still
>> possibility for display artifacts on enable and disable, if the order =
of
>> operations goes the wrong way.
>=20
> Yep, again, that is correct.

It's correct that there may be artifacts? How do you manage the ordering
of the operations on other platforms?

>>> And since the toppoly was and is used on other systems, why the hell
>>> should anyone duplicate the driver just to please the OMAP specific
>>> panel framework? The real problem is that this framework should not b=
e
>=20
>> Not to please. To make it reliable.
>=20
> Well, there are multiple ways to make it reliable.
> And I don't think that the best would be: make it OMAP specific.

I'm not saying it's the best option. I'm saying it's a realistic option
to get it working.

>> Well, if duplicating the code gives us reliable drivers, versus
>> unreliable without duplicating, then... I don't see it as that bad.
>=20
> Hmmm... I don't think this fits the mainline (upstream) philosophy.
> This can be also extrapolated into: let's make our own Linux ARM fork
> so it will be more reliable...
> This is the way how vendor specific kernel releases work.

Well, we are talking about a smallish driver here. Not an arch fork. If
the options are a) platform specific driver that works, or b) generic
driver that's not reliable, or c) no driver at all, I can't really see
why a) would be such a horrible option for the time being.

But this discussion is getting a bit out of hand. It sounds to me that
for this panel in question we can manage with the current approach, so
this whole line of discussion doesn't matter for this specific problem.

>> If it was easy, somebody would've done it.
>=20
> In fact this is done all the time on multiple drivers and frameworks.
> Also, I don't say this is easy, but I also don't think this too hard.
> It is also a function of resources (time/will/experience/etc.).

I think the CDF discussions have already proven that it is quite hard.
But feel free to contribute.

And I've talked about a common display framework already years ago, and
I've tried to design OMAP DSS panels from start in such a way that they
try to depend on OMAP DSS features as little as possible, to make it
easier to generalize them. Just to prove I'm not indifferent about the
issue =3D).

 Tomi


--------------enigC85C62F852EEAF099E9921BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHMN8AAoJEPo9qoy8lh71MHgP/RzZjm1Mah3ltXnJeZk7KqpM
jprQBkCyySBBZikSrbLy+CqQ39poaf6B45TnxpNsmdfVy3J62nL9nLj3HRrp/Mos
XObQreAhHYs+lxyxzD0Si7Ulyu6FdN0G8vXLW+PTFwXaAe2n/u9TlJmiJ/hAgCd8
JFPjw2KYc0TSPZRFG+sOROPRLJVdEFr9r0MTsiFTBvWK2vRxCt5GFnRGPNBGdq3a
+jCpbC49y+Xow4g6YM2G20V3E5FNARbSoaJyA0rMgdWKhHresIaaLB+o7PyEkKSc
1ah1np+b/4YcFYI59TFXflRQrIpmpWzvrV0QJm7kck/Eabw58+/YjM4qL2COXerI
LgNRC+kQgFZBuuhIfx6YV8xpUKD0DX6P+2N99wrq7nIpIgw/xwl7F6tjm0p6MhGg
W78rH2HRvChEISj1adShuOGgZ9oVkgWNgdnsA4b+hjsBoEKkfi186E72AoKx1liO
g5TKqBUwYQdgQIUwvJHus/SuqH654oHeHSw1Wh3oLNdwS9Q1FACGe8gKlC7j6+ZQ
HUcK7UspO/OSTYqHTRRulzk/qfyQ/p6wYE+0cK5rHaKVyvXXp8qq9ruJc4TtB0Ul
rqsVEihblMTt4WN56AwCuPJ7+uMi73yEFI6VeYnUOuOM6dWHXSFAABfkbbkVIKQY
7zqbRUHRZCoDbTO8ED6f
=wQ17
-----END PGP SIGNATURE-----

--------------enigC85C62F852EEAF099E9921BA--
