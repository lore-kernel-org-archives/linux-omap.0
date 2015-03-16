From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix socbus family info for AM33xx devices
Date: Mon, 16 Mar 2015 15:30:45 -0700
Message-ID: <20150316223045.GT12397@atomide.com>
References: <1426117118-11806-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37944 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872AbbCPWfe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 18:35:34 -0400
Content-Disposition: inline
In-Reply-To: <1426117118-11806-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Suman Anna <s-anna@ti.com> [150311 16:39]:
> The family information in the soc-bus data is currently
> not classified properly for AM33xx devices, and a read
> of /sys/bus/soc/devices/soc0/family currently shows
> "Unknown". Fix the same.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks applying into omap-for-v4.0/fixes.

Tony

> ---
>  arch/arm/mach-omap2/id.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2a2f4d56e4c8..25f1beea453e 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -720,6 +720,8 @@ static const char * __init omap_get_family(void)
>  		return kasprintf(GFP_KERNEL, "OMAP4");
>  	else if (soc_is_omap54xx())
>  		return kasprintf(GFP_KERNEL, "OMAP5");
> +	else if (soc_is_am33xx() || soc_is_am335x())
> +		return kasprintf(GFP_KERNEL, "AM33xx");
>  	else if (soc_is_am43xx())
>  		return kasprintf(GFP_KERNEL, "AM43xx");
>  	else if (soc_is_dra7xx())
> -- 
> 2.3.0
> 
