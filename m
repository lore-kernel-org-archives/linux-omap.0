From: tony@atomide.com
Subject: Re: [patch 2.6.20-rc5-omap] musb_hdrc, otg_state_string tweak
Date: Thu, 18 Jan 2007 14:21:27 -0800
Message-ID: <20070118222126.GC7362@atomide.com>
References: <20070118120558.9A6AC20DDBD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070118120558.9A6AC20DDBD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070118 04:06]:
> This provides a trivial definition of otg_state_string() for use
> in various WARNING() messages when debugging is not enabled.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Index: o26/drivers/usb/musb/plat_uds.c
> ===================================================================
> --- o26.orig/drivers/usb/musb/plat_uds.c	2007-01-18 03:06:34.000000000 -0800
> +++ o26/drivers/usb/musb/plat_uds.c	2007-01-18 03:11:35.000000000 -0800
> @@ -122,6 +122,15 @@ module_param(debug, uint, 0);
>  MODULE_PARM_DESC(debug, "initial debug message level");
>  
>  #define MUSB_VERSION_SUFFIX	"/dbg"
> +#else
> +
> +const char *otg_state_string(struct musb *musb)
> +{
> +	static char buf[8];
> +
> +	snprintf(buf, sizeof buf, "otg-%d", musb->xceiv.state);
> +	return buf;
> +}
>  #endif
>  
>  #define DRIVER_AUTHOR "Mentor Graphics, Texas Instruments, Nokia"

Pushed.

Tony
