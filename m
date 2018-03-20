From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.16-rc5 on Motorola Droid 4
Date: Tue, 20 Mar 2018 18:00:29 +0100
Message-ID: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2rsqwc3fc3jdhpb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320140322.GU5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--h2rsqwc3fc3jdhpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 20, 2018 at 07:03:22AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180318 22:05]:
> > I have the phone, I have safestrap installed, kexec seems to work
> > (crashes my system). But I can't get any output from the new kernel.
> >=20
> > All the howtos assume serial connection, but I don't yet have
> > that. I'm really bad at soldering. IIRC display should work in the
> > latest kernels, maybe with some patches?
>=20
> Yeah display related stuff is half merged in Linux next, backlight
> needs some binding changes from what I remember. I think the
> minimal set is something like this against v4.16-rc:

I have an updated lm355x backlight driver almost ready, that uses
an updated binding scheme and exposes the keyboard backlight
using the LED subsystem.

> backlight: add TI LMU backlight driver
> drm/omap: add framedone interrupt support
> drm/omap: add manual update detection helper
> drm/omap: add support for manually updated displays
>=20
> Then also audio support is also half merged and need few patches
> if you check the mailing list archives for cpcap codec related
> patches.

I just noticed, that I missed Rob gave his Acked-by to the binding
already. I will prepare a PATCHv6 with the MFD changes this week.

> Maybe get somebody to help you locally with the debug cable
> soldering? :)

I suppose people from your hackerspace can help you. It's really
easy to do. Soldering can be avoided btw. You can just use a pair
of scissors to cut a USB -> Micro USB cable and use a knife to remove
isolation. Then screw each of the 4 wires into a terminal strip.
There are USB-TTL adapters available, that have an attached cable.
If you also cut the connector from such a cable and connect it to
the other side of the terminal strip you are done. No soldering
involved ;)

> > Could someone give me .config and git hash that works for him? Once I
> > get working display I should be able to continue easily. I'd really
> > like to get voice calls working...
>=20
> You want to use omapdrm, below is what I'm using with loadable
> modules with Linux next based on omap2plus_defconfig. It has some
> extra debug options enabled too that you might want to ignore,
> I'll try to send the defconfig related patches out too.
>=20
> Basically you need the CONFIG_MFD_TI_LMU, CONFIG_DRM_OMAP and
> CONFIG_DRM_OMAP_PANEL_DSI_CM related options.
>=20
> > I took a brief look through dts, and I did not find anything that
> > could be easily used for debugging. (It seems that capslock LED and
> > keyboard backlight is not yet supported? Also volume down  seems to be
> > supported but not volume up, funny).
>=20
> Oh I thought we had all the LEDs mapped already? Volume down is
> on the internal keypad, then volume up is on a GPIO controller.
> I guess to allow chords for the bootloader.

The keyboard backlight and lcd backlight are controlled by LM3552,
that's the driver mentioned above. The other LEDs (status rgb,
shift/capslock, and the android button backlight) are working.

-- Sebastian

--h2rsqwc3fc3jdhpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqxPicACgkQ2O7X88g7
+prAhw/+LueUAayBXeuRRczS13EfMl9j2C6h5IVP48qAJ7UvLeMgJ1Vn8MjnbGxy
lDsJbs39dlBi5BsiIGsYLIL06qqa5PGGS2RphWex3wtLUvJdXKCOBGe6yzZ/F73k
6GXXZcXxElzQr0eetfGBbRZzIPn/gM2IML/64dvrvq7vPVOuwsQ3L/C5dtlHV4Iz
QZmrIqQXSHmj9zr9elWtugI4z0+t/Dzo/IpK+mmf/ivUs+XMSAZzE3ZXEg7MJqZh
ocqji6POjq7JnbpKpDdo1tcIWPR7yYP9X0XtIIwC68hYmil6kvp5eADqxy24Tffh
l+dyHJz0UCM0JNPZoR1za7qz3HHaSRyAqo49dxTPo35Au6sQWDdx7iELaU9VM3Uu
n95ELiQ80Audanz33NF6hnMEn6OILzDtw8bKkLRcyYncaY2LBI3SyzXsN99I6Jvh
oqomH3xZws5H/8mTydWIugFdIZf00zo+qOZwsQuWyXZNFic5yhJ6K9tlRHqZYudb
OFmQ4W1NyiOLR2xXc1pBF/L/NYS5xbJLZblSSBtNw8yTZ5ASBsxhFDd7E6kweVdo
x0HJoeKBvouJxrSzqkSiOmFx/YZtdB23dntfqks9dG+z6k6+BFtpMhQ/vRN3WB7S
uz/440yw125oF8FCsbLYCqu/CpyNSNcX3gb5/w8hukHx4hL6K64=
=eVWY
-----END PGP SIGNATURE-----

--h2rsqwc3fc3jdhpb--
