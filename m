From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] ehci: increase timeout to fix ehci failure
Date: Mon, 21 Sep 2009 18:10:10 -0700
Message-ID: <20090922011009.GJ27699@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com> <1249560460-16306-2-git-send-email-ajay.gupta@ti.com> <1249560460-16306-3-git-send-email-ajay.gupta@ti.com> <1249560460-16306-4-git-send-email-ajay.gupta@ti.com> <1249560460-16306-5-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58282 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZIVBKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 21:10:09 -0400
Content-Disposition: inline
In-Reply-To: <1249560460-16306-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 05:13]:
> Sometime during TLL reset and waiting loop for TLL reset timeouts and thus
> ehci init fails. Fixing this by increasing timeout value.

Applying patches 6 - 9 to ehci branch also.

Tony
 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/host/ehci-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 55e5259..c7631f5 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -244,7 +244,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
>   */
>  static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>  {
> -	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>  	unsigned reg = 0;
>  	int ret = 0;
>  
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
