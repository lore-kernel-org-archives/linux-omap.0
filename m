From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
	from driver
Date: Tue, 7 Jun 2011 14:41:51 +0100
Message-ID: <20110607134151.GE15795@trinity.fluff.org>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1306973984-15165-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 01, 2011 at 05:19:26PM -0700, Kevin Hilman wrote:
> Ben, 
> 
> Please pull in this series from Andy Green for the next merge window.

I'll have a look through this set as soon as possible.
 
> v4 is simply a rebase of Andy's v3 against v3.0-rc1 with some basic
> sanity testing against with the latest kernel.
> 
> It's also available here for pulling:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/i2c-andy
> 
> Original cover letter from Andy below:
> 
> The following series removes cpu_...() usage completely from the
> omap-i2c driver by having decisions about functional implementation
> choices in the SoC held in cpu-specific hwmod tables that are
> already established, or for OMAP1 where there is no hwmod, set at
> OMAP1-specific i2c bus addition time.
> 
> Along the way it solves two issues with the existing implementation,
> that only 16-bit accesses are documented to be allowed to the I2C
> peripheral unit, and that due to a confusion in the existing driver
> about whether it is faced with a newer IP version on OMAP3530, currently
> it writes to a random non-existent I2C register at times on that
> platform.
> 
> The patch series is quite extended from the first try thanks to
> comments from Benoit Cousson.
> 
> This 3rd try is based on 2.6.38-rc8 as requested.
> 
> Andy Green (18):
>   I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c
>   I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
>   I2C: OMAP2+: Introduce I2C IP versioning constants
>   I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
>   I2C: OMAP: add rev to omap i2c platform data
>   I2C: OMAP1: set IP revision in platform data
>   I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when i2c bus
>     added
>   I2C: OMAP2+: use platform_data ip revision to select register map
>   I2C: OMAP2+: Solve array bounds overflow error on i2c idle
>   I2C: OMAP2+: address confused probed version naming
>   I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
>   I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
>   I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
>   I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each
>     cpu_... test
>   I2C: OMAP2+: add correct functionality flags to all omap2plus i2c
>     dev_attr
>   I2C: OMAP1: set i2c unit feature implementation flags in platform
>     data
>   I2C: OMAP2+: Convert omap I2C driver to use feature implementation
>     flags from platform data
>   I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in
>     dev_info
> 
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    8 ++-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   13 ++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   18 ++++-
>  arch/arm/plat-omap/i2c.c                   |   27 ++++++++
>  arch/arm/plat-omap/include/plat/i2c.h      |    3 +-
>  drivers/i2c/busses/i2c-omap.c              |  100 +++++++++++++++-------------
>  include/linux/i2c-omap.h                   |   29 ++++++++
>  8 files changed, 153 insertions(+), 51 deletions(-)
> 
> -- 
> 1.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
