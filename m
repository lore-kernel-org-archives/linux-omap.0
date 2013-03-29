From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Fri, 29 Mar 2013 06:27:45 +0200
Message-ID: <51551841.9070704@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com> <51546B2C.2030101@compulab.co.il> <20130328165336.GW10155@atomide.com> <515479F6.9090005@ti.com> <20130328212837.GY10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig393B913913493ABD640B7E6D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab3C2E1y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Mar 2013 00:27:54 -0400
In-Reply-To: <20130328212837.GY10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

--------------enig393B913913493ABD640B7E6D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-28 23:28, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130328 10:16]:
>> On 2013-03-28 18:53, Tony Lindgren wrote:
>>>
>>> Yes that's not nice from usability point of view. Can we still switch=

>>> between LCD and DVI during the runtime? I thought the issue was regis=
tering
>>> multiple LCD panels where only one can exist at a time?
>>
>> I guess I could've been more verbose in my descriptions. And I agree
>> this is not a nice change.
>>
>> No, we can't switch between the LCD and DVI. But that's not strictly D=
SS
>> issue. The selection between LCD and DVI (or any other displays on the=

>> same bus) are board specific things, sometimes requiring board specifi=
c
>> gpios or even things like i2c commands to muxes.
>>
>> It works now because we have custom callbacks in the board files to do=

>> those things, but it'll break with DT.
>=20
> Well people are already used to changing between LCD and DVI.. So we
> need some way of doing it with DT also.
>=20
> How do you plan to change between LCD and DVI with DT? By using some
> custom driver modules?

I don't know, but I guess we need board specific drivers.

Do you know if there are other similar cases for other busses? I mean, I
think this is a similar case than, say, having two i2c devices with the
same i2c-id on the same bus. Only one of the devices can be enabled, the
other must be disconnected. And how the connect/disconnect is made is
board specific.

> There's the capebus coming that can be used for that too, but in most
> cases all the hardware is permanently connected with LCD and DVI. So
> sounds like capebus should only be needed for the add on boards.

True.

Well, depends on how you look at it. From one point of view there's no
real difference whether the disabled device is physically on the board
or not, as it has to be disconnected. The details depend on the bus, but
for example for DSI I think the disabled device has to be totally
removed from the DSI bus with some mux or such.

But, from the other point of view, the devices are there, on the board,
and in some cases the HW has been designed to support switching the
displays during runtime.

So what I wish is that I could make the linux device for the display to
be removed when it's disabled. I believe that can be done, but I guess
it requires a board specific driver, with some custom user interface to
do that.

And it would be different user interface than currently, which is again
not so nice. Currently the devices are always there, with their sysfs
files, and those sysfs files are used to enable/disable the devices. If
the device is removed, the sysfs files get removed also...

But I would really like to get rid of the current model, which I think
was a very bad design decision.

 Tomi



--------------enig393B913913493ABD640B7E6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRVRhGAAoJEPo9qoy8lh714fEQAIH7eKKLhOZpZK+6238ohUNc
M2Qswv4Bha+sjOMjFE4r7GePUEvzjt9EOgxtjYGM8+JnIwV2+dTljFRvEsim6Qfr
qU8NhoMU6d41w32KLzxLNJLipPQVFdK+Jy+e5X/9kIUFxlwf1dEAWE1tr241ta1r
bH4+9846rPpfx+41IighQ24Dh0P4oFsaxUrvpRrayoPOsKG6VKfcxbOr/YEAc10A
Dd3jD2FQQzOgmMgRtRtwflgEGJMqzrV9+GgYV8XdHB+ktymu9i/wz6px6bTyZOfF
fCi+a1kMUTqsMi5LpDbJO7LIOPth/8f5f173x2aEgWolrJV6JYUpOlT90JO0BEt7
p78/cNPf7ysPyFsFGs04CSeRZpjBaH26QkfLg1PoDrzUDgu6GQBjKWYvucMHsYTC
ft9PWLZOqOeSYxlFEAVvXdjVmKd7iepWqQulKlJp33xsuuC8cng3DIRms/H7jOma
LTHWfrZQD8eyOcABO6YC+zrccVgB1ceQbUT1GWCXOpXtOrkSSBK6DszRTVdUvGXU
K9FEmW08ry8WIBnXQzW7ptLOb257X/3jh8Du5yWx2wpiGU3eULD0CdSYQJHx+RbU
b4H5Z7pRvuIwAvwbmW0F1U2EV0qtQqOydddPw0WV/rRQZvOA2wLW9HzTkoByiRIl
UwiUr5sarodYxeXow7ZH
=7V0N
-----END PGP SIGNATURE-----

--------------enig393B913913493ABD640B7E6D--
