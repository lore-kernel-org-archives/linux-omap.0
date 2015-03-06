From: Pavel Machek <pavel@ucw.cz>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Fri, 6 Mar 2015 23:40:34 +0100
Message-ID: <20150306224034.GA20559@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd>
 <201503062257.58180@pali>
 <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, khilman@kernel.org, NeilBrown <neilb@suse.de>, sre@debian.org, linux-pm@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, sre@ring0.de, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat 2015-03-07 00:12:07, Grazvydas Ignotas wrote:
> On Fri, Mar 6, 2015 at 11:57 PM, Pali Roh=E1r <pali.rohar@gmail.com> =
wrote:
> > On Friday 06 March 2015 22:24:17 Pavel Machek wrote:
> >> Hi!
> >>
> >> According to n900 dts, twl4030-bci (aka charger) should be
> >> included.
> >>
> >
> > AFAIK it is not present on n900...
>=20
> Right, it uses twl5030 variant without the charger, charging on n900
> is provided by separate chip and for a good reason as twl's charger i=
s
> not that good. Forcing the driver to load just ends up with it
> accessing non-existent registers over i2c.

Ok, but:

1) Why is the twl4030-bci enabled in n900's dts, then

and

2) When it is enabled, why it does not load?

(I guess there's no way to get to input voltage on n900...?)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
