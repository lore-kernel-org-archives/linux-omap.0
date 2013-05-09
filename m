From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global
	data
Date: Thu, 9 May 2013 22:39:08 +0100
Message-ID: <20130509213908.GP21614@n2100.arm.linux.org.uk>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org> <5189B7BF.8070607@wwwdotorg.org> <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com> <201305080924.44622.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201305080924.44622.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 08, 2013 at 09:24:44AM +0200, Arnd Bergmann wrote:
> It probably should. The main thing is that the dma_mask setting in
> of_platform (and elsewhere) is a mess and that nobody so far had the
> guts to try to get it right for good.
> 
> Setting a 32 bit DMA mask is /probably/ the right default on all
> ARM systems, but there are caveats:
> 
> - Once you get to systems with larger than 32 bit addressing (powerpc64,
>   arm64, arm32 with LPAE), it's not so obvious: you may have some devices
>   that need a 32 bit mask and some that need a 64 bit mask.

This is precisely why drivers should be using dma_set_mask() and the
coherent version to provide the mask for which the driver knows about
- iow, if the device itself is only capable of 32-bit DMA, then the
device must use dma_set_mask(dev, DMA_BIT_MASK(32)).
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
