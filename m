From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 12/12] USB: ehci-omap: Fix detection in HSIC mode
Date: Tue, 12 Mar 2013 16:21:07 +0530
Message-ID: <513F089B.5080004@ti.com>
References: <1363085090-24676-1-git-send-email-rogerq@ti.com>
 <1363085090-24676-13-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363085090-24676-13-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 12 March 2013 04:14 PM, Roger Quadros wrote:
> The HSIC devices need to be kept in reset while the EHCI controller
> is being initialized and only brought out of reset after the
> initialization is complete, else HSIC devices will not be detected.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> ---
>   drivers/usb/host/ehci-omap.c |   28 +++++++++++-----------------
>   1 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 1ba1df8..52a2d46 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -50,6 +50,7 @@
>   #include <linux/usb/hcd.h>
>   #include <linux/of.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/delay.h>

not needed here I guess.
>
>   #include "ehci.h"
>
> @@ -90,26 +91,13 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
>   static int omap_ehci_init(struct usb_hcd *hcd)
>   {
>   	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
> -	struct omap_hcd	*omap = (struct omap_hcd *)ehci->priv;
> -	int rc, i;
> -
> -	/* Hold PHYs in reset while initializing EHCI controller */
> -	for (i = 0; i < omap->nports; i++) {
> -		if (omap->phy[i])
> -			usb_phy_shutdown(omap->phy[i]);
> -	}
> +	int rc;
>
>   	/* we know this is the memory we want, no need to ioremap again */
>   	ehci->caps = hcd->regs;
>
>   	rc = ehci_setup(hcd);
>
> -	/* Bring PHYs out of reset */
> -	for (i = 0; i < omap->nports; i++) {
> -		if (omap->phy[i])
> -			usb_phy_init(omap->phy[i]);
> -	}
> -
>   	return rc;
>   }
>
> @@ -219,9 +207,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>   		}
>
>   		omap->phy[i] = phy;
> -		usb_phy_init(omap->phy[i]);
> -		/* bring PHY out of suspend */
> -		usb_phy_set_suspend(omap->phy[i], 0);
>   	}
>
>   	pm_runtime_enable(dev);
> @@ -245,6 +230,15 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>   		goto err_pm_runtime;
>   	}
>
> +	/* Bring PHYs out of reset */
> +	for (i = 0; i < omap->nports; i++) {
> +		if (!omap->phy[i])
> +			continue;
> +
> +		usb_phy_init(omap->phy[i]);
> +		/* bring PHY out of suspend */
> +		usb_phy_set_suspend(omap->phy[i], 0);
> +	}

But isn't HSIC supposed to be PHYless devices. Maybe a comment 
explaining it might be helpful.

Thanks
Kishon
