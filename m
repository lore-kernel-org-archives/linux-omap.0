From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Mon, 3 Jun 2013 15:20:06 +0300
Message-ID: <51AC89F6.1050308@ti.com>
References: <20130418033936.GC10155@atomide.com> <20130419184518.GA30836@quad.lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2PEUENAGRHMAVXGDVQAAE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3FCMUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 08:20:36 -0400
In-Reply-To: <20130419184518.GA30836@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

------enig2PEUENAGRHMAVXGDVQAAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/04/13 21:45, Olof Johansson wrote:
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
>=20
> As mentioned on IRC, I was going to let this one be until 3.11, but it =
sounds
> like it will cause regressions in DSS if we don't merge it.
>=20
> This is an indication that the work wasn't done right on the DSS rework=
=2E
> Ideally the old configurations through platform_data should have been l=
eft in
> for a release to give the boards a window to convert over without regre=
ssing
> functionality. Tomi, please don't do it this way in the future since it=
's
> painful for everybody to deal with.

I have a somewhat similar situation again for 3.11 (or possibly for
3.12). I hope to hear from you what you think would be the best approach.=


The background is that the omap display subsystem has a bunch of panel
drivers, and these drivers have used an OMAP DSS specific bus and driver
model. For various reasons I'm now converting the panel drivers to be
based on the panel's control bus, i.e. a panel controlled via i2c would
be an i2c device/driver, a panel not controlled at all would be a
platform device/driver, etc.

The work involves changing the omapdss driver, converting the panel
drivers to the new driver model, and changing the board files that use
the panel.

I see two main approaches to this:

1) Convert the panel drivers "in-place", i.e. have a commit which
changes a panel driver to the new model. This would mean that the
instant the commit is in, the boards using the panel do not work until
the board file has been changed.

2) Convert the panel to a new file, i.e. basically make a copy of the
panel driver while converting it. This way the boards using the old
panel drivers will continue working. (This is how I have my patches
currently organized).

Option 1) feels more natural, but if the arch and driver changes go
through separate trees, there's a piece of history during the merge
window where the displays won't work on the OMAP boards.

Option 2) allows us to keep the boards always functional if the new
panel drivers are merged in 3.11, and the board file changes are merged
in 3.12.

The downside is that it takes two kernel versions to get this in, and a
third kernel version to finally remove all the old code. 3.11 and 3.12
would contain unused code, some of which will be in the kernel image
(omapdss side changes) and some of which won't be compiled at all (the
new panel drivers).

Do you think option 2 and splitting the work into three kernel versions
is the way to go? Do you have some other ideas how to organize the merge
of these kind of changes?

 Tomi



------enig2PEUENAGRHMAVXGDVQAAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRrIn2AAoJEPo9qoy8lh71eGAQAIL9oigjhFoV9A6xQfVpHpQw
s77btPZjN3cdK4XOWVz5JiJ//lkoR0qbHEK94j9Cmc69P7y7LdjmQfnggx5g5snR
FxfH4SFG7hG9fikUUtJ5DqBtCRagFWWhZxxx1qqLfTIlZjcTXI5AS+869mHed4b2
mOwOub28VFaMAmYhkMcHKWZux8RM9bJRmiuHsQLg275/FO8+CcTJkcEUotGQJy+1
TCfyiTiQME1KTKD6swP0L2Ogb+dsK6L+2cncUjgnnBy9nlk9VhbLYNsSvm2jaFbZ
OKb9S6ZzZjx+22yK+iGdc2WWXkwUfaQPDA8gQj2mlLTSjPqjLKGz90jzHUCcbqAQ
7yz5woY+Dk4+XjgKmI/FVZXvCbGnKyfqeIliJZ0AK/l4y1yXsqdtQQkxtCTUMCMC
gr/4sR0OJJp1PqzzotTnwT0IR0Jz+k/LyZWUvM+3rX7D2D9hbbe6dQbEx3tN1TwT
xQBv0la9WfW6RGWoatVwTb4JUXFmAPzwE6+RX18bWchEPqrQKcibx4+c8OqqKuI+
N9k38UAAP/oxFLc32ppkru6BleWOgT4nEqiB5GrQraVyHocqtGQRE0/aoZhqKvut
SZnds+rCckUpeElVwVJoWm5Zbk2+Q728iEt8yWtzHkoHAct+g6sa3hGPfAqQ53dl
YBxe+1jrSfbxmNFlpZ8g
=Yzhd
-----END PGP SIGNATURE-----

------enig2PEUENAGRHMAVXGDVQAAE--
