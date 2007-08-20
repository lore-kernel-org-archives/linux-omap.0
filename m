From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: MUSB: IRQ reset: babble handling is host only
Date: Mon, 20 Aug 2007 01:37:00 -0700
Message-ID: <20070820083700.GE16454@atomide.com>
References: <20070817164724.560795636@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070817164724.560795636@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070817 09:48]:
> In reset IRQ, move babble handling inside a host-ifdef since it
> doesn't apply (or compile) for gadget.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> ---
>  drivers/usb/musb/plat_uds.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: dev/drivers/usb/musb/plat_uds.c
> ===================================================================
> --- dev.orig/drivers/usb/musb/plat_uds.c
> +++ dev/drivers/usb/musb/plat_uds.c
> @@ -604,6 +604,7 @@ static irqreturn_t musb_stage0_irq(struc
>  	 * only host sees babble; only peripheral sees bus reset.
>  	 */
>  	if (int_usb & MUSB_INTR_RESET) {
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
>  		if (devctl & MUSB_DEVCTL_HM) {
>  			/*
>  			 * Looks like non-HS BABBLE can be ignored, but
> @@ -618,7 +619,9 @@ static irqreturn_t musb_stage0_irq(struc
>  				ERR("Stopping host session because of babble\n");
>  				musb_writeb(mbase, MUSB_DEVCTL, 0);
>  			}
> -		} else {
> +		} else
> +#endif	/* CONFIG_USB_MUSB_HDRC_HCD */
> +		{
>  			DBG(1, "BUS RESET\n");
>  
>  			musb_g_reset(musb);

Thanks, pushing today.

Tony
