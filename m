From: Matt Porter <matt@ohporter.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
Date: Tue, 21 Feb 2012 16:11:51 -0500
Message-ID: <20120221211151.GA1609@beef>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
 <20120213165209.GA31482@n2100.arm.linux.org.uk>
 <20120213165617.GE3494@opensource.wolfsonmicro.com>
 <20120213175233.GC1426@atomide.com>
 <20120213180236.GB31482@n2100.arm.linux.org.uk>
 <20120213181410.GE1426@atomide.com>
 <20120213185823.GF3494@opensource.wolfsonmicro.com>
 <20120221184648.GR18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120221184648.GR18185@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Matt Porter <mporter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 21, 2012 at 10:46:48AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [120213 10:27]:
> > On Mon, Feb 13, 2012 at 10:14:10AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120213 09:31]:
> > > > On Mon, Feb 13, 2012 at 09:52:34AM -0800, Tony Lindgren wrote:
> > 
> > > > > Can't we just leave out the .id and have it automatically assigned?
> > 
> > It'd be nice but...
> > 
> > > > Unfortunately, there's no such infrastructure in the driver model.
> > 
> > > Hmm OK, -1 seems to be just used for name in platform_device_add().
> > 
> > -1 is a valid ID also, it means "there's only one of these things so
> > don't display a number".  Which is sad but there we are.  I'm at ELC/ABS
> > so I might try and find Greg in person here to see if we can come up
> > with something better, it seems like this is something the core ought to
> > be able to help with in much the same way that the USB stuff can.
> 
> Matt, care to refresh your original patch using some other number so
> we can apply it as a regression fix for the -rc series while the
> long term solution is being discussed?
> 
> Just use some random number for now with a comment, 42?

Will do, I'll post an update with this approach.

-Matt
