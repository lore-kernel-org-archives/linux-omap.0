From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 28 May 2015 17:15:13 -0700
Message-ID: <20150529001513.GN30984@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com>
 <201505290027.21231@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54560 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141AbbE2APQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2015 20:15:16 -0400
Content-Disposition: inline
In-Reply-To: <201505290027.21231@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150528 15:29]:
> On Friday 29 May 2015 00:24:13 Tony Lindgren wrote:
> > * Matthijs van Duin <matthijsvanduin@gmail.com> [150528 13:28]:
> > > On 28 May 2015 at 18:01, Tony Lindgren <tony@atomide.com> wrote:
> > > > For failed device access you get an interrupt
> > >=20
> > > Well for failed reads you get a bus error, and "catching" those
> > > (e.g. using the existing exception mechanism used to catch MMU
> > > faults) is the whole issue.
> > >=20
> > > Though now that you mention it, it is true that for writes you
> > > won't get any fault (at least on the DM814x and AM335x the postin=
g
> > > point appears to be the async bridge from MPUSS to the L3
> > > interconnect) but an interconnect error irq instead. It may be
> > > easier to make some kind of harmless write (e.g. to the version
> > > register), wait a bit, and check if the write triggered an
> > > interconnect error.
> > >=20
> > > Feels hackish though: you'd need to be sure you waited long enoug=
h
> > > (though using a read from another device on the same L4
> > > interconnect should be a reliable barrier in this case), and
> > > drivers for receiving/interpreting interconnect errors are not
> > > implemented yet on all SoCs (for some, like the AM335x, TI didn't
> > > even bother publishing the relevant data in its TRM). Interconnec=
t
> > > errors can also be lost in some cases (multiple errors involving
> > > the same target in a short time window) though that problem
> > > shouldn't arise in this particular case.
> >=20
> > Hmm I believe the interrupt happens immediately trying to access an
> > invalid device. But maybe I'm thinking about just errors if a devic=
e
> > is not powered or clocked. So obviously some experiments need to be
> > done :)
> >=20
> > The advantage here would be that the l3 driver actually already kno=
ws
> > quite a bit about the devices on the bus.
> >=20
> > > Also, presumably interconnect error reporting is unavailable on H=
S
> > > devices given the fact that all interconnect registers seemed to =
be
> > > inaccessible?
> >=20
> > Oh OK yeah then that would not work for Pali's case. I guess it jus=
t
> > needs to be tested.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Ok, thanks for info. Do you have some quick small patches for testing=
?=20
> Or some pointers what is needed to modify and how?

Well I guess the initial test would be to make sure you have
CONFIG_OMAP_INTERCONNECT=3Dy, comment out status =3D "disabled" in
omap3-n900.dts for aes, patch in the aes hwmod data, check that
you have CONFIG_CRYPTO_DEV_OMAP_AES=3Dy, boot the kernel.

Do you get just the l3_smx interrupt instead of the "Unhandled fault"?

If so then we can use the interrupt handle to make the probe fail.
Not sure yet what would be the best way to do that though :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
