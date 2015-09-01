From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Tue, 1 Sep 2015 11:56:06 -0700
Message-ID: <20150901185605.GP4215@atomide.com>
References: <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55DC3D58.4030409@ti.com>
 <20150825135044.GJ27431@sirena.org.uk>
 <55E42FF7.9010706@ti.com>
 <20150831145249.GO12027@sirena.org.uk>
 <55E5727E.1040103@ti.com>
 <20150901141720.GD4215@atomide.com>
 <20150901183657.GX5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150901183657.GX5313@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Lee Jones <lee.jones@linar>, Arnd Bergmann <arnd@arndb.de>, Grygorii Strashko <grygorii.strashko@ti.com>, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [150901 11:40]:
> On Tue, Sep 01, 2015 at 07:17:21AM -0700, Tony Lindgren wrote:
> 
> > Why don't you just make reg unused for pbias_regulator since
> > we already use regmap for this driver?
> 
> > Then in the pbias driver just define the register offset from
> > the syscon base? You may need to set it based on the compatible
> > value, but it's not like it's going to change for SoC.
> 
> > If we eventually add some API to calculate reg base offset
> > from the syscon base it's easy to update the driver to use
> > that.
> 
> That'd work.  The other thing I was thinking we could do is to get
> syscon to treat any excessively large address that gets passed in that
> looks like an absolute address appropriately.

Hmm wouldn't that get messy for 64-bit :) How about something
like:

unsigned long syscon_regmap_get_offset(struct regmap *syscon,
					void __iomem *base)

Not sure if that's something that some drivers would start to
misuse with read/writel though.. Presumably not if the driver
already is using syscon.

Regards,

Tony
