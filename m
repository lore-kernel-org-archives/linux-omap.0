From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/2] arm: omap: beagle: update defconfig
Date: Mon, 10 Aug 2009 15:43:57 +0300
Message-ID: <20090810124357.GA31641@esdhcp037198.research.nokia.com>
References: <1249904939-3213-1-git-send-email-felipe.balbi@nokia.com>
 <1249904939-3213-2-git-send-email-felipe.balbi@nokia.com>
 <1249904939-3213-3-git-send-email-felipe.balbi@nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47292 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbZHJM5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 08:57:51 -0400
Content-Disposition: inline
In-Reply-To: <1249904939-3213-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Tony Lindgren <tony@atomide.com>

Hello Felipe,

I was about to ack your patches. But just one question?

On Mon, Aug 10, 2009 at 01:48:59PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> +#
>  # I2C GPIO expanders:
>  #
>  # CONFIG_GPIO_MAX732X is not set
>  # CONFIG_GPIO_PCA953X is not set
>  # CONFIG_GPIO_PCF857X is not set
> +# CONFIG_GPIO_TWL4030 is not set

Can you also enable CONFIG_GPIO_TWL4030 ??

So we can use  CONFIG_MMC_OMAP_HS in beagle without problems.

I think enabling mmc by default is also worth.

> 
> --
> 1.6.3.3.385.g60647

-- 
Eduardo Valentin
