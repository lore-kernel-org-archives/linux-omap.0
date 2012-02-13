From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 3.3 v2] I2C: OMAP: fix build breakage when CONFIG_OF is
 not set
Date: Mon, 13 Feb 2012 23:27:07 +0000
Message-ID: <20120213232707.GH2999@freya.fluff.org>
References: <1328699901-19488-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328699901-19488-1-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 08, 2012 at 01:18:21PM +0200, Luciano Coelho wrote:
> Since commit 6145197 (i2c: OMAP: Add DT support for i2c controller),
> building i2c_omap.c breaks if CONFIG_OF is not set:
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
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
> v2: changed the commit log to use abbrev sha and include the commit subject
> 
>  drivers/i2c/busses/i2c-omap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f713eac..fd200eb 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -979,6 +979,8 @@ static const struct of_device_id omap_i2c_of_match[] = {
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> +#else
> +static const struct of_device_id *omap_i2c_of_match = NULL;
>  #endif

of_match_ptr(_ptr) will go to NULL if CONFIG_OF is not set, use that please.
