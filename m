From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Wed, 24 Jun 2015 22:01:38 -0700
Message-ID: <20150625050138.GL4156@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel>
 <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel>
 <20150506114417.GI30910@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150506114417.GI30910@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150506 04:45]:
> On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> > >=20
> > > It needs to be done in this code, so "system_rev" variable is set
> > > properly...
> >=20
> > What I mean is which code accesses this variable that early?
> >=20
>=20
> ATAG code is doing it at same early stage, so I added it to same earl=
y
> stage...

Yes we should do this early like the other atags.
=20
> > > > Also, it seems strange to have a string property and then use k=
strtouint
> > > > to convert it into a number. I think it should either be specif=
ied in a DT
> > > > binding to be a string and then have the kernel not assume that=
 it is a number,
> > > > or we should define it to be binary.
> > > >=20
> > > >       Arnd
> > >=20
> > > Variable "system_rev" is number and it always was. So chaning typ=
e will
> > > break more parts.
> > >=20
> > > And it is string DT property to be human readable. Some other dev=
elopers
> > > suggested for v2 to change it to string (from number).
> >=20
> > Both of them would be human readable, you just use something else t=
o
> > read them ;-)
> >=20
> > If we have a string here, we should just change all uses of system_=
rev
> > in the kernel accordingly, there are only a few of them:

Let's just keep it as a hex as it was. After all it's an existing
interface in /proc that user space programs may expect to be in
hex format already.

Pali, care to repost the whole set again right after -rc1 with
with rev property naming and documentation added? Just keep it
as hex and let's forget any string conversion.

Regards,

Tony
