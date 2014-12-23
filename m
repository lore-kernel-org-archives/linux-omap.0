From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Tue, 23 Dec 2014 09:30:45 +0200
Message-ID: <54991A25.2030804@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:51473 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbaLWHas convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2014 02:30:48 -0500
In-Reply-To: <1419271535-4057-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Felipe,

On 12/22/14 20:05, Felipe Balbi wrote:

[...]

>  CONFIG_SCSI_SCAN_ASYNC=y
> -CONFIG_ATA=y
> -CONFIG_SATA_AHCI_PLATFORM=y
> -CONFIG_MD=y
> +CONFIG_ATA=m
> +CONFIG_SATA_AHCI_PLATFORM=m

Isn't this needed for the rootfs on SATA devices?

>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_ARC is not set
>  # CONFIG_NET_CADENCE is not set
> @@ -154,8 +151,8 @@ CONFIG_TI_CPSW=y
>  # CONFIG_NET_VENDOR_WIZNET is not set
>  CONFIG_AT803X_PHY=y
>  CONFIG_SMSC_PHY=y
> -CONFIG_USB_USBNET=y
> -CONFIG_USB_NET_SMSC95XX=y
> +CONFIG_USB_USBNET=m
> +CONFIG_USB_NET_SMSC95XX=m

What about the NFS root for boards with only USB eth?

[...]

>  CONFIG_DEBUG_GPIO=y
>  CONFIG_GPIO_SYSFS=y
> -CONFIG_GPIO_TWL4030=y
> -CONFIG_W1=y
> +CONFIG_GPIO_TWL4030=m

w/o this devices wired to twl gpios will not come up and likely
will miss the enumeration...

> -CONFIG_USB=y
> +CONFIG_HID_GENERIC=m
> +CONFIG_USB_HIDDEV=y
> +CONFIG_USB_KBD=m
> +CONFIG_USB_MOUSE=m
> +CONFIG_USB=m

So, you don't consider USB a valid rootfs storage option?

>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> -CONFIG_USB_MON=y
> +CONFIG_USB_MON=m
>  CONFIG_USB_XHCI_HCD=m
> -CONFIG_USB_WDM=y
> -CONFIG_USB_STORAGE=y
> +CONFIG_USB_WDM=m
> +CONFIG_USB_STORAGE=m
> +CONFIG_USB_MUSB_HDRC=m
> +CONFIG_USB_MUSB_OMAP2PLUS=m
> +CONFIG_USB_MUSB_AM35X=m
> +CONFIG_USB_MUSB_DSPS=m

[...]


-- 
Regards,
Igor.
