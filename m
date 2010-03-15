From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH RESEND] omap3: Fix EHCI port for IGEP v2 board.
Date: Mon, 15 Mar 2010 18:03:23 +0200
Message-ID: <20100315160322.GB3879@gandalf>
References: <1267455756-5081-1-git-send-email-eballetbo@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50255 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965235Ab0COQC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 12:02:59 -0400
Content-Disposition: inline
In-Reply-To: <1267455756-5081-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi,

On Mon, Mar 01, 2010 at 04:02:36PM +0100, Enric Balletbo i Serra wrote:
> @@ -458,13 +458,13 @@ static struct omap_musb_board_data musb_board_data = {
>  };
>  
>  static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
> -	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> -	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>  	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>  
>  	.phy_reset = true,
> -	.reset_gpio_port[0] = -EINVAL,
> -	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
> +	.reset_gpio_port[0] = IGEP2_GPIO_USBH_NRESET,
> +	.reset_gpio_port[1] = -EINVAL,

no way to be backwards compatible ? Is it worth to be backwards
compatible ?

-- 
balbi

