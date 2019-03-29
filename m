From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH v2 3/7] i2c: core: introduce callbacks for atomic
 transfers
Date: Fri, 29 Mar 2019 10:45:19 +0100
Message-ID: <20190329094519.nc2qwpcja3k4e5il@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-4-wsa+renesas@sang-engineering.com>
 <20190315122320.34yibpfhv2b6ptwl@verge.net.au>
 <20190327134751.GD5345@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327134751.GD5345@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On Wed, Mar 27, 2019 at 02:47:51PM +0100, Wolfram Sang wrote:
> Hi Simon,
> 
> please delete unrelated text. I nearly missed the typo fix later.

Ack, will do.

> > > -	if (in_atomic() || irqs_disabled())
> > > +	if (in_atomic() || irqs_disabled()) {
> > > +		WARN(!adap->algo->master_xfer_atomic && !adap->algo->smbus_xfer_atomic,
> > > +		     "No atomic I2C transfer handler for '%s'\n", dev_name(&adap->dev));
> > 
> > 		Is WARN_ONCE more appropriate here?
> 
> Why? It could be multiple adapters or clients causing this?

Good point. I am concerned about the presence of a case which
causes a logging storm.

...
