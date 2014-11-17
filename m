From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Mon, 17 Nov 2014 06:55:46 -0800
Message-ID: <20141117145545.GC7046@atomide.com>
References: <20141116075928.GA9763@amd>
 <201411170943.20810@pali>
 <20141117100519.GA4353@amd>
 <201411171109.47795@pali>
 <20141117101553.GA21151@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141117101553.GA21151@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sakari.ailus@iki.fi, devicetree@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [141117 02:17]:
> On Mon 2014-11-17 11:09:45, Pali Roh=C3=A1r wrote:
> > On Monday 17 November 2014 11:05:19 Pavel Machek wrote:
> > > Hi!
> > >=20
> > > On Mon 2014-11-17 09:43:19, Pali Roh=C3=A1r wrote:
> > > > On Sunday 16 November 2014 08:59:28 Pavel Machek wrote:
> > > > > For device tree people: Yes, I know I'll have to create
> > > > > file in documentation, but does the binding below look
> > > > > acceptable?
> > > > >=20
> > > > > I'll clean up driver code a bit more, remove the printks.
> > > > > Anything else obviously wrong?
> > > >=20
> > > > I think that this patch is probably not good and specially
> > > > not for n900. adp1653 should be registered throw omap3 isp
> > > > camera subsystem which does not have DT support yet.
> > >=20
> > > Can you explain?
> > >=20
> > > adp1653 is independend device on i2c bus, and we have kernel
> > > driver for it (unlike rest of n900 camera system). Just now
> > > it is unusable due to lack of DT binding. It has two
> > > functions, LED light and a camera flash; yes, the second one
> > > should be integrated to the rest of camera system, but that
> > > is not yet merged. That should not prevent us from merging DT
> > > support for the flash, so that this part can be
> > > tested/maintained.
> > >=20
> >=20
> > Ok. When ISP camera subsystem has DT support somebody will modify=20
> > n900 DT to add camera flash from adp1653 to ISP... I believe it=20
> > will not be hard.
>=20
> Exactly. And yes, I'd like to get complete camera support for n900
> merged. But first step is "make sure existing support does not break"=
=2E

There's nothing stopping us from initializing the camera code from
pdata-quirks.c for now to keep it working. Certainly the binding
should be added to the driver, but that removes a dependency to
the legacy booting mode if things are otherwise working.

Regards,

Tony
