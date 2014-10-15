From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Date: Wed, 15 Oct 2014 18:45:15 +0300
Message-ID: <543E968B.3030802@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com> <1413311335-25083-2-git-send-email-balbi@ti.com> <543E6683.5040103@ti.com> <20141015143849.GC10888@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="sW1N06TlJk8jnK9hQQnNi6P5DoL1QbbgR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48997 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaJOPpp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 11:45:45 -0400
In-Reply-To: <20141015143849.GC10888@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--sW1N06TlJk8jnK9hQQnNi6P5DoL1QbbgR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/10/14 17:38, Felipe Balbi wrote:
> On Wed, Oct 15, 2014 at 03:20:19PM +0300, Tomi Valkeinen wrote:
>> On 14/10/14 21:28, Felipe Balbi wrote:
>>> without MODULE_ALIAS(), omapfb won't get loaded
>>> automatically.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers=
/video/fbdev/omap2/omapfb/omapfb-main.c
>>> index 9cbf1ce..b4b9244 100644
>>> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
>>> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
>>> @@ -2651,6 +2651,7 @@ module_param_named(mirror, def_mirror, bool, 0)=
;
>>> =20
>>>  module_platform_driver(omapfb_driver);
>>> =20
>>> +MODULE_ALIAS("platform:omapfb");
>>>  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
>>>  MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
>>>  MODULE_LICENSE("GPL v2");
>>>
>>
>> Thanks, I've queued this.
>>
>> Unfortunately it's somewhat based on luck if the automatic loading wor=
ks
>> correctly. We can't add more displays after omapfb has been probed, so=

>> all the panel and encoder drivers have to be loaded before omapfb.
>>
>> We have two workarounds there, which help the situation a bit. First i=
s
>> that if omapfb finds no displays, it returns EPROBE_DEFER. The second =
is
>> that if there are displays, but no main display (display0), then omapf=
b
>> returns EPROBE_DEFER.
>>
>> So even with these workarounds it is possible that drivers for seconda=
ry
>> displays are loaded after omapfb, causing them to be ignored.
>=20
> then there is another case to fix, right ? :-)

Yes, but don't hold your breath. The issue's been there for ages and no
good solutions have been found. The same problem is there for omapdrm.

 Tomi



--sW1N06TlJk8jnK9hQQnNi6P5DoL1QbbgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPpaLAAoJEPo9qoy8lh71BVkP/2c9ekbzzTMI+UqRFEVlDA7P
OuzDajqC5cyu1Nkwk3GI/6rmpWgkOpUfZeUwjF8BKbJvLyG9tCQvF1DhI4o2lgAn
ciXWbmxlCs9kQT0ELT7vixO+12ARJHZNmomRoKdXOYecXTVP/R4apRao2fIoGLES
a7M3SKBBhRf5JvjSE9HVBr5Pkk1rXtW4OI6suRrNKhLeiZJV2Ri85v8DStFOJmJ1
X5qKuvgAA/i5bVldn2X+Vz+JRYljwkATzP9vae2jQr4TBSRjOIgAGLN9bWYHR5wL
bbiZVTrE73mm9qmpr+EEyzfoCIeEuzwkBUR+bz4MX6vpwyAqM2JBNWJUO6RKon/2
XnV8dkqXo7L9XbAJz+sAVsPhkg/B3NPYLi+d35mGKFxICU9oi7wXFsoG8LB1ryPd
YeYPcbohn+iLrczXbucOHjG/6cWL+UI3Sc3zm/ebIYwVu5Vop0XVziItm/GoHzsd
eOXxn19WCeGgL9Mx98AejoLYUQRoUFJ0+xK2d8Mil1K4rtt6NKiLzCKI2RqUSLu/
9n6CRQ9hZPhA7832rIn3PUtU131hCBZdf8YlHO/rgX23Q5VrlyJcVJ7bgI67XjfF
Q0zrXWVUKXc4FvSfyw9qxbdDI2nyUp9w/o5fnffiJRggpwro1bY+AVkAe59PyEm8
NmkVWLf062zQlpy7V4zY
=KM8U
-----END PGP SIGNATURE-----

--sW1N06TlJk8jnK9hQQnNi6P5DoL1QbbgR--
