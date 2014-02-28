From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-evmsk: enable USB1
Date: Fri, 28 Feb 2014 14:57:51 -0800
Message-ID: <20140228225750.GV13624@atomide.com>
References: <1393571944-10438-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56744 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbaB1W6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:58:02 -0500
Content-Disposition: inline
In-Reply-To: <1393571944-10438-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* yegorslists@googlemail.com <yegorslists@googlemail.com> [140227 23:22]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Enable second USB channel and set it into 'host' mode.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Thanks applying into omap-for-v3.15/dt.

Tony

> ---
>  arch/arm/boot/dts/am335x-evmsk.dts |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index 486880b..40a66bd 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -342,9 +342,18 @@
>  		status = "okay";
>  	};
>  
> +	usb-phy@47401b00 {
> +		status = "okay";
> +	};
> +
>  	usb@47401000 {
>  		status = "okay";
>  	};
> +
> +	usb@47401800 {
> +		status = "okay";
> +		dr_mode = "host";
> +	};
>  };
>  
>  &epwmss2 {
> -- 
> 1.7.7
> 
