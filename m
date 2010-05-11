From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c-omap patches for 2.6.35 merge window
Date: Wed, 12 May 2010 00:10:47 +0100
Message-ID: <20100511231047.GB31325@fluff.org.uk>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100511182854.15596.56293.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 11, 2010 at 11:35:01AM -0700, Tony Lindgren wrote:
> Hi all,
> 
> Here are the i2c-omap patches that we'd like to get in for 2.6.35.
> 
> I believe all of these patches have been posted earlier already
> to the i2c list. They all have been merged into the linux-omap master
> branch for testing. 
> 
> I've removed some duplicate Cc fields from the commit messages
> for the obvious mailings lists and the people who will be merging
> them.
> 
> Anyways, if no comments over the next few days, I'll reply to
> this message with a pull request for Ben.

I've applied these to for-2635/i2c-omap to get them into -next

please keep the start of each commit the same, I prefer i2c-omap:

thanks.
 
> Regards,
> 
> Tony
> 
> ---
> 
> Alexander Shishkin (2):
>       omap: i2c: make errata 1.153 workaround a separate function
>       omap: i2c: add a timeout to the busy waiting
> 
> Kalle Jokiniemi (1):
>       i2c-omap: add mpu wake up latency constraint in i2c
> 
> Santosh Shilimkar (1):
>       omap: i2c: Add i2c support on omap4 platform
> 
> manjugk manjugk (2):
>       OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
>       OMAP3: I2C: Clean up Errata 1p153 handling
> 
> 
>  arch/arm/plat-omap/i2c.c      |   39 ++++--
>  drivers/i2c/busses/i2c-omap.c |  265 ++++++++++++++++++++++++++++++++---------
>  include/linux/i2c-omap.h      |    9 +
>  3 files changed, 246 insertions(+), 67 deletions(-)
>  create mode 100644 include/linux/i2c-omap.h
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
