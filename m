From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] usb: ehci-omap: fix Si version related programming
Date: Wed, 5 May 2010 21:31:02 +0300
Message-ID: <20100505183102.GA2274@gandalf>
References: <1272959123-31362-1-git-send-email-ajay.gupta@ti.com>
 <1272959123-31362-2-git-send-email-ajay.gupta@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35066 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852Ab0EESaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:30:23 -0400
Content-Disposition: inline
In-Reply-To: <1272959123-31362-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Tue, May 04, 2010 at 01:15:23PM +0530, Ajay Kumar Gupta wrote:
> @@ -352,8 +352,8 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>  		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
>  
>  	/* Bypass the TLL module for PHY mode operation */
> -	 if (omap_rev() <= OMAP3430_REV_ES2_1) {
> -		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1 \n");
> +	if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
> +		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");

this shouldn't be here. please pass down a flag through platform_data
for such checks.

-- 
balbi
