From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure USB host for 37xx-evm
Date: Wed, 24 May 2017 09:25:27 -0700
Message-ID: <20170524162526.GA10472@atomide.com>
References: <20170522160647.9606-1-tony@atomide.com>
 <921f6aa1-d410-0942-6ddd-692377acb349@ti.com>
 <20170523141901.GW10472@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170523141901.GW10472-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170523 07:22]:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [170523 00:40]:
> > > +		gpio-hog;
> > > +		gpios = <29 GPIO_ACTIVE_HIGH>;
> > 
> > Should this be be GPIO_61?
> 
> Oh that seems wrong, thanks for noticing it. Will check.

Heh that's already at &gpio2, so it is gpio_61.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
