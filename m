From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Wed, 25 Nov 2015 13:03:10 -0800
Message-ID: <20151125210310.GT2517@atomide.com>
References: <20150713131902.GH26485@atomide.com>
 <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com>
 <17134653.86P3dFyQKK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <17134653.86P3dFyQKK@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [151125 11:50]:
> On Wednesday 25 November 2015 10:16:44 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [151123 06:46]:
> > > On Sunday 22 November 2015 07:51:46 Pavel Machek wrote:
> > > > On Wed 2015-11-11 17:10:46, Frank Rowand wrote:
> > > > > Adding devicetree list.
> > > > >=20
> > > > > Thread starts at
> > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-Ju=
ly/354459.html
> > > > >=20
> > > > > On 11/5/2015 8:17 AM, Tony Lindgren wrote:
> > > > > > * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [151105 03:41]:
> > > > > >> On Tuesday 13 October 2015 16:37:46 Pali Roh=C3=A1r wrote:
> > > > > >>> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
> > > > > >>>> * Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [151012 13:29]:
> > > > > >>>>> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> > > > > >>>>>>
> > > > > >>>>>> Pali, any news on posting an updated series with the c=
omments
> > > > > >>>>>> addressed in this thread? It seems that we all pretty =
much agree
> > > > > >>>>>> what needs to be done.
> > > > >=20
> > > > > I'm not real happy with the concept of patches 4 and 5 in thi=
s series.
> > > > > My concern is that those two patches are using the FDT as a t=
ransport
> > > > > mechanism for a binary blob (the atags object).
> > > >=20
> > > > Umm. Ok. Do you have alternative proposal that works for everyo=
ne?
> > > >=20
> > > > I mean. This discussion was going for quite a long time, and it=
 would
> > > > be nice to have some solution... patch proposal... something.
> > > >                                                                =
     Pavel
> > >=20
> > > Yes, discussion is going for a long time! So should I spend time =
for
> > > adding documentation to my solution (this is last one thing which=
 is
> > > missing)? Or my solution is wrong and somebody else will propose =
new?
> > > I do not want to spend time on something which will be rejected a=
nd
> > > discarded.
> >=20
> > At least I don't have better solutions in mind.
>=20
> I would be happier if we could restrict this as much as possible to t=
he
> boards that need it, as an opt-in. That way it doesn't become an ABI
> for people that don't already rely in this information. How about
> adding a check the code adds the linux,atags property to do it
> only for a whitelist of board numbers?

Or populate /proc/atags only for the ones that need it from machine
specific init_early?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
