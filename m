From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/5] ARM: dts: OMAP2+: use existing constants for
 GPIOs
Date: Thu, 23 May 2013 11:47:28 -0700
Message-ID: <20130523184727.GF13507@atomide.com>
References: <1369323421-4180-1-git-send-email-florian.vaussard@epfl.ch>
 <1369323421-4180-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59888 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757613Ab3EWSrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 May 2013 14:47:32 -0400
Content-Disposition: inline
In-Reply-To: <1369323421-4180-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130523 08:42]:
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -29,13 +29,13 @@
>  
>  		heartbeat {
>  			label = "beagleboard::usr0";
> -			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
> +			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* 150 -> D6 LED */
>  			linux,default-trigger = "heartbeat";
>  		};
>  
>  		mmc {
>  			label = "beagleboard::usr1";
> -			gpios = <&gpio5 21 0>; /* 149 -> D7 LED */
> +			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>; /* 149 -> D7 LED */
>  			linux,default-trigger = "mmc0";
>  		};
>  	};

Great yeah this is the way to go instead of the fixed numbering.
Thanks for doing this.

Regards,

Tony
