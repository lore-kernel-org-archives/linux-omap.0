From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Tue, 7 Jul 2015 09:46:26 +0200
Message-ID: <20150707074626.GB12087@pali>
References: <20141019090107.GA19132@amd>
 <20141028222123.GA17518@amd>
 <20141028222641.GW2542@atomide.com>
 <201507061524.44999@pali>
 <20150706135317.GH10705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150706135317.GH10705@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 06 July 2015 06:53:18 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150706 06:27]:
> > On Tuesday 28 October 2014 23:26:41 Tony Lindgren wrote:
> > > * Pavel Machek <pavel@ucw.cz> [141028 15:22]:
> > > > On Tue 2014-10-28 23:04:50, Pavel Machek wrote:
> > > > >=20
> > > > > Networking now works against 3.17-based kernel. Thanks!
> > > >=20
> > > > It works on 3.18-rc1 kernel, too. (I had to hand-modify patch t=
o
> > > > apply to 3.17, no changes needed for 3.18-rc1.)
> > > >=20
> > > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > >=20
> > > Whatever we decice to do to fix this regression, it should probab=
ly
> > > be backported to at least v3.16 stable for distro use, maybe earl=
ier
> > > too. I'd assume this is broken on multiple platforms currently.
> > >=20
> > it looks like this patch was not included into any kernel version..=
=2E I'm=20
> > still using it on top of 4.x kernels. Are you going to send this pa=
tch=20
> > into upstream? Or do you have another fix for this problem?
>=20
> I think Felipe mentioned a better built-in gether fix that's been
> reviewed on linux-usb list.
>=20
> Regards,
>=20
> Tony

Do you have link to that email thread? Or was Felipe's fix already
merged into mainline kernel?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
