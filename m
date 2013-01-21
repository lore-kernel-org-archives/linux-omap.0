From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
Date: Mon, 21 Jan 2013 15:18:44 +0200
Message-ID: <50FD4034.5040402@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com> <1358348462-27693-7-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358348462-27693-7-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, balbi@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, horms@verge.net.au, magnus.damm@gmail.com, cbou@mail.ru, dwmw2@infradead.org, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, leoli@freescale.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, stern@rowland.harvard.edu
List-Id: linux-omap@vger.kernel.org

On 01/16/2013 05:01 PM, Kishon Vijay Abraham I wrote:
> The OMAP glue has been modified to get PHY by phandle for dt boot.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/musb/omap2430.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3628a50..08709cf 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -346,7 +346,12 @@ static int omap2430_musb_init(struct musb *musb)
>  	 * up through ULPI.  TWL4030-family PMICs include one,
>  	 * which needs a driver, drivers aren't always needed.
>  	 */
> -	musb->xceiv = devm_usb_get_phy(dev, 0);
> +	if (dev->parent->of_node)
> +		musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
> +		    "usb_phy", 0);

Why dev->parent and not just dev?

> +	else
> +		musb->xceiv = devm_usb_get_phy(dev, 0);
> +
>  	if (IS_ERR_OR_NULL(musb->xceiv)) {
>  		pr_err("HS USB OTG: no transceiver configured\n");
>  		return -ENODEV;
> 

--
cheers,
-roger
