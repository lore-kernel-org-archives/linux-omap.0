From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Fri, 24 Jul 2015 10:40:58 +0200
Message-ID: <20150724084058.GB10476@pali>
References: <201507111405.06048@pali>
 <20150724081809.GB22852@dhcp-128-11.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150724081809.GB22852@dhcp-128-11.nay.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <dyoung@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 24 July 2015 16:18:09 Dave Young wrote:
> On 07/11/15 at 02:05pm, Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > now I tested 4.2-rc1 release on Nokia N900 and couple of drivers ar=
e
> > broken and cause kernel oops...
> >=20
> > Basically wifi, touchscreen and rtc drivers not working...
> >=20
>=20
> Pali, could you tell how do you test mainline kernel on n900?
>=20
> I used to use n900 as a usb dbgp gadget with a backport patch to
> 2.6.28 so that I can get early debug kernel message from my laptop.
>=20
> I tried mainline previously with Fedora arm, text mode works but
> no graphics. Is there a way to use maemo UI with mainline kernel?
>=20
> Thanks
> Dave

Hi! Starting Maemo with mainline kernel is not possible. But you can
patch Maemo (userspace) and apply some kernel patches and you could boo=
t
Maemo system with Hildon UI.

You need:

Patched kernel:
https://github.com/pali/linux-n900

CSSU-devel:
https://wiki.maemo.org/CSSU
http://talk.maemo.org/showthread.php?t=3D84292

Open source battery management:
http://talk.maemo.org/showthread.php?t=3D93183

=46ixup for Dialer application (rtcom-call-ui):
=46ixing HAL path /org/freedesktop/Hal/devices/platform_soc_audio_logic=
aldev_input

=46ixup for SGX video driver:
=46ixing script /etc/event.d/sgx

If you do not know how to fix HAL & SGX script I can send you later
needed information. But I do not know them right now.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
