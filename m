From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/1] USB: ehci-omap: Reset dma_mask pointer on probe
Date: Thu, 23 May 2013 10:11:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305231009230.1459-100000@iolanthe.rowland.org>
References: <1369304387-29610-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369304387-29610-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 23 May 2013, Roger Quadros wrote:

> Device tree probed devices don't get dma_mask set. Previously
> we were setting the dma_mask pointer only if it was NULL.
> However, the address of 'omap_ehci_dma_mask' would change
> each time the module is unloaded and loaded back thus causing
> the devices dma_mask pointer to be invalid on the next load.
> 
> This will cause page faults if any driver tries to access the
> old dma_mask pointer.
> 
> Unconditionally re-setting the dma_mask pointer fixes this problem.

> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 3d1491b..b33e306 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -146,8 +146,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  	 * Since shared usb code relies on it, set it here for now.
>  	 * Once we have dma capability bindings this can go away.
>  	 */
> -	if (!pdev->dev.dma_mask)
> -		pdev->dev.dma_mask = &omap_ehci_dma_mask;
> +	pdev->dev.dma_mask = &omap_ehci_dma_mask;

Is this the solution that people have agreed on?  There has been a lot 
of discussion on this topic.  In particular, there has been talk about 
fixing it in the DT core.

This particular approach doesn't seem very robust.  What if 
pdev->dev.dma_mask is already set to a different value for some good 
reason?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
