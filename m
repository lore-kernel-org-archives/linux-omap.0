From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: devicetree: fix SPI node compatible
 property syntax items
Date: Thu, 14 Nov 2013 10:36:09 -0800
Message-ID: <20131114183609.GM10317@atomide.com>
References: <1382090468-6011-1-git-send-email-ewitcher@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32173 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754832Ab3KNSgL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 13:36:11 -0500
Content-Disposition: inline
In-Reply-To: <1382090468-6011-1-git-send-email-ewitcher@mindspring.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Witcher <ewitcher@mindspring.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Eric Witcher <ewitcher@mindspring.com> [131022 21:14]:
> Correct the SPI node compatible property items to match example code and
> match current DTS usage.
> 
> Signed-off-by: Eric Witcher <ewitcher@mindspring.com>
> ---
>  Documentation/devicetree/bindings/spi/omap-spi.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
> index 4c85c4c..2ba5f9c 100644
> --- a/Documentation/devicetree/bindings/spi/omap-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
> @@ -2,8 +2,8 @@ OMAP2+ McSPI device
>  
>  Required properties:
>  - compatible :
> -  - "ti,omap2-spi" for OMAP2 & OMAP3.
> -  - "ti,omap4-spi" for OMAP4+.
> +  - "ti,omap2-mcspi" for OMAP2 & OMAP3.
> +  - "ti,omap4-mcspi" for OMAP4+.
>  - ti,spi-num-cs : Number of chipselect supported  by the instance.
>  - ti,hwmods: Name of the hwmod associated to the McSPI
>  - ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as

Applying into omap-for-v3.13/fixes thanks.

Tony
