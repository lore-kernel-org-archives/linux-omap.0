From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global
 data
Date: Wed, 08 May 2013 16:42:04 -0600
Message-ID: <518AD4BC.6090009@wwwdotorg.org>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org> <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com> <5189B7BF.8070607@wwwdotorg.org> <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/07/2013 08:54 PM, Peter Chen wrote:
>>
>> This probably could be initialized from some DT property. However,
>> there's no such property defined right now, and considering that DT is
>> supposed to be an ABI, we'd always need the code in this patch as a
>> fallback for DTs that were created before any such property was defined.
>>
>> Equally, since the data is SoC-specific rather than board-specific, and
>> is even fairly unlikely to vary between SoC versions since these values
>> are all 0xffffffff anyway, I don't really see much point in putting it
>> into DT, rather than just putting the static data into the driver.
> 
> I mean there is already dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> at function of_platform_device_create, why can't add
> dev->dev.dma_mask = &dev->dev.coherent_dma_mask after that?
> 
> If DT core can do above things, can we delete dma_mask assignment
> at every driver?

Perhaps. However, such a change has a much larger potential for regressions.

I would suggest going with the current patch for 3.10 and any later
backports in order to reduce risk. We can revisit better cleanup for
later kernels.
