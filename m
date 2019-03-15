From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Date: Fri, 15 Mar 2019 15:14:35 +0200
Message-ID: <20190315131435.GE9224@smile.fi.intel.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
 <20190315124717.x3do5evok5syipo7@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190315124717.x3do5evok5syipo7@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 15, 2019 at 01:47:18PM +0100, Simon Horman wrote:
> On Sat, Mar 02, 2019 at 02:47:33PM +0100, Wolfram Sang wrote:

> > +	if (!polling) {
> > +		timeout = wait_for_completion_timeout(&omap->cmd_complete,
> > +						      OMAP_I2C_TIMEOUT);
> > +	} else {
> > +		do {
> > +			omap_i2c_wait(omap);
> > +			ret = omap_i2c_xfer_data(omap);
> > +		} while (ret == -EAGAIN);
> > +
> > +		if (!ret)
> > +			timeout = 1;
> > +		else
> > +			timeout = 0;
> 
> 
> nit: the following might be cleaner
> 
> 		ret = !!timeout;
> 

Other way around, perhaps,

      timeout = !ret;

> > +	}

-- 
With Best Regards,
Andy Shevchenko
