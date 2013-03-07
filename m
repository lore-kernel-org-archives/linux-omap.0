From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Fri, 8 Mar 2013 00:18:27 +0200
Message-ID: <20130307221827.GE31984@valkosipuli.retiisi.org.uk>
References: <201302171616.50152@pali>
 <20130217190303.GC2317@blackmetal.musicnaut.iki.fi>
 <201303062112.06417@pali>
 <201303062120.17303@pali>
 <20130306214440.GA11874@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130306214440.GA11874@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi guys,

On Wed, Mar 06, 2013 at 10:44:41PM +0100, Sebastian Reichel wrote:
> On Wed, Mar 06, 2013 at 09:20:16PM +0100, Pali Roh=E1r wrote:
> > On Wednesday 06 March 2013 21:12:06 Pali Roh=E1r wrote:
> > > On Sunday 17 February 2013 20:03:03 Aaro Koskinen wrote:
> > > > On Sun, Feb 17, 2013 at 04:16:49PM +0100, Pali Roh=E1r wrote:
> > > > > +/*
> > > > > + * arch/arm/mach-omap2/board-rx51-camera.c
> > > > > + *
> > > > > + * Copyright (C) 2008 Nokia Corporation
> > > > > + *
> > > > > + * Contact: Sakari Ailus <sakari.ailus@nokia.com>
> > > > > + *          Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> > > >=20
> > > > You should put these people to CC... Just to see if the
> > > > addresses are still valid (which I doubt).
> > >=20
> > > Ok, trying :-)
> > >=20
> >=20
> > I got "Delivery Status Notification (Failure)" for both addresses.

This is expected.

> Sakari Ailus hosts some code on github [0], which has the following
> email address: sakari.ailus+gitorious@retiisi.org.uk
>=20
> I added it to this mail's CC.
>=20
> [0] https://gitorious.org/~sailus

Nice to hear people are interested in this. ;-)

The primary reason I haven't tried submitting this to mainline is that =
ARM
board code has a bad reputation these days. The N900 does not have yet
support for device tree (AFAIK), which also would require a few bits an=
d
pieces on the flash driver to work.

Also the sensor and lens drivers would need at least some work before b=
eing
ready for submission to mainline for camera to be usable. Unfortunately=
 I
haven't had recently time to work on this. N9(50) support has higher
priority for myself. That, too, is pending the DT support for the devic=
e.

There's indeed more up-to-date code in my repository. Even if it's not =
too
close to mainline anymore it should be a better starting point than the=
 old
kernel from MeeGo.

<URL:https://gitorious.org/omap3camera/pages/Home>

--=20
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
