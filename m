From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Sun, 29 Nov 2015 23:13:03 +0000
Message-ID: <20151129231303.GF30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr>
 <20151129180939.GE30871@n2100.arm.linux.org.uk>
 <201511291919.18179@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201511291919.18179@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 29, 2015 at 07:19:18PM +0100, Pali Roh=E1r wrote:
> On Sunday 29 November 2015 19:09:39 Russell King - ARM Linux wrote:
> > On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> > > Good. And Arnd likes the idea too. So we might be converging at
> > > last which is a good thing.
> >=20
> > I disagree with the idea that there is convergence.  There might be
> > convergence towards an idea, but... Here's a mail extract, from Jul=
y
> > 7th, from earlier in this very thread:
> >=20
> > Pali:
> > > Me:
> > > > Are the ATAGs at a fixed address on the N900?
> > >=20
> > > Yes, in board-rx51.c is:
> > >=20
> > > .atag_offset    =3D 0x100
> > >=20
> > > and Nokia Bootloader (proprietary) store them to that address.
> > >=20
> > > > Can that be handled in
> > > > some kind of legacy file for the N900 which calls save_atags() =
on
> > > > it, so we don't end up introducing yet more stuff that we have
> > > > to maintain into the distant future?  If not, what about copyin=
g
> > > > a known working atag structure into a legacy file for the N900?
> > >=20
> > > I already asked question if it is possible to read ATAGs from DT
> > > booted kernel. And somebody (do not remember who) wrote to ML,
> > > that it is not possible and it can be done in that uncompress
> > > code.
> >=20
> > So you're converging on an idea that has already been rejected.=20
> > That's not a good thing, IMHO.
>=20
> Or in other case show that such implementation is possible...

Only those with the problem can do that.

--=20
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
