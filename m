From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP2420: Correct H4 board memory size
Date: Fri, 14 Dec 2012 14:50:48 -0800
Message-ID: <20121214225048.GO4989@atomide.com>
References: <1355517258-30745-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24842 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756226Ab2LNWuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 17:50:51 -0500
Content-Disposition: inline
In-Reply-To: <1355517258-30745-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Jon Hunter <jon-hunter@ti.com> [121214 12:37]:
> The system memory node for the OMAP2420 H4 was incorrectly defined as
> start address followed by end address, instead of start address and
> size. No noticable side-effects were observed but fix this for
> correctness.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-h4.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> index 77b84e1..9b0d077 100644
> --- a/arch/arm/boot/dts/omap2420-h4.dts
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -15,6 +15,6 @@
>  
>  	memory {
>  		device_type = "memory";
> -		reg = <0x80000000 0x84000000>; /* 64 MB */
> +		reg = <0x80000000 0x4000000>; /* 64 MB */
>  	};
>  };
> -- 
> 1.7.10.4
> 
