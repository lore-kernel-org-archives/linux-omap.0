From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [GIT PULL] I2C: OMAP: major cleanup for v3.2 (was for v3.1)
Date: Wed, 24 Aug 2011 09:32:39 +0100
Message-ID: <20110824083239.GD27653@trinity.fluff.org>
References: <87sjorhepe.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87sjorhepe.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On Tue, Aug 23, 2011 at 04:48:29PM -0700, Kevin Hilman wrote:
> Ben,
> 
> This series fell through the cracks for v3.1, so I've now rebased it
> onto v3.1-rc3 and am submitting it for v3.2.  It no longer has any
> dependencies on OMAP trees, so could you please pull this into your tree
> for linux-next?   
> 
> A few more OMAP I2C series will be coming on top of this one.

Thanks, will do that tonight when preparing new -next.
 
> Thanks,
> 
> Kevin
> 
> 
> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 
>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/i2c-andy
> 
> Andy Green (12):
>       I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
>       I2C: OMAP: add rev to omap i2c platform data
>       I2C: OMAP1: set IP revision in platform data
>       I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when i2c bus added
>       I2C: OMAP2+: use platform_data ip revision to select register map
>       I2C: OMAP2+: Solve array bounds overflow error on i2c idle
>       I2C: OMAP2+: address confused probed version naming
>       I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
>       I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
>       I2C: OMAP1: set i2c unit feature implementation flags in platform data
>       I2C: OMAP2+: Convert omap I2C driver to use feature implementation flags from platform data
>       I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in dev_info
> 
>  arch/arm/plat-omap/i2c.c      |   27 +++++++++++
>  drivers/i2c/busses/i2c-omap.c |  100 ++++++++++++++++++++++------------------
>  include/linux/i2c-omap.h      |    2 +
>  3 files changed, 84 insertions(+), 45 deletions(-)

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
