From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: ehci-omap: Fix build break
Date: Tue, 22 Sep 2009 10:12:20 -0700
Message-ID: <20090922171220.GF14890@atomide.com>
References: <20090922151140.GB8975@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56084 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZIVRMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:12:24 -0400
Content-Disposition: inline
In-Reply-To: <20090922151140.GB8975@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [090922 07:55]:
> Fix build break:
> 
>   CC      drivers/usb/host/ehci-hcd.o
> In file included from drivers/usb/host/ehci-hcd.c:1101:
> drivers/usb/host/ehci-omap.c: In function 'omap_start_ehc':
> drivers/usb/host/ehci-omap.c:238: error: 'CHIP_GE_OMAP3430ES3' undeclared (first use in this function)
> drivers/usb/host/ehci-omap.c:238: error: (Each undeclared identifier is reported only once
> drivers/usb/host/ehci-omap.c:238: error: for each function it appears in.)
> make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
> 
> 
> No reference to CHIP_GE_OMAP3430ES3 anywhere else, I'm assuming it's
> ES3_1 that's supposed to be used.

I'm dropping the "ehci: Support for ES3.x" patch instead for now
until it's fixed to use the omap_rev().

So this should not be needed.

Tony 
 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index f77a99d..301e7b6 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -235,7 +235,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
>   */
>  static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>  {
> -	struct omap_chip_id oci = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3);
> +	struct omap_chip_id oci = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1);
>  	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>  	u8 tll_ch_mask = 0;
>  	unsigned reg = 0;
