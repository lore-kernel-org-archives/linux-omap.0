From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Wed, 25 Nov 2015 20:48:59 +0100
Message-ID: <17134653.86P3dFyQKK@wuerfel>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali> <20151125181644.GI2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151125181644.GI2517@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar@gmail.com> [151123 06:46]:
> > On Sunday 22 November 2015 07:51:46 Pavel Machek wrote:
> > > On Wed 2015-11-11 17:10:46, Frank Rowand wrote:
> > > > Adding devicetree list.
> > > >=20
> > > > Thread starts at
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July=
/354459.html
> > > >=20
> > > > On 11/5/2015 8:17 AM, Tony Lindgren wrote:
> > > > > * Pali Roh=E1r <pali.rohar@gmail.com> [151105 03:41]:
> > > > >> On Tuesday 13 October 2015 16:37:46 Pali Roh=E1r wrote:
> > > > >>> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
> > > > >>>> * Pali Roh=E1r <pali.rohar@gmail.com> [151012 13:29]:
> > > > >>>>> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> > > > >>>>>>
> > > > >>>>>> Pali, any news on posting an updated series with the com=
ments
> > > > >>>>>> addressed in this thread? It seems that we all pretty mu=
ch agree
> > > > >>>>>> what needs to be done.
> > > >=20
> > > > I'm not real happy with the concept of patches 4 and 5 in this =
series.
> > > > My concern is that those two patches are using the FDT as a tra=
nsport
> > > > mechanism for a binary blob (the atags object).
> > >=20
> > > Umm. Ok. Do you have alternative proposal that works for everyone=
?
> > >=20
> > > I mean. This discussion was going for quite a long time, and it w=
ould
> > > be nice to have some solution... patch proposal... something.
> > >                                                                  =
   Pavel
> >=20
> > Yes, discussion is going for a long time! So should I spend time fo=
r
> > adding documentation to my solution (this is last one thing which i=
s
> > missing)? Or my solution is wrong and somebody else will propose ne=
w?
> > I do not want to spend time on something which will be rejected and
> > discarded.
>=20
> At least I don't have better solutions in mind.

I would be happier if we could restrict this as much as possible to the
boards that need it, as an opt-in. That way it doesn't become an ABI
for people that don't already rely in this information. How about
adding a check the code adds the linux,atags property to do it
only for a whitelist of board numbers?

	Arnd
