From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Thu, 8 Nov 2012 09:39:13 +0200
Message-ID: <509B61A1.30902@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com> <5093AE79.9010603@ti.com> <5093B4F3.1000703@ti.com> <50977EEF.3040403@ti.com> <5097CB81.7050204@ti.com> <509913A4.5080408@iki.fi> <CAF6AEGuNyqO-teda1sv8c8m9x1j8Fm13HYuWB4N3gccJeKFTFg@mail.gmail.com> <509A3171.8010100@ti.com> <CAF6AEGvJqmvkvkbnegVvnt+SxrWajB=Vq-LsY=k1c96eeyQEXA@mail.gmail.com> <509A7A95.804@ti.com> <CAF6AEGsvRV=ez_aqz_tkb+azNMy4jQuSVdd7oKg6=nTnguX-Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA899BAB3DC5CCBFD3D9CDF9E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43039 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500Ab2KHHja (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 02:39:30 -0500
In-Reply-To: <CAF6AEGsvRV=ez_aqz_tkb+azNMy4jQuSVdd7oKg6=nTnguX-Kw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Tomi Valkeinen <tomba@iki.fi>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enigA899BAB3DC5CCBFD3D9CDF9E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-07 21:18, Rob Clark wrote:
> On Wed, Nov 7, 2012 at 9:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>> On 2012-11-07 16:32, Rob Clark wrote:
>>> On Wed, Nov 7, 2012 at 4:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>>
>>>> Hotplugging is not some abstract future scenario, we already have
>>>> hardware that could use it. For example, omap3 SDP board has a
>>>> switchable output to DVI or LCD panel. In this case we know what the=
 two
>>>> options are, but the disabled component is still effectually removed=

>>>> from the system, and plugged back in when it's enabled.
>>>
>>> I would look at this as two different connectors which can not be use=
d
>>> at the same time.  You have this scenario with desktop graphics cards=
=2E
>>
>> Yes, that's an option with fixed amount of display devices. But doesn'=
t
>> work for capes.
>=20
> Only if capes are hotpluggable.. otherwise probe what cape(s?) are
> present at boot time (is this possible to detect a cape from sw?), and
> create the associated connector(s).

Well, a cape can be anything. For beaglebone they have capes with
eeprom, and you can detect it.

The reason I'd like to have hotplug is that it would simplify panel
drivers in the case where we have multiple possible panels for the same
output, like the DVI/LCD case above for omap3 SDP.

If we don't have hotplug, then both DVI and LCD panel devices are
present at the same time, and they will share resources. In the minimum
they are sharing the video output, but more often than not they share
gpios/powers/etc.

It's normal that a driver will acquire resources for its device in its
probe, and thus we would have two drivers acquiring the same resources
at boot time, leading to the other driver failing. We currently manage
this by acquiring the resources late, only when the panel is being
enabled. But I think that's rather ugly.

It would be much cleaner if the panel device does not exist at all if
the panel is disconnected, and is created only when it is connected.
This of course creates the problem of who is responsible for creating
the panel device, and what triggers it. I think that's case specific,
and for capes, it'd be the cape driver.

But then again, I guess it's acceptable that we don't allow changing the
plugged-in panels at runtime. The user would have to select them with
kernel parameters or such. I guess this would be ok for capes and
development boards. I'm not aware of a production board that would
switch panels at runtime, although I know these were on the table in Noki=
a.

> Anyways, I think we are stretching a bit hard for use cases for
> hot-pluggable panels..  I just prefer to ignore hotplug for now and
> come back to it when there is a more legitimate use-case.

Ok, fair enough. But let's keep hotplug in mind, and if we're going to
create code that would make hotplug impossible to implement, let's stop
for a moment and think if we can do that in some other way.

>> I'm not so sure. The output (dpi/dsi/hdmi...) is the second step in ou=
r
>> chain. The primary "output" is in the DISPC module, the overlay manage=
r.
>> That's where the timings, pixel clock, etc. are programmed. The second=

>> step, our output, is really a converter IP. It receives the primary
>> output, converts it and outputs something else. Just like an external
>> converter chip would do.
>>
>=20
> the timings, pixel clock, vblank/framedone irqs, that all maps to crtc.=

>=20
> encoder =3D=3D converter, so I think this fits.  "An encoder takes pixe=
l
> data from a CRTC and converts it to a format suitable for any attached
> connectors" (from drm docbook)

Oh, ok. Then what you say makes sense. I thought encoder contains the
timings, as you said previously: "Basically the encoder is doing the
"control" stuff (power on/off, set timings, etc)".

In the case we have a long chain of display blocks, encoder could cover
all of them, not just the output block of OMAP? I don't know where the
panel goes, though.

>> And the output can be quite a bit anything. For example, with DBI or D=
SI
>> command mode outputs we don't have any of the conventional video
>> timings. It doesn't make sense to program, say, video blanking periods=

>> to those outputs. But even with DBI and DSI we do have video blanking
>> periods in the DISPC's output, the ovl mgr.
>=20
> the encoder has mode_fixup() which can alter the timings that end up
> getting set, which might be a way to account for this.  I guess really
> it should be the panel driver that is telling the encoder what
> adjusted timings to give to the crtc.. so the panel driver doesn't
> quite map to connector.

The panel can't say what timings to give to crtc, it depends on what's
between the crtc and the panel. In case of OMAP DSI, the dsi driver
needs to specify the timings for crtc, based on the panel.

 Tomi



--------------enigA899BAB3DC5CCBFD3D9CDF9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQm2GkAAoJEPo9qoy8lh71h4cP/iKZ/oI8ZzKhuZXHtwgsq/bD
yQdTqYwzXgnMf/rB0d7zABcRUbvXWayoXj99fMD54TQu4O6SOPJUk9RQlqy9G/P+
2mbovEJ9gZN1uGtH7yZY5+5hVz40hnHHLGy9TJdYuiA5EoTE9fFkVlGZxYG0eq6E
aHUBjnw/uGut/GbC/XcCwOp142yYFXQBOf96SwoQq0Np0YP+w6Jx4jumMmrgtfGZ
CCFbdxV95JaRhNGz/u9RsyJOvkY71AU0hLBVB+xQXrVVfYJ3D1pmYS+NjnXta1m8
Qf6VLdulglumNzSQ8w2AmXc1KLLPK+FRDMTzwVbkgZbVJ2lBXihiiSGI9w+g9VQB
01UIhNbPtjkKbKWkwlg1AGcoo1lB9HZLjpy1apw2yCBXWrvjMxydfhKQWYrlyIcZ
N2sijqDVp6hPJrGPInXl3qhKvaeytSCWZ6/atNrTOKDzSqps6sMUHG+SyVQsoJc3
yp0zYDngAtO7XCPeW7M8MsD9tmfWa0RYRSgLHbrHhLv1tKDoID2NqKta/DHSIqcf
4JX0BBSnLNeyifvrzzgFIKL2964FrYsATAnu5NdImrqTeMpi7QDPHeTDyTDA/Vmn
m0EgkGy8kSQgsyCXhTamh8+1gQTF7kjxO60r3OSfkhKLhkYTqb43F8f/cpRBDEh4
q/Q+E3axMytA3tsbgguJ
=cIq5
-----END PGP SIGNATURE-----

--------------enigA899BAB3DC5CCBFD3D9CDF9E--
