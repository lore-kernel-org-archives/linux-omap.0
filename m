From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Date: Fri, 29 Mar 2019 10:45:56 +0100
Message-ID: <20190329094556.wsdusg24ldy52ocw@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
 <20190315124717.x3do5evok5syipo7@verge.net.au>
 <20190315131435.GE9224@smile.fi.intel.com>
 <20190327135045.GE5345@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327135045.GE5345@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 27, 2019 at 02:50:45PM +0100, Wolfram Sang wrote:
> 
> > > > +		if (!ret)
> > > > +			timeout = 1;
> > > > +		else
> > > > +			timeout = 0;
> > > 
> > > 
> > > nit: the following might be cleaner
> > > 
> > > 		ret = !!timeout;
> > > 
> > 
> > Other way around, perhaps,
> > 
> >       timeout = !ret;
> 
> I saw that but didn't want to modify this patch. But yes, this is easy
> enough and looks a lot better.

Thanks, I don't think this needs to block progress.
