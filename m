From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 6/8] usb: ehci-omap: add helpers for checking port
 mode
Date: Tue, 30 Nov 2010 15:25:50 +0300
Message-ID: <4CF4ED4E.1080707@ru.mvista.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com> <1291051537-23743-7-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52395 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab0K3M1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 07:27:44 -0500
In-Reply-To: <1291051537-23743-7-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>

Hello.

On 29-11-2010 20:25, Anand Gadiyar wrote:

> Introduce helper functions to test port mode. These checks are
> performed in several places in the driver, and these helpers
> improve readability.

> Signed-off-by: Anand Gadiyar<gadiyar@ti.com>
[...]

> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 7a4682c..dd9d5c1 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
[...]
> @@ -387,27 +390,27 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>   	/* Bypass the TLL module for PHY mode operation */
>   	if (cpu_is_omap3430()&&  (omap_rev()<= OMAP3430_REV_ES2_1)) {
>   		dev_dbg(omap->dev, "OMAP3 ES version<= ES2.1\n");
> -		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
> -			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
> -				(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
> +		if (is_ehci_phy_mode(omap->port_mode[0]) ||
> +			is_ehci_phy_mode(omap->port_mode[1]) ||
> +				is_ehci_phy_mode(omap->port_mode[2]))

    Why there's another indentation level whenre there shouldn't be one?

WBR, Sergei
