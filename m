From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: boot: dts: dra7: enable dwc3 suspend PHY quirk
Date: Thu, 15 Jan 2015 08:54:54 -0800
Message-ID: <20150115165454.GE18552@atomide.com>
References: <1421336283-17904-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12544 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbbAOQ6f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 11:58:35 -0500
Content-Disposition: inline
In-Reply-To: <1421336283-17904-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [150115 07:42]:
> Whenever Suspend PHY bit is set on DRA7x devices,
> USB will not work due to Set EP Configuration command
> always failing.
> 
> This was only found after a recent commit 2164a47 (usb:
> dwc3: set SUSPHY bit for all cores, which will be merged
> for v3.19) added a missing *required* step to dwc3
> initialization. Synopsys Databook requires that we enable
> Suspend PHY bit after initialization but that, unfortunately,
> breaks DRA7x.
> 
> Note that the same regression was already patched for AM437x.
> 
> Reported-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Tony, this fixes a regression with v3.19

OK applying into omap-for-v3.19/fixes thanks.

Tony
 
>  arch/arm/boot/dts/dra7.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 22771bc1643a..63f8b007bdc5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1257,6 +1257,8 @@
>  				tx-fifo-resize;
>  				maximum-speed = "super-speed";
>  				dr_mode = "otg";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> @@ -1278,6 +1280,8 @@
>  				tx-fifo-resize;
>  				maximum-speed = "high-speed";
>  				dr_mode = "otg";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> @@ -1299,6 +1303,8 @@
>  				tx-fifo-resize;
>  				maximum-speed = "high-speed";
>  				dr_mode = "otg";
> +				snps,dis_u3_susphy_quirk;
> +				snps,dis_u2_susphy_quirk;
>  			};
>  		};
>  
> -- 
> 2.2.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
