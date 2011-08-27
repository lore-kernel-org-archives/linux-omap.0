From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 08:13:17 -0700
Message-ID: <20110827151317.GA10013@kroah.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314456515-16419-1-git-send-email-ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 27, 2011 at 10:48:35PM +0800, ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org wrote:
> From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> 
> This patch fixs one performance bug on ARM Cortex A9 dual core platform,
> which has been reported on quite a few ARM machines(OMAP4, Tegra 2, snowball...),
> see details from link of https://bugs.launchpad.net/bugs/709245.
> 
> In fact, one mb() on ARM is enough to flush L2 cache, but
> 'dummy->hw_token = token;' after mb() is added just for obeying
> correct mb() usage.

Really?  A mb() should not be flushing any caches, it's just a memory
barrier.  Or is ARM somehow "special" in this way?

> The patch has been tested ok on OMAP4 panda A1 board, the performance
> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
> 14~16MB/sec after applying this patch.

That's impressive, but I don't think this is really the proper way to do
this...

> Signed-off-by: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> ---
>  drivers/usb/host/ehci-q.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 0917e3a..65b5021 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>  			wmb ();
>  			dummy->hw_token = token;
>  
> +			/* The mb() below is added to make sure that
> +			 * 'token' can be writen into qtd, so that ehci
> +			 * HC can see the up-to-date qtd descriptor. On
> +			 * some archs(at least on ARM Cortex A9 dual core),
> +			 * writing into coherenet memory doesn't mean the
> +			 * value written can reach physical memory
> +			 * immediately, and the value may be buffered
> +			 * inside L2 cache. 'dummy->hw_token = token;'
> +			 * after mb() is added for obeying correct mb()
> +			 * usage.
> +			 * */
> +			mb();
> +			token = dummy->hw_token;

Your comment does not match the code, so something is wrong here.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
