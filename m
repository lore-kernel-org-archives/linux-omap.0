From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: Re: [PATCH] USB: set device dma_mask without reference to global
 data
Date: Wed, 08 May 2013 17:11:25 +1200
Message-ID: <5189DE7D.7060205@prisktech.co.nz>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367967232-10128-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 08/05/13 10:53, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Many USB host drivers contain code such as:
>
> if (!pdev->dev.dma_mask)
>          pdev->dev.dma_mask = &tegra_ehci_dma_mask;
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
> ---
In the case of uhci-platform you would be absolutely correct. I copied the
example from tegra when we first had the problem on arch-vt8500.Because we
have no NAND support yet, I have always booted myrootfs from USB so it's
always been builtin and the problem wasnever a problem. The same problem 
would
have existed on ehci-vt8500 but Arnd replaced it with ehci-platform due to
the multiplatform issues.

for uhci-platform.c
Acked-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>

Regards
Tony P
