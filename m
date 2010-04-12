From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH] Add OHCI USB platform init
Date: Mon, 12 Apr 2010 11:03:28 +0530
Message-ID: <000101cada01$ae89f660$808918ac@apr.dhcp.ti.com>
References: <1271046713-10475-1-git-send-email-viral.mehta@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36663 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab0DLFde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 01:33:34 -0400
In-Reply-To: <1271046713-10475-1-git-send-email-viral.mehta@lntinfotech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: viral.mehta@lntinfotech.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

> +static struct omap_usb_config sdp2430_usb_config __initdata = {
> +       .otg            = 1,
> +#ifdef  CONFIG_USB_GADGET_OMAP
> +       .hmc_mode       = 0x0,
> +#elif   defined(CONFIG_USB_OHCI_HCD) ||
> defined(CONFIG_USB_OHCI_HCD_MODULE)
> +       .hmc_mode       = 0x1,
> +#endif
> +       .pins[0]        = 3,
> +}

Use tabs instead of spaces. 

> 
>  static void __init omap_2430sdp_init(void)
>  {
> @@ -216,6 +225,7 @@ static void __init omap_2430sdp_init(void)
>         platform_add_devices(sdp2430_devices,
> ARRAY_SIZE(sdp2430_devices));
>         omap_serial_init();
>         omap2_hsmmc_init(mmc);
> +       omap_usb_init(&sdp2430_usb_config);

And here too.

Maulik

