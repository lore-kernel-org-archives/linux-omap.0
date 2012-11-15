From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Thu, 15 Nov 2012 11:45:10 +0200
Message-ID: <50A4B9A6.5070806@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-4-git-send-email-ricardo.neri@ti.com> <20121114032712.GQ4415@opensource.wolfsonmicro.com> <50A3CFBD.5080903@ti.com> <20121114230848.GA4536@opensource.wolfsonmicro.com> <50A45467.6070404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig888AD119803BFAF735E6D225"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44246 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993013Ab2KOJpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 04:45:19 -0500
In-Reply-To: <50A45467.6070404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

--------------enig888AD119803BFAF735E6D225
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-15 04:33, Ricardo Neri wrote:
> Hi Mark,
>=20
> On 11/14/2012 05:08 PM, Mark Brown wrote:
>> On Wed, Nov 14, 2012 at 11:07:09AM -0600, Ricardo Neri wrote:
>>> On 11/13/2012 09:27 PM, Mark Brown wrote:
>>
>>>> Presumably this needs some other corresponding change in the resourc=
e
>>>> setup to go in simultaneously...
>>
>>> Yes, the change in the resources setup has been submitted to the
>>> OMAPDSS HDMI driver and accepted by Tomi [1].
>>
>> Don't do this.  With a change like this which must be made at the same=

>> time over multiple subsystems it is very important that you send all t=
he
>> parts of the changes together.  Otherwise there's a risk that one of
>> them won't get merged and even if they do both get merged you'll break=

>> bisection - it's clear that nobody can be testing this on Tomi's branc=
h.
>=20
> but the changes will hit linux-next at some point and they could be
> tested there, right?
>=20
> Sorry, as changes for the HDMI drivers go to several maintainers, I was=

> trying to send the relevant patches to the respective maintainers and
> avoid potential merge/rebase issues.
>=20
> Tomi has already taken the DSS changes. Perhaps, if you and Tomi agree,=

> Tomi could also take the ASoC and the arch/arm/mach-omap2 changes. This=

> way all changes come from the same tree.

Hmm, ok, I'm a bit confused here.

I though the omap_hdmi_audio device was a new thing, and thus it was ok
to add to omapdss. But now I see omap_hdmi_audio is already registered
in arch/arm/mach-omap2/devices.c, meaning the same platform device is
registered twice now. Well, with the exception of the device id, which
is -1 for the one from devices.c, and 0 for the one in omapdss.

Mark is right, this is not right. The kernel should work fine after each
patch, which means that sometimes a patch will touch multiple different
areas of kernel.

omapdss master branch is a stable branch, so I don't want to rebase it.
But I guess I can "reset" it by merging a mainline using some merge
strategy. I haven't done that before, but I guess it'll work.

Can you look at all the HDMI patches related to this hdmi-device change,
and rewrite them so that they'll keep the kernel working after each patch=
?

 Tomi



--------------enig888AD119803BFAF735E6D225
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpLmpAAoJEPo9qoy8lh71zgsP/3EERgOoBsut1QaE2JDWN+fn
+sgnoBixzCvmL1GYues+r3lDi0B6QAwZhBH9uaJA+Wcq8S0Pq0NNh0S50kCbNUIy
Mn3AzhC+JLikfAw/DJSsEssOhdoaXaUfr34o5Qagug7gLXkcETQKbFaogEmj03BZ
2m/9IU4TJAc89AQjkoprZrsX7XrUKU50TvS3QhHkRy4KjCb9hs6ZAAIjFIEfzATw
ioxzl1+hcmqhqsCz0LAybaEd7+TwvAEvubKB6fDC1esEXLCb6nFLK+nm5lvNJykZ
wBivfVlWR4WmiYFBNR3LAPFS527Q2728cxD8yjqIxmVoVCmcZNQ/0Ee4TiggzRbO
+SWygeOYc4GB/2+2RxqYMiF8BwNbp2EsRA1EJ80KqFiPWIpIUkIa+kCCQpieviO+
OV0e8FNKW3tZkCXVVliw+VrVaBj+DM5zTmlL63hwAmlud3hXVI2dsIQHC//zDtMX
N0xLeqaoESCY9XSDzHYXOPqQEzM99iTLeHa5ESUvAL9nNEANB03XMzcCJStxkjpY
L+7cJ1dFhra+ci4AbHG4X3q8DPhgi75g3ewAYFOxJXt8ImrEw4s9s9xHsme1ABDZ
iN3WWup7pdvjNGjV0jc3208wBaQngpMUXHxFmDRgo3GGPyBFurzBel0bUTu08x0P
JLRPiD3KV/ADQZrwnFWN
=q2CZ
-----END PGP SIGNATURE-----

--------------enig888AD119803BFAF735E6D225--
