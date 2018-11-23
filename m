From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] phy: mapphone-mdm6600: Improve phy related runtime
 PM calls
Date: Fri, 23 Nov 2018 08:58:38 -0800
Message-ID: <20181123165838.GF53235@atomide.com>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-3-tony@atomide.com>
 <ac3a7cdd-4f03-069f-844a-072e99759c83@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ac3a7cdd-4f03-069f-844a-072e99759c83@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [181123 07:59]:
> On 17/11/18 7:07 PM, Tony Lindgren wrote:
> > +	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
> > +	if (phy_pm_runtime_enabled(ddata->generic_phy))
> > +		phy_pm_runtime_put(ddata->generic_phy);
> 
> phy_*() API's are generally added to be used by the consumer driver. I guess in
> this case we can directly use pm_runtime_enabled(x).

OK sure that works for me too.

Regards,

Tony
