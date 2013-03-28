From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Thu, 28 Mar 2013 19:12:22 +0200
Message-ID: <515479F6.9090005@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com> <51546B2C.2030101@compulab.co.il> <20130328165336.GW10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig088271AAF90D1C959C7772C8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54292 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756777Ab3C1RM0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 13:12:26 -0400
In-Reply-To: <20130328165336.GW10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

--------------enig088271AAF90D1C959C7772C8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-28 18:53, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [130328 09:13]:
>> On 03/28/13 14:49, Tomi Valkeinen wrote:
>>> Boards with multiple display options for the same video bus have all =
the
>>> possible linux display devices present at the same time. Only one of
>>> those devices should be used at a time, as the video bus cannot be
>>> shared.
>>
>> Yes, only one can be used at a time, but you can switch at runtime...
>>
>>>
>>> This model is hacky, and will be changed in the forthcoming DSS patch=
es
>>> to a model where only one display device can be present on a single
>>> video bus.
>>
>> What do you mean by "present"?
>> Is it active? or registered? or compiled in?
>>
>>>
>>> This patch creates Kconfig options to select which of the display
>>> devices is present on the board. While this model is also somewhat
>>> hacky, and prevents us from using a single kernel image for all the
>>> display options, it allows us to make the DSS driver changes for DT
>>> adaptation. And with DT, the information about display devices can be=

>>> passed from the bootloader, solving the mess.
>>
>> Hmmm, the fact that we cannot use the same binary for multiple display=
s...
>> This does not sound right and good at all...
>> While we try to move to support multiple platforms in the same binary,=
 we
>> cannot support multiple displays? I agree that the multiplatform stuff=
 is
>> not really related, but you know what I mean...
>=20
> Yes that's not nice from usability point of view. Can we still switch
> between LCD and DVI during the runtime? I thought the issue was registe=
ring
> multiple LCD panels where only one can exist at a time?

I guess I could've been more verbose in my descriptions. And I agree
this is not a nice change.

No, we can't switch between the LCD and DVI. But that's not strictly DSS
issue. The selection between LCD and DVI (or any other displays on the
same bus) are board specific things, sometimes requiring board specific
gpios or even things like i2c commands to muxes.

It works now because we have custom callbacks in the board files to do
those things, but it'll break with DT.

>> I bet there must be a much better solution for DT support.
>=20
> Well the best legacy support option would be some fbdev/panel generic c=
mdline
> option to specify which one to use. Maybe there is already something li=
ke
> that available that the board-*.c files can parse and can be used also
> later on with DT support to specify the preferred output?
>=20
> What we don't want to do is add a board specific cmdline option as the
> board-*.c files will be going away as soon as DT is usable for us and w=
e
> don't want to support a board specific cmdline after that. But if it's
> a generic option then parsing it in the board-*.c file or the driver la=
ter
> on can be supported.
>=20
> Of course for some cases it might be possible to detect the configured
> panel based on what's plugged in over i2c.

I could look at using omapdss's module parameter for this. It has
default display parameter. Perhaps the board files could parse this, and
use it to decide which display to register. Perhaps that'd cause less
inconvenience.

It's still quite hacky, as you can only select one display. If there's a
board with two video outputs, and, say, 2 displays connected to each.
You can only select the display for one of the busses. Anyway, we don't
have that kind of board in the mainline, so it's not an issue.

 Tomi



--------------enig088271AAF90D1C959C7772C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRVHn2AAoJEPo9qoy8lh718ZYP/1cTx1ZOKex8bO53Jm2JYXrH
1j2B69VmJJFhXDQxaQLrv2+cRlh8DYW2eSfIo0K1tuYIDknbtBkNjmUkiw0OlWp1
4ExIRACd5TWCkHGoJ6jfzkz/7OhAdzF5tn2Ry6j49Vy9eoGSnbzNQmQQ19Zuzmp2
xs6fmHC2FXsZqzTZvBDFJ3h3GSqe01Kl3gCsU/NNLThchVJ46MZGWtPSpn2f27hJ
Bo4yRiSKFQauzOAElGewRxX886DuF4uDwY2CHS5W+AhVTjNszM3tYEzymrfpIiaN
U3ZD1OV95ld3Gp9TAyoqzLDeIleU6PBHjdXE8c0vfFEw5sbOVGxwvW1mzvvHo7bF
8tQ4xcWU32j6JdR91lz6H4FiVLd6bOtNSEkQfgVfYUxzWqdVLxHQ228Q9ciK++00
JB29ieHy3WYQmw8LqH3bfFV5AXJPAoPmEihNGtqrZkmIZE9zkIJMxQ9G6VuKSHd7
aCrBZtzo1o9Vg1YsfIdh2xjZIs4twk6j7zTKHWJc6Zg/oEdXvYb06h5ykyC1RlMi
bodn5etlHNgdUkiiriMysg+o2AboM1kyJDdBtn7du8DhiVqymOv2KWsC+BH66mVJ
rzRWaVPXAmhXHwMCgyuasz3mYsrZb1RbrPaoWNCwpFwETVLTt0Bx1F++oCX/EHly
I35vaiUFj29Hya3Hb3gi
=xuoC
-----END PGP SIGNATURE-----

--------------enig088271AAF90D1C959C7772C8--
