From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] ARM: dts: OMAP2+: convert DT files to use the new
 OMAP_GPIO macro
Date: Wed, 22 May 2013 09:28:51 -0600
Message-ID: <519CE433.10903@wwwdotorg.org>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch> <1369232864-14460-4-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55543 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab3EVP2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 11:28:54 -0400
In-Reply-To: <1369232864-14460-4-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 05/22/2013 08:27 AM, Florian Vaussard wrote:
> Use OMAP_GPIO(), in conjunction with standard GPIO flags, to enhance the
> readability of DT GPIOs.

> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index e0ce823..e773a5e 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -29,13 +29,13 @@
>  
>  		heartbeat {
>  			label = "beagleboard::usr0";
> -			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
> +			gpios = OMAP_GPIO(150, GPIO_ACTIVE_HIGH); /* 150 -> D6 LED */

One of the advantages of cpp support for me is the ability to remove the
redundant part of the command. In other words, perhaps remove the "150
->" since that information is part of the OMAP_GPIO() "call", leaving
just /* D6 LED */. I might have expected "D6" to be the label too, thus
removing any need for the comment.
