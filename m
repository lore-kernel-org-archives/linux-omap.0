From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Thu, 31 May 2012 10:00:21 +0300
Message-ID: <4FC71705.80704@ti.com>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com>  <4FC704A4.2050806@bitmer.com> <1338445869.1864.3.camel@lappyti> <4FC712D3.50103@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0E171871E0A5BCBDEB380D0F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:34328 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750742Ab2EaHAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 03:00:31 -0400
Received: by lbbgm6 with SMTP id gm6so672962lbb.5
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 00:00:24 -0700 (PDT)
In-Reply-To: <4FC712D3.50103@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, Xiao Jiang <jgq516@gmail.com>, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E171871E0A5BCBDEB380D0F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2012 09:42 AM, Jarkko Nikula wrote:
> On 05/31/2012 09:31 AM, Tomi Valkeinen wrote:
>> It's true that there's a commit range where the asoc stuff doesn't
>> compile, and I agree that it's not good. But you need to explicitly
>> enable the HDMI ASOC support to get the error.
>>
> You can still hit the build breakage by randconfig or if it's enabled b=
y
> default in the future and you start bisecting with that config old kern=
el.

That's true.

>>> It's quite boring to try to bisect over multiple kernel versions and
>>> where most of the time goes solving random unrelated build breakages.=

>>
>> How to get arm/arm/, omapdss, omapdrm and asoc driver changes in at th=
e
>> same time? All go through various different trees and maintainers. I
>> haven't found a solution for this. If you have good ideas, please shar=
e
>> =3D).
>>
> One simple - wait for next merge window. It's not that long. Only ~3
> months and meanwhile one could keep boss/customer/wife/whatever
> satisfied by carrying patches in own tree :-)

Well... I'm not sure how serious you are here =3D).

In some cases that's doable, and we've done it, for example omapdrm had
some things delayed until next merge window, so it's definitely an option=
=2E

But it's quite easy to get some build dependencies between pull
requests, so we'd be delaying features all the time. And sometimes even
cross dependencies. In the worst case it could end up with delaying some
features for a year to get all single pieces in bit by bit.

Something I think we could try to do is create some kinds of temporary
dummy functions or such which allow the compilation, but of course makes
the component not (fully) functional. The temp functions could then be
removed in -rc2 or so, when the dependencies are all there. But doesn't
feel like an optimal solution either...

 Tomi


--------------enig0E171871E0A5BCBDEB380D0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPxxcFAAoJEPo9qoy8lh71IB4QAJP+x3AJ9I47Ebt8cmP41Yvc
3/UgQWkTaSIeD4KtRKjXEUREqTQnzeteO6CIXODkvtKEBvEQlq8SpVsH91ibGJot
LzbuytucKfl6P9W+sezJ9w3qrUpi0YZ33JJGbp+0mU34qBM0TWpdyWGBHUcsDQg6
TUc+8ZE1UUv68yFSbbbfegjIVWf/b7QKTHQfANrBDWGhh+vC2Gnw4BaAbTNfRKgX
v4zUQNQ6bU8ArBZ+55m1KIkJDQpNxcctuxeekUgD+MkCPDFoMbEqbBCD2ZLPSnyG
WmoRGxiMGahyxOsWTbf1x1nezfAG39sP2sGgPsyqdgOpzfffFC62lfzmkttamOTV
yee+/DL1vxy7NYkzXAvjwV3Flf0dmkKYiSa0jlmQ7EkXjcDKSGBm8lfrWo31g+hQ
64hzHKmjE3YYkUIV5kDIECJCDZgtorg+36IWNjDw28eycEw/HDN0C2MziKlEngqx
r4NtxAMmA+It0OCPNTZnxZhhxJXmc/gKIE9vDSGRzFSbpEi/XM+qxkR6atprmqns
VAGjOJsKjKiczc9La/sK0OMcyKsec+FzAlE9V7bQFuE5riI38RpNZs4abGAAXt93
7JzTXwtHVXaIWdhpaO4nB1DSuLFWBa1AOA9wlMENHBd8CBKzB4eEAQ+45AUUd1Tk
okDVq8zY0BxWPNZ9p0UO
=nGKK
-----END PGP SIGNATURE-----

--------------enig0E171871E0A5BCBDEB380D0F--
