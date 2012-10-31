From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND PATCH 05/11] ARM: OMAP: USB: Host: usb host Device
 tree node Adaptation
Date: Wed, 31 Oct 2012 11:29:03 -0700
Message-ID: <20121031182903.GN12739@atomide.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
 <1351693612-23314-6-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351693612-23314-6-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org> [121031 07:29]:
> The USB2 Host device node is extracted and used in the probe
> of the driver to initialize the usb ports and controller. The
> platform specific initialization is also performed.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/usb-host.c         |    2 -
>  drivers/mfd/omap-usb-host.c            |  163 +++++++++++++++++++++++---------
>  include/linux/platform_data/usb-omap.h |   19 +++-
>  3 files changed, 133 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index d1dbe12..239c175 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -502,8 +502,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
>  	}
>  	ehci_data.phy_reset = pdata->phy_reset;
>  	ohci_data.es2_compatibility = pdata->es2_compatibility;
> -	usbhs_data.ehci_data = &ehci_data;
> -	usbhs_data.ohci_data = &ohci_data;
>  
>  	if (cpu_is_omap34xx()) {
>  		setup_ehci_io_mux(pdata->port_mode);

Just checking.. Have you tested that these patches also
still work without device tree?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
