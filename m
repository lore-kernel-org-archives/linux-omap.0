From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] usb: dwc3: omap: fix race of pm runtime with irq
 handler in probe
Date: Mon, 12 Dec 2016 13:10:12 -0800
Message-ID: <20161212211012.GQ4920@atomide.com>
References: <20161212193752.32029-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161212193752.32029-1-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [161212 11:38]:
> Now races can happen between interrupt handler execution and PM runtime in
> error handling code path in probe and in dwc3_omap_remove() which will lead
> to system crash:
> 
> in probe:
> ...
>  err1:
> 	pm_runtime_put_sync(dev);
> ^^ PM runtime can race with IRQ handler when deferred probing happening
>    due to extcon
> 	pm_runtime_disable(dev);
> 
> 	return ret;
> 
> in dwc3_omap_remove:
> ...
> 	dwc3_omap_disable_irqs(omap);
> ^^ IRQs are disabled in HW, but handler may still run
> 	of_platform_depopulate(omap->dev);
> 	pm_runtime_put_sync(&pdev->dev);
> ^^ PM runtime can race with IRQ handler
> 	pm_runtime_disable(&pdev->dev);
> 
> 	return 0;
> 
> So, OMAP DWC3 IRQ need to be disabled before calling
> pm_runtime_put() in probe and in dwc3_omap_remove().

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
