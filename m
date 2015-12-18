From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Fri, 18 Dec 2015 08:42:00 -0800
Message-ID: <20151218164200.GM23396@atomide.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-5-git-send-email-vigneshr@ti.com>
 <20151211150935.GA15654@rob-hp-laptop>
 <20151217184557.GC23396@atomide.com>
 <56739EB4.6040804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56739EB4.6040804-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [151217 21:51]:
> 
> 
> On 12/18/2015 12:15 AM, Tony Lindgren wrote:
> > * Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [151211 07:10]:
> >> On Fri, Dec 11, 2015 at 09:39:59AM +0530, Vignesh R wrote:
> >>> Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> >>> update the binding documents for the controller to document this change.
> >>>
> >>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> >>
> >> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > 
> > Vignes, are patches 4 and 5 safe to apply separately already or
> > do things break if we do that?
> 
> Yes, 4 and 5 can be applied separately w/o driver changes.

OK picking 4 and 5 into omap-for-v4.5/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
