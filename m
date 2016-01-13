From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: u-SD card in v4.2+
Date: Wed, 13 Jan 2016 20:12:40 +0100
Message-ID: <20160113191240.GA10717@amd>
References: <20160106204627.GA21477@amd>
 <568DFA4B.7030308@ti.com>
 <20160107113408.GA26618@amd>
 <201601092344.44641@pali>
 <56936A77.9070803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56936A77.9070803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, tony@atomide.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Mon 2016-01-11 14:10:23, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On Sunday 10 January 2016 04:14 AM, Pali Roh=E1r wrote:
> > On Thursday 07 January 2016 12:34:09 Pavel Machek wrote:
> >> Hi!
> >>
> >>> On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
> >>>> Hi!
> >>>>
> >>>> In v4.1, both internal MMC and u-SD cards work ok.
> >>>>
> >>>> In v4.2, only the internal MMC is detected. In v4.3, not even
> >>>> internal MMC works. In v4.4, only the internal MMC is detected.
> >>>>
> >>>> Does it work for you? Any patches?
> >>>
> >>> I don't have Nokia N900 to check this, but can you share your
> >>> config and kernel logs? Check if CONFIG_REGULATOR_PBIAS is presen=
t
> >>> in your config. CONFIG_REGULATOR_PBIAS is now mandatory for all
> >>> omap3+ SoCs to work.
> >>
> >> I enabled CONFIG_REGULATOR_PBIAS and both MMCs now work.
> >>
> >> I wonder if we should add some selects, so that users updating fro=
m
> >> old kernels don't break their system?
> >=20
> > Please add these selects. I had CONFIG_REGULATOR_PBIAS disabled too=
,=20
> > because I just updated defconfig from older kernel version.
>=20
> 'select' is generally not recommended since it selects a config witho=
ut
> caring for the dependency. With adding 'depends on', MMC won't be ena=
bled and
> will end up in the same problem.

Well... it really should "depend on". Not ideal, but you'll likely
realize what went on.

Silently compiling known-bad kernel is ... well.. bad.

> Tony has already added a Documentation noting that CONFIG_REGULATOR_P=
BIAS
> should be enabled for MMCs to work.
> commit d8e1f5ed11a39a68da00f05000466c4f6db4456e
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Mon Oct 12 16:19:54 2015 -0700
>=20
>     Documentation: ARM: List new omap MMC requirements
>=20
> Maybe we should also make the error message a little more verbose to =
tell the
> user that CONFIG_REGULATOR_PBIAS be selected?

That would help.

As would #error if we recognize broken config.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
