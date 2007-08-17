From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: MUSB: fix compile for non-OTG modes
Date: Fri, 17 Aug 2007 00:18:37 -0700
Message-ID: <20070817071836.GB4676@atomide.com>
References: <20070816181801.798599625@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070816181801.798599625@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070816 11:18]:
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> ---
>  drivers/usb/musb/plat_uds.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: pristine/drivers/usb/musb/plat_uds.c
> ===================================================================
> --- pristine.orig/drivers/usb/musb/plat_uds.c
> +++ pristine/drivers/usb/musb/plat_uds.c
> @@ -737,9 +737,11 @@ static irqreturn_t musb_stage2_irq(struc
>  		handled = IRQ_HANDLED;
>  
>  		switch (musb->xceiv.state) {
> +#ifdef	CONFIG_USB_MUSB_OTG
>  		case OTG_STATE_A_PERIPHERAL:
>  			musb_hnp_stop(musb);
>  			break;
> +#endif
>  		case OTG_STATE_B_PERIPHERAL:
>  			musb_g_suspend(musb);
>  			musb->is_active = is_otg_enabled(musb)

Thanks, pushing today.

Tony
