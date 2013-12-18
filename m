From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Wed, 18 Dec 2013 18:03:11 +0200
Message-ID: <52B1C73F.40604@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218152927.GC32243@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9oJmoC0EiGVdfx9GoANlf3XqIxqpN5Tgv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38920 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab3LRQDl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 11:03:41 -0500
In-Reply-To: <20131218152927.GC32243@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--9oJmoC0EiGVdfx9GoANlf3XqIxqpN5Tgv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-18 17:29, Russell King - ARM Linux wrote:
> On Wed, Dec 18, 2013 at 03:54:42PM +0200, Tomi Valkeinen wrote:
>> On 2013-12-18 14:00, Russell King - ARM Linux wrote:
>>> For the SDP4430, it used to detect the displays, even though nothing =
has
>>> ever been displayed on them.  Now it just spits out this:
>>
>> Those particular LCDs are supposed to be updated manually using custom=
 ioctl,
>> so normal software using fb won't put anything on the display. For tes=
ting
>> purposes, a SW based automatic update (~20 fps) can be enabled by kern=
el
>> cmdline parameter "omapfb.auto_update" or via sysfs:
>>
>> echo 1 > /sys/class/graphics/fb0/update_mode
>=20
> I'm confused.  How then can the original kernel which came with the boa=
rd
> run two gstreamer videos on these displays by just talking to the
> framebuffers and play it back smoothly given that we're talking about
> video at normal fps settings?
>=20
> When I received the board, that's exactly what it did at boot up - it
> played back two different video trailers, one on each LCD, and the
> playback was smooth, just like you'd expect from watching a DVD on your=

> TV.  No missing frames, which is what you'd get if you tried to update
> at 20fps.

We once had auto-update support in omapdss in the early versions. It was
removed quite a while ago, as it was a burden to maintain. Either the
kernel you talk about had the auto-update support, or the userspace has
support for manual-update displays.

The thing is, these LCDs are not meant to be used in auto-update mode.
The main point with LCDs with their own framebuffer is that they are
only updated when needed. So a production device would not need
auto-update support. Furthermore, as these LCDs are quite rare, and
4430SDP is the only one we support having these displays, and that board
itself is not exactly a common one, it was decided that the maintenance
burden is not worth it.

I have been thinking of improving the auto-update in omapfb, but it has
never been on the top of my list (or even middle). The current code
basically does just queue_delayed_work() 20 times per second, so it's
just a hack for testing.

 Tomi



--9oJmoC0EiGVdfx9GoANlf3XqIxqpN5Tgv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSscc/AAoJEPo9qoy8lh71XGMP/3TD2nle6lP3V95zJT5R1LPq
Y/SK5wC0p2pXYzoZ0KOixUa580cysGWB0DYqthVUCiqrUuRJwghaVYJZAOJTwdIc
1uRo+RAQ62o4mmxOz6G0wPXQ+lv8GzZoaMSy4LDyn1MaOh8TyFfzLr53FA+T9Y2w
D/fe0YfoTx7KrH65S/Pjwq5yGuSYdwhL/Z7/JHlkb6yH95IOz0FoXv1nWw5Vp6VS
qMBpplUQYKKfPwykYv1zIkNbhH8E6ZZdEl8q+rJQKlKm1wCuEdBTQoEcwXKtoOSE
I48rAYRKPH2uvyMrJN+HkcKDE0qHDYt2X7VKz+g13BfJ0a6wh6u9WlSwpXDhyckO
bPDddgTaw+lwgQhBcKjfOryvV1IGduCeiz3T9uCiglfaiqdGbcgxaqc3HGWLfMFU
4cEmuvj24Sgxa5Fupv/u2aJDmZvZQVRsK0U0ECY6pmjbMAzx7nquYlpWxY1iWo2K
ta9esJxaIveLIuDRKl5rdqfsZ9p1bMb+pVHYvNu1Vsuex5Pd0VzzXWIbo9XzZbrO
1HoQiT4uYM4bP3a7qGPhZwRc7Fh5/MuCQs7W/O3sn+xGyvMRTKsJizwkVj1WSvGO
4CQ3A4iraDaAzOpK2Yi7xkHD7zS4uy77fwdJuCUnJAmzP/EHMW4LmLIG7Gr2Kovz
zfl6EUS/MtEQoSrKp2Mc
=zddX
-----END PGP SIGNATURE-----

--9oJmoC0EiGVdfx9GoANlf3XqIxqpN5Tgv--
