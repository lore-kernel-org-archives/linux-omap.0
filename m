From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ehci: update driver with generic change
Date: Mon, 21 Sep 2009 17:51:39 -0700
Message-ID: <20090922005138.GF27699@atomide.com>
References: <1247235920-13400-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51901 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZIVAvg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 20:51:36 -0400
Content-Disposition: inline
In-Reply-To: <1247235920-13400-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

* Ajay Kumar Gupta <ajay.gupta@ti.com> [090710 07:25]:
> Update the OMAP EHCI driver in accordance with below patch
> introduced in generic EHCI driver.
> 
> commit: b18ffd49e86102a9ed0a1cc83fdafe3891e844e5
> USB: EHCI: update toggle state for linked QHs

Adding this to ehci branch.

Tony
 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index c0f9a19..858bf11 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -762,6 +762,7 @@ static const struct hc_driver ehci_omap_hc_driver = {
>  	.urb_enqueue		= ehci_urb_enqueue,
>  	.urb_dequeue		= ehci_urb_dequeue,
>  	.endpoint_disable	= ehci_endpoint_disable,
> +	.endpoint_reset		= ehci_endpoint_reset,
>  
>  	/*
>  	 * scheduling support
> -- 
> 1.6.2.4
> 
