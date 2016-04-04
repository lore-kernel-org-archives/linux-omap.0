From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 4 Apr 2016 15:31:24 -0700
Message-ID: <20160404223124.GC16484@atomide.com>
References: <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com>
 <20160404110924.GS8413@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160404110924.GS8413@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160404 04:10]:
> On Wednesday 30 March 2016 12:12:09 Tony Lindgren wrote:
> > > How idle system do I need to have? Screen is blanked and machine
> > > should be mostly idle, but there's X running on another vt with M=
ate
> > > desktop, and some python scripts... GSM modem should be online.
> >=20
> > Well I think it's the USB only you have blocking deeper idle states=
=2E
> >=20
> > Are you sure you rmmod:ed all the USB related modules like in my
> > test script?
> >=20
> > MUSB currently has an unresolved issue where it blocks idle states
> > if loaded.
>=20
> Is somebody working on this musb issue? Is there any progress?

No idea when I might get to it.. Please take a look if you have  a
chance to work on it, I think all we have to do:

1. Change musb_gadget_pullup() to run as tasklet/delayed_work to
   avoid trying to access I2C PHY's from atomic context. See
   3e43a0725637 ("usb: musb: core: add pm_runtime_irq_safe()")
   for more info. Not sure if this should be done in a generic
   way or for MUSB only. It could be that I remember wrong what
   I thought needs to be done. But we want to get rid of the
   pm_runtime_irq_save() as that currently forever blocks PM
   for the MUSB hardware specific wrapper driver.

2. Remove pm_runtime_irq_safe() added in commit 3e43a0725637

Adding Bin to Cc, maybe he has some better fix in mind.

Regards,

Tony
