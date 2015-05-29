From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP: enable DM9000 in omap2plus_defconfig
Date: Fri, 29 May 2015 10:08:41 -0700
Message-ID: <20150529170840.GR30984@atomide.com>
References: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
 <1432756814-2078-1-git-send-email-anthoine.bourgeois@gmail.com>
 <1432756814-2078-2-git-send-email-anthoine.bourgeois@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54680 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615AbbE2RIn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 13:08:43 -0400
Content-Disposition: inline
In-Reply-To: <1432756814-2078-2-git-send-email-anthoine.bourgeois@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Cc: linux-omap@vger.kernel.org

* Anthoine Bourgeois <anthoine.bourgeois@gmail.com> [150527 13:02]:
> This ethernet device is used on devkit8000 board.
> 
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 8e10859..08cd89c 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -135,6 +135,7 @@ CONFIG_NETDEVICES=y
>  # CONFIG_NET_CADENCE is not set
>  # CONFIG_NET_VENDOR_BROADCOM is not set
>  # CONFIG_NET_VENDOR_CIRRUS is not set
> +CONFIG_DM9000=y
>  # CONFIG_NET_VENDOR_FARADAY is not set
>  # CONFIG_NET_VENDOR_HISILICON is not set
>  # CONFIG_NET_VENDOR_INTEL is not set

Applying into omap-for-v4.2/defconfig thanks.

Tony
