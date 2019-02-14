From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl6040: Fix device init errors for ACCCTL register
Date: Thu, 14 Feb 2019 08:03:02 -0800
Message-ID: <20190214160302.GE5720@atomide.com>
References: <20190211225726.38355-1-tony@atomide.com>
 <20190214092045.GD13737@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214092045.GD13737@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [190214 09:21]:
> On Mon, 11 Feb 2019, Tony Lindgren wrote:
> > +		ret = regcache_sync(twl6040->regmap);
> > +		if (ret) {
> > +			dev_err(twl6040->dev, "%s register write failed: %i\n",
> > +				__func__, ret);
> 
> Please drop the __func__ and just use the standard format.
> 
> Wouldn't something a little more forthcoming be better?
> 
> "Failed to sync with the HW" ?

Sure I'll send an updated patch.

Regards,

Tony
