From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Wed, 24 Apr 2013 10:56:28 +0300
Message-ID: <5177902C.5070407@ti.com>
References: <20130418033936.GC10155@atomide.com> <20130419184518.GA30836@quad.lixom.net> <5174F593.20705@ti.com> <20130423171438.GC10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17C9E4F38AE22D250E380D2A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab3DXH4j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Apr 2013 03:56:39 -0400
In-Reply-To: <20130423171438.GC10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enig17C9E4F38AE22D250E380D2A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-23 20:14, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130422 01:37]:

>> So while I think it is a good habit to push the arch changes and drive=
r
>> changes separately, my question is, should that rule be followed to th=
e
>> extreme? Can I just keep all the changes in one branch if separating t=
he
>> arch and driver changes would end up with cloning files or lots of ext=
ra
>> code?
>=20
> Shread branches are just fine. In most cases it's possible to add new
> pdata and then remove the old pdata later on with follow-up patches.

Yes, that's what I've been doing. But it's not possible in all cases,
and in some cases it's just really difficult/laborious.

I'll soon need to change the dss panel device model, and the only way I
can see that would allow us to keep everything running if only arch or
driver changes are merged, is to create a copy of all the omap display
drivers, and change the copy for the new dss device model.

And that's obviously a terrible way to do it.

So presuming I need to have the dss changes in separate arch and driver
series, and everything should run fine even if only the other half is
merged, then, well, I have no idea how to proceed. I'll continue looking
at this, but it's a bit frustrating to spend most of my time trying to
twist the code to accommodate the merging process, instead of making the
code work.

That said, this dss device model change should be a one time thing.
After it's done, these merging-problems should be greatly reduced.

>> Of course, I don't know what DRM maintainer thinks of merging arch
>> changes through his tree, so that's also open.
>=20
> No let's not go there, Linus T already complained about the conflicts
> between drivers/net and arch/arm/*omap*/ code few merge windows ago.
> We need to remove the driver dependencies to the arch/arm code, otherwi=
se
> the merging requires way too much work from multiple maintainers. That
> does not scale well and often leads into merge errors that could have
> been avoided in the first place.
>=20
> Of course the real solution here is to get things moved over to DT
> based booting and then we don't have any of these dependencies as the
> .dts changes can get merged separately from the driver changes.

It will remove compile time dependencies, but we'll still have runtime
dependencies just like we do now.

 Tomi



--------------enig17C9E4F38AE22D250E380D2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRd5AsAAoJEPo9qoy8lh71Q4MP/i2i9NhBD9wVbN+R+Jje14Sg
1avCpMnlrx4BfRjelDbN+NI2ku3gBq6pMppAQCzIi4Cd4OrBFn8pio8DCIWAk55w
MNTzpOkC+BfbQkf3YiymIcz96QwTGUZw8q3i4asVLqg0eypU9+1/Mdsws3m1Xm94
P3CpZemO6QTVxj1nxOa+Vapx+6xEUnDz1k5L+Zvdl29iG97P1pKB1MU6LNItmO6W
pg660U8UrvEhXHw2MzyYGs0W0niC0M5/R58gpH+vKmjdUVJcZ1KDi0Qm2OAhARse
xDXBVXlS/3jfw6nc8xBn3u21WGWM/SqIZMpui0uJjB/X9n62PFZKxh/aluFNgJLk
e8BuSeHtSRemJu2/C24uVZYUXo81BZzJIkNqqXwLMW6b1UxZGFiNLpZbAvS+jpdg
f9xc4M7xVDH4jcl4av7jfbduI3mbakNmjoS9WZhjDj5Z/7trPSUxV+sVam+dR2eu
H36urz0CJJh80Ljqyc9A1vNq9IturFi8mRqVTV3fxBmJkvQ9UWZ1ZDEVl6kWA7GX
55xSudgLNQxQbw8yMIStAwPwswBUaoo/ayL0nsof7iwiolg4n7/6Rk2T8MUUxWGQ
RljqUbkIZ2s27e7olKwNchG+3Ljcx60PC/vXO18qhVV7ii5YsFVxBbT2i83JltTZ
E397Sblt5V4tdInDoIL1
=jQwK
-----END PGP SIGNATURE-----

--------------enig17C9E4F38AE22D250E380D2A--
