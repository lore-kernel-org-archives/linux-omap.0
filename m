From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Mon, 22 Apr 2013 11:32:19 +0300
Message-ID: <5174F593.20705@ti.com>
References: <20130418033936.GC10155@atomide.com> <20130419184518.GA30836@quad.lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA3D0A9C117BF4CF5345B430A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48374 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab3DVIce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Apr 2013 04:32:34 -0400
In-Reply-To: <20130419184518.GA30836@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enigA3D0A9C117BF4CF5345B430A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-19 21:45, Olof Johansson wrote:
> Hi,
>=20
> On Wed, Apr 17, 2013 at 08:39:37PM -0700, Tony Lindgren wrote:
>> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12=
eefa9:
>>
>>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags=
/omap-for-v3.10/dss-signed
>=20
>=20
> Merged, but not happy about it.

Thanks.

> As mentioned on IRC, I was going to let this one be until 3.11, but it =
sounds
> like it will cause regressions in DSS if we don't merge it.

Yes, that's true. The branch has been unchanged and in linux-next, so
merging it late shouldn't cause any bigger issues. But I understand it's
quite late, and I should've pushed the branch forward much earlier.
Sorry about that.

> This is an indication that the work wasn't done right on the DSS rework=
=2E
> Ideally the old configurations through platform_data should have been l=
eft in
> for a release to give the boards a window to convert over without regre=
ssing
> functionality. Tomi, please don't do it this way in the future since it=
's
> painful for everybody to deal with.

I've been trying to keep everything working even if parts of the whole
series go through different trees. I've been very strict on that things
must compile, but keeping display working if only half of the series is
merged is rather difficult at times.

For this series, I think it could've been done, but it would have
required adding hacks, or some kind of "bool new_pdata" fields so that
the driver understand what to do. And duplicate code to manage the
different platform data versions.

In the near future we'll get rid of the current custom omapdss panel
device, and use the standard platform/i2c/etc devices for the panel. The
only way to do that while keeping everything running is to clone the
panel drivers, one handling the old one and the other handling the new on=
e.

All this makes me spend lots of time doing extra work, that in no way
improves the driver. Its only for the purpose of getting arch changes
through one tree, and driver changes through the other. And this makes
the patches much more difficult to follow, as the related changes are in
separate series, and there may be extra crud just to handle this separati=
on.

So while I think it is a good habit to push the arch changes and driver
changes separately, my question is, should that rule be followed to the
extreme? Can I just keep all the changes in one branch if separating the
arch and driver changes would end up with cloning files or lots of extra
code?

Of course, I don't know what DRM maintainer thinks of merging arch
changes through his tree, so that's also open.

 Tomi



--------------enigA3D0A9C117BF4CF5345B430A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRdPWXAAoJEPo9qoy8lh71vZMP/223NQi2oiTWNiMcwJHyieYi
Ns4X/keH1uQos3lOH+AkA4yC7725ZfdbKDRyiTBnVfadB3OsgKi94VvLnJ+xPfbq
1p59zzVXa9dcPN66KMwHt5W/Z5FAsBbu+tQTWPeG+8rinvnj/F8XEQPp9xrOuhSs
JPcGwt2ix5H1dU3gC0SrM3bCQFaHkqfhEpu2H9sy4JbhfKKS1nVKIKXOvGyy39BX
n3ud10GDzgzVYmwtG9UqXNCNsAo49yIjY0NEVnxZrPi9lY0bxJ4M3oZ1896VaJE5
b4wXh9CXnO/o73B2PHcQKtH0QjA2Ca4n9OFpaLguZboo6XGtVOUoOEq3jxy8DAVl
+KGlQubgYc0ANDegLFez3PO5CPXX8QT3ASCwdq/2ZM592Eii14CRehgsm63tHDBR
i3YTuKQhM+ZauaBE10YEJgidP9rNkXcyD4FjrnJsmOQ0SMz9HHbQ9uoBedzzy24O
siN/erGHbXYHoqdj73Y7IHG5tH3TkAib4knDtvzRijVbF9UWCpJXfnkoC9cQ2Nyr
uNDws/zouMpTTBlf0JRqNPMyuH++1sbf3tVkJmC+Q2xODddbSiAdNWybY0C5rhvI
zDro2pue9YLbLsnR5Xkc4MS+zf1oYS5chSW9XKiSTBXK7UxwJiLrcBmMW8Jl7vQJ
vVAy2GlUwkeylpn7ctba
=m2C/
-----END PGP SIGNATURE-----

--------------enigA3D0A9C117BF4CF5345B430A--
