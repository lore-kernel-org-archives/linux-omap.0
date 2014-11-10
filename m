From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: boot: dts: am4372: enable dwc3 suspend PHY quirk
Date: Mon, 10 Nov 2014 15:11:32 -0800
Message-ID: <20141110231132.GA31454@atomide.com>
References: <1415295366-593-1-git-send-email-balbi@ti.com>
 <1415295366-593-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18319 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751477AbaKJXMR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 18:12:17 -0500
Content-Disposition: inline
In-Reply-To: <1415295366-593-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [141106 09:40]:
> Whenever Suspend PHY bit is set on AM437x devices,
> USB will not work due to Set EP Configuration command
> always failing.
> 
> This was only found after a recent commit 2164a47 (usb:
> dwc3: set SUSPHY bit for all cores, which will be merged
> for v3.19) added a missing *required* step to dwc3
> initialization. Synopsys Databook requires that we enable
> Suspend PHY bit after initialization but that, unfortunately,
> breaks AM437x.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

This should be safe to queue along with the related USB
changes:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am4372.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 46660ff..e19068d 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -817,6 +817,8 @@
>  				maximum-speed = "high-speed";
>  				dr_mode = "otg";
>  				status = "disabled";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> @@ -839,6 +841,8 @@
>  				maximum-speed = "high-speed";
>  				dr_mode = "otg";
>  				status = "disabled";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> -- 
> 2.1.0.GIT
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
