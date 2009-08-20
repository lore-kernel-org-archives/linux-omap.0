From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c-omap: I2C clean-up patch
Date: Thu, 20 Aug 2009 22:21:45 +0100
Message-ID: <20090820212145.GB13455@fluff.org.uk>
References: <1250785276-31713-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1250785276-31713-1-git-send-email-m-sonasath-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 20, 2009 at 11:21:13AM -0500, Moiz Sonasath wrote:
> This patch includes the following fixes:
> -Fix I2C status ACK
> -ACK pending [R/X]DR and [R/X]RDY interrupts in the error/completeion path
> -Enable workaround for Errata 1.153 based on I2C IP block

ok, will add these to my fixes tree.
 
> Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> 
> Moiz Sonasath (3):
>   i2c-omap: Fix I2C status ACK
>   i2c-omap: ACK pending [R/X]DR and [R/X]RDY interrupts in the
>     error/completeion path
>   i2c-omap: Enable workaround for Errata 1.153 based on I2C IP block
> 
>  drivers/i2c/busses/i2c-omap.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
