From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global data
Date: Tue, 7 May 2013 16:04:45 -0700
Message-ID: <20130507230445.GC9105@kroah.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1367967232-10128-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 07, 2013 at 04:53:52PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Many USB host drivers contain code such as:
> 
> if (!pdev->dev.dma_mask)
>         pdev->dev.dma_mask = &tegra_ehci_dma_mask;
> 
> ... where tegra_ehci_dma_mask is a global. I suspect this code originated
> in commit 4a53f4e "USB: ehci-tegra: add probing through device tree" and
> was simply copied everywhere else.
> 
> This works fine when the code is built-in, but can cause a crash when the
> code is in a module. The first module load sets up the dma_mask pointer,
> but if the module is removed and re-inserted, the value is now non-NULL,
> and hence is not updated to point at the new location, and hence points
> at a stale location within the previous module load address, which in
> turn causes a crash if the pointer is de-referenced.
> 
> The simplest way of solving this seems to be to copy the code from
> ehci-platform.c, which uses the coherent_dma_mask as the target for the
> dma_mask pointer.
> 
> Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

So this needs to go in for 3.10, right?  Any older kernels as well?  If
so, which ones?

thanks,

greg k-h
