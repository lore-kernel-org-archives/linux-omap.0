From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: fix build breakage when CONFIG_OF is not set
Date: Wed, 08 Feb 2012 13:01:28 +0200
Message-ID: <1328698888.20197.50.camel@cumari>
References: <1328698612-18661-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328698612-18661-1-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2012-02-08 at 12:56 +0200, Luciano Coelho wrote: 
> Since commit 6145197be6cc0583fa1a2f4ec1079d366137061e, building
> i2c_omap.c breaks if CONFIG_OF is not set:
> 
> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
> drivers/i2c/busses/i2c-omap.c:1021: error: 'omap_i2c_of_match' undeclared (first use in this function)
> drivers/i2c/busses/i2c-omap.c:1021: error: (Each undeclared identifier is reported only once
> drivers/i2c/busses/i2c-omap.c:1021: error: for each function it appears in.)
> 
> This is because the definition of omap_i2c_of_match is #ifdef'd on
> CONFIG_OF, but the usage of it is not.
> 
> Since the places where omap_ic2_of_match are prepared to get NULL
> pointers if CONFIG_OF is not defined, we can simply define it to NULL.
> 
> Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
> ---

Forgot to say that I think this should go into 3.3, since it's a build
break.

-- 
Cheers,
Luca.
