From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: git-pull request for i2c-omap updates (Re: [PATCH 00/12]
	Updates for i2c-omap for 2.6.29 merge window, v5)
Date: Fri, 5 Dec 2008 00:25:15 +0000
Message-ID: <20081205002515.GD4256@fluff.org.uk>
References: <20081129013318.13428.88465.stgit@localhost> <20081129015611.GK6640@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081129015611.GK6640-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 28, 2008 at 05:56:12PM -0800, Tony Lindgren wrote:
> Ben,
> 
> Here's the pull request for you.
> 
> Regards,
> 
> Tony

> The following changes since commit 13d428afc007fcfcd6deeb215618f54cf9c0cae6:
>   Linus Torvalds (1):
>         Linux 2.6.28-rc6
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git i2c-for-ben
> 
> Chandra shekhar (1):
>       i2c-omap: Add support for omap34xx
> 
> Jarkko Nikula (1):
>       i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg
> 
> Kalle Jokiniemi (1):
>       i2c-omap: Enable I2C wakeups for 34xx
> 
> Nishanth Menon (1):
>       i2c-omap: FIFO handling support and broken hw workaround for i2c-omap
> 
> Paul Walmsley (6):
>       i2c-omap: Close suspected race between omap_i2c_idle() and omap_i2c_isr()
>       i2c-omap: Mark init-only functions as __init
>       i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
>       i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
>       i2c-omap: convert 'rev1' flag to generic 'rev' u8
>       i2c-omap: reprogram OCP_SYSCONFIG register after reset
> 
> Syed Mohammed Khasim (1):
>       i2c-omap: Add high-speed support to omap-i2c
> 
> Tony Lindgren (1):
>       i2c-omap: Clean-up i2c-omap
> 
>  arch/arm/mach-omap2/clock24xx.h |    4 +-
>  drivers/i2c/busses/i2c-omap.c   |  420 ++++++++++++++++++++++++++++++---------
>  2 files changed, 330 insertions(+), 94 deletions(-)

Ok, i've had a look through and most of these pass a quick review,,
will do a full review in the next day or so.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
