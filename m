From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
Date: Mon, 13 Feb 2012 10:14:10 -0800
Message-ID: <20120213181410.GE1426@atomide.com>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
 <20120213165209.GA31482@n2100.arm.linux.org.uk>
 <20120213165617.GE3494@opensource.wolfsonmicro.com>
 <20120213175233.GC1426@atomide.com>
 <20120213180236.GB31482@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120213180236.GB31482@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120213 09:31]:
> On Mon, Feb 13, 2012 at 09:52:34AM -0800, Tony Lindgren wrote:
> > * Mark Brown <broonie@opensource.wolfsonmicro.com> [120213 08:25]:
> > > On Mon, Feb 13, 2012 at 04:52:09PM +0000, Russell King - ARM Linux wrote:
> > > 
> > > > I think OMAP (or even the reg-fixed-voltage folk) needs to create an enum
> > > > similar to what I did for 8250 to control the allocation of platform
> > > > device IDs for this, otherwise we're going to keep on running over this
> > > > problem.
> > > 
> > > > Added Mark for his comment.
> > > 
> > > Hrm, seems slightly icky but the enum will work if we can decide how to
> > > add elements to the enum since it'll be easy to bloat a lot it if it's
> > > central.  It's tempting to suggest just using a random number to assign
> > > the IDs randomly rather than have a central registry but obviously
> > > there's no guarantees there.
> > 
> > Can't we just leave out the .id and have it automatically assigned?
> 
> Unfortunately, there's no such infrastructure in the driver model.

Hmm OK, -1 seems to be just used for name in platform_device_add().

Tony
