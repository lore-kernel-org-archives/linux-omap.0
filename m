From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Fri, 24 Jul 2015 12:53:28 +0200
Message-ID: <20150724105328.GG10476@pali>
References: <201507111405.06048@pali>
 <20150724081809.GB22852@dhcp-128-11.nay.redhat.com>
 <55B1F7BB.9020102@gmail.com>
 <20150724102844.GB8405@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150724102844.GB8405@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <dyoung@redhat.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 24 July 2015 18:28:44 Dave Young wrote:
> On 07/24/15 at 11:30am, Ivaylo Dimitrov wrote:
> >=20
> >=20
> > On 24.07.2015 11:18, Dave Young wrote:
> >=20
> > >Pali, could you tell how do you test mainline kernel on n900?
> > >
> > >I used to use n900 as a usb dbgp gadget with a backport patch to
> > >2.6.28 so that I can get early debug kernel message from my laptop=
=2E
> > >
> > >I tried mainline previously with Fedora arm, text mode works but
> > >no graphics. Is there a way to use maemo UI with mainline kernel?
> > >
> > >Thanks
> > >Dave
> > >
> >=20
> > http://talk.maemo.org/showpost.php?p=3D1459970&postcount=3D142
> >=20
> > This is the last (almost) upstream kernel I tried, unfortunately re=
cently I
> > am very short on spare time, so cannot confirm for 4.x kernels, but=
 in
> > theory those should work as well.
> >=20
> > The kernel tree was on gitorious, but it is down now(I have a local=
 copy).
> > However, all of the needed patches should be on
> > https://github.com/pali/linux-n900.
>=20
> Ivaylo, thanks for your info. I know pali's kernel tree, but the prob=
lem is
> I do not know much about the userspace fixes.
>=20
> According to another reply from Pali, I should fix HAL and sgx start =
script.
>=20
> Thanks
> Dave

It is not enough, also you need to update Maemo to CSSU-devel version
and install BME replacement stuff (open source battery management).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
