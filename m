From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global
 data
Date: Wed, 8 May 2013 10:14:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305081011480.1450-100000@iolanthe.rowland.org>
References: <201305080142.12025.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201305080142.12025.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 8 May 2013, Arnd Bergmann wrote:

> On Wednesday 08 May 2013, Greg Kroah-Hartman wrote:
> > On Tue, May 07, 2013 at 04:53:52PM -0600, Stephen Warren wrote:
> > > From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> > > Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > > Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > 
> > So this needs to go in for 3.10, right?  Any older kernels as well?  If
> > so, which ones?
> 
> The fix should definitely go into 3.10, but I'd suggest waiting with
> the backport for a couple of -rc releases to avoid possible regressions.
> We know that the current code is broken, but few people fully understand
> what is going on with coherent_dma_mask, so it might cause new problems
> in combination with some other unknown bug, and I don't see this as
> urgent: none of the ARM defconfigs build this driver as a loadable
> module and there is no bug in the built-in case. For some reason, only
> the ARM back-end drivers are broken.
> 
> The first occurence was apparently in 3.3, but only in ehci-tegra.c,
> while the other drivers subsequently copied the bug.

An alternative solution -- perhaps not better but also not relying on
coherent_dma_mask -- is to clear pdev->dev.dma_mask in the remove
routine if it points to the static mask value.

Alan Stern
