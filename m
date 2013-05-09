From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global
	data
Date: Thu, 9 May 2013 22:33:49 +0100
Message-ID: <20130509213349.GN21614@n2100.arm.linux.org.uk>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org> <20130507230445.GC9105@kroah.com> <201305080142.12025.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201305080142.12025.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 08, 2013 at 01:42:11AM +0200, Arnd Bergmann wrote:
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

I've already suggested this approach:

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index dc662fc..51bb740 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 struct omap_device;
 
 struct pdev_archdata {
+	u64 dma_mask;
 #ifdef CONFIG_ARCH_OMAP
 	struct omap_device *od;
 #endif

And then we can have dev->dma_mask pointed at that instead, which fully
eliminates any possible problems of things like dma_set_mask() interfering
with dma_set_coherent_mask().

Even better - because this is a common problem - would be to make 'dma_mask'
be a member of struct platform_device so that all arches can sort this
out once and for all (correction: generic code/drivers can in an arch-
independent way.)  IOW:

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9abf1db..121c74c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -26,6 +26,7 @@ struct platform_device {
 	struct device	dev;
 	u32		num_resources;
 	struct resource	*resource;
+	u64		dma_mask;
 
 	const struct platform_device_id	*id_entry;
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
