From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH RFC 1/2] usb: ehci-omap: factor out clock handling
Date: Thu, 13 May 2010 23:01:01 +0300
Message-ID: <20100513200100.GB19318@gandalf>
References: <1273762822-23073-1-git-send-email-gadiyar@ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1273762822-23073-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 13, 2010 at 08:30:21PM +0530, Anand Gadiyar wrote:
> @@ -190,6 +190,23 @@ struct ehci_hcd_omap {
>  
>  /*-------------------------------------------------------------------------*/
>  
> +static void ehci_omap_clock_power(struct ehci_hcd_omap *omap, int on)
> +{
> +	if (on) {
> +		clk_enable(omap->usbtll_ick);
> +		clk_enable(omap->usbtll_fck);
> +		clk_enable(omap->usbhost_ick);
> +		clk_enable(omap->usbhost1_48m_fck);
> +		clk_enable(omap->usbhost2_120m_fck);
> +	} else {
> +		clk_disable(omap->usbhost2_120m_fck);
> +		clk_disable(omap->usbhost1_48m_fck);
> +		clk_disable(omap->usbhost_ick);
> +		clk_disable(omap->usbtll_fck);
> +		clk_disable(omap->usbtll_ick);
> +	}
> +}

this is sure useful, but it prevents from turning off interface clocks
while we don't need them. AFAICT, we only need interface clocks when we
need to read/write registers. And having a this functions makes things
more difficult to implement that sort of PM optmizations.

Functional clocks should be kept alive for as long as the driver is
probed and not suspended, true. But for the interface clocks we could
enable them dynamicaly when talking to specific register bases. I think
runtime pm can help with that, no ???

Ideally, when you reach suspend, all the activity on the device should
have already stopped, so you'd only need to disable the functional
clocks because interface clocks would have already been disabled due to
not needing them basically. Just needs some investigation on how long
does it take for the clock to actually stabilize and if enabling for
each register read/write is good or bad. IOW, you just need to check
which granularity we need for controlling interface clocks.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
