From: Greg KH <greg@kroah.com>
Subject: Re: [RFC v2 6/8] TILER-DMM: Geometry and view manipulation
 functions
Date: Tue, 30 Nov 2010 16:55:49 -0800
Message-ID: <20101201005549.GB29171@kroah.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
 <1291147139-23472-7-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291147139-23472-7-git-send-email-davidsin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 01:58:57PM -0600, David Sin wrote:
> From: Lajos Molnar <molnar@ti.com>
> 
> This patch contains information on TILER geometry, as well as
> tiler_view_t object manipulation functions.
> 
> It also contains an internal TILER header file to share geometric
> information with other TILER files.
> 
> Signed-off-by: Lajos Molnar <molnar@ti.com>
> Signed-off-by: David Sin <davidsin@ti.com>
> ---
>  drivers/misc/tiler/_tiler.h     |   48 +++++

Ick, no, just name it "tiler.h" please.  There should not be any need to
put _ in front of a .h file.

> +u32 tiler_bpp(const struct tiler_block_t *b)
> +{
> +	enum tiler_fmt fmt = tiler_fmt(b->phys);
> +	BUG_ON(fmt == TILFMT_INVALID || fmt == TILFMT_PAGE);

Don't cause the kernel to crash within a driver for no good reason like
this.  Please fix these to WARN_ON if it's really something that can
happen.

If not, then just remove it.

> +
> +	return geom[fmt].bpp;
> +}
> +EXPORT_SYMBOL(tiler_bpp);

EXPORT_SYMBOL_GPL() perhaps for all of these?

thanks,

greg k-h
