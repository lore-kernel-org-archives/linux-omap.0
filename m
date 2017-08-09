From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: ehci-omap: fix error return code in ehci_hcd_omap_probe()
Date: Wed, 9 Aug 2017 10:03:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1708091002520.2109-100000@iolanthe.rowland.org>
References: <20170808222613.GA4796@embeddedgus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170808222613.GA4796@embeddedgus>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 8 Aug 2017, Gustavo A. R. Silva wrote:

> platform_get_irq() returns an error code, but the ehci-omap driver
> ignores it and always returns -ENODEV. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
> 
> Also, notice that platform_get_irq() no longer returns 0 on error:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
> ---
>  drivers/usb/host/ehci-omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 94ea9ff..4d30853 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -130,8 +130,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(dev, "EHCI irq failed\n");
> -		return -ENODEV;
> +		dev_err(dev, "EHCI irq failed: %d\n", irq);
> +		return irq;
>  	}
>  
>  	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
