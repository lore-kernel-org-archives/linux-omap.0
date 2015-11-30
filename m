From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Mon, 30 Nov 2015 14:34:50 -0800
Message-ID: <20151130223449.GK23396@atomide.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-5-git-send-email-vigneshr@ti.com>
 <20151130220102.GG23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151130220102.GG23396-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151130 14:03]:
> * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [151129 21:16]:
> > Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> > update the binding documents for the controller to document this change.
> > 
> > Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> > ---
> > 
> > v4: No changes.
> 
> OK I'll apply patches 4 and 5 of this series into omap-for-v4.5/dt thanks.
> The rest should get merged via the MTD tree.

Actually ddropping them after looking at the IO ranges like I commented.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
