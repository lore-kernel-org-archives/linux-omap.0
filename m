From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Fri, 24 Jul 2015 17:50:33 +0200
Message-ID: <201507241750.33492@pali>
References: <201507111405.06048@pali> <20150724081809.GB22852@dhcp-128-11.nay.redhat.com> <20150724084058.GB10476@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3583609.LXa6laD4ZF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150724084058.GB10476@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <dyoung@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3583609.LXa6laD4ZF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 24 July 2015 10:40:58 Pali Roh=C3=A1r wrote:
> On Friday 24 July 2015 16:18:09 Dave Young wrote:
> > On 07/11/15 at 02:05pm, Pali Roh=C3=A1r wrote:
> > > Hello,
> > >=20
> > > now I tested 4.2-rc1 release on Nokia N900 and couple of drivers
> > > are broken and cause kernel oops...
> > >=20
> > > Basically wifi, touchscreen and rtc drivers not working...
> >=20
> > Pali, could you tell how do you test mainline kernel on n900?
> >=20
> > I used to use n900 as a usb dbgp gadget with a backport patch to
> > 2.6.28 so that I can get early debug kernel message from my laptop.
> >=20
> > I tried mainline previously with Fedora arm, text mode works but
> > no graphics. Is there a way to use maemo UI with mainline kernel?
> >=20
> > Thanks
> > Dave
>=20
> Hi! Starting Maemo with mainline kernel is not possible. But you can
> patch Maemo (userspace) and apply some kernel patches and you could
> boot Maemo system with Hildon UI.
>=20
> You need:
>=20
> Patched kernel:
> https://github.com/pali/linux-n900
>=20
> CSSU-devel:
> https://wiki.maemo.org/CSSU
> http://talk.maemo.org/showthread.php?t=3D84292
>=20
> Open source battery management:
> http://talk.maemo.org/showthread.php?t=3D93183
>=20
> Fixup for Dialer application (rtcom-call-ui):
> Fixing HAL path
> /org/freedesktop/Hal/devices/platform_soc_audio_logicaldev_input
>=20

Create new file /etc/event.d/userspace-fixes with content:

start on started hildon-desktop
service
console none
script
	if ! hal-device /org/freedesktop/Hal/devices/platform_soc_audio_logicaldev=
_input 2> /dev/null; then
		hal-device --add /org/freedesktop/Hal/devices/platform_soc_audio_logicald=
ev_input < /dev/null
		hal-set-property --udi /org/freedesktop/Hal/devices/platform_soc_audio_lo=
gicaldev_input --key input.jack.type --
strlist-pre "a"
		hal-set-property --udi /org/freedesktop/Hal/devices/platform_soc_audio_lo=
gicaldev_input --key input.jack.type --
strlist-rem "a"
	fi
end script


> Fixup for SGX video driver:
> Fixing script /etc/event.d/sgx
>=20

Change if condition to:

if [ -n "$(grep RX-51 /proc/component_version)" ] && uname -r | grep -q '^2=
=2E'; then

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3583609.LXa6laD4ZF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWyXskACgkQi/DJPQPkQ1LbDQCdE8RYBhZBjRzQPwn1r0ZTn2/t
qqQAoIoG1Ete02F4w13WiE7wFzvmt5Ec
=n2gw
-----END PGP SIGNATURE-----

--nextPart3583609.LXa6laD4ZF--
