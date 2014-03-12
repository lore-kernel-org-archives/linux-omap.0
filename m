From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-evmsk: enable DMA controller for USB
Date: Wed, 12 Mar 2014 10:39:53 -0700
Message-ID: <20140312173952.GB1996@atomide.com>
References: <1394465217-24171-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44312 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbaCLRj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 13:39:57 -0400
Content-Disposition: inline
In-Reply-To: <1394465217-24171-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* yegorslists@googlemail.com <yegorslists@googlemail.com> [140310 08:30]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  arch/arm/boot/dts/am335x-evmsk.dts |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index fa19271..ec08f6f 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -384,6 +384,10 @@
>  		status = "okay";
>  		dr_mode = "host";
>  	};
> +
> +	dma-controller@07402000  {
> +		status = "okay";
> +	};
>  };
>  
>  &epwmss2 {

Thanks applying into omap-for-v.15/dt with the subject line as
the description also. No guarantees this will get merged as we're
so close to the merge window already.

Regards,

Tony
