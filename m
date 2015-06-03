From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 07/10] ARM: OMAP2+: display: detect DRA7 DSS
Date: Wed, 3 Jun 2015 08:42:33 -0700
Message-ID: <20150603154232.GP30984@atomide.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-8-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55599 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbbFCPmf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 11:42:35 -0400
Content-Disposition: inline
In-Reply-To: <1433139798-23450-8-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150531 23:25]:
> Add platform code to detect DRA7 DSS.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tonY@atomide.com>

> ---
>  arch/arm/mach-omap2/display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 9868d0bc7805..6ab13d18c636 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -287,6 +287,8 @@ static enum omapdss_version __init omap_display_get_version(void)
>  		return OMAPDSS_VER_OMAP5;
>  	else if (soc_is_am43xx())
>  		return OMAPDSS_VER_AM43xx;
> +	else if (soc_is_dra7xx())
> +		return OMAPDSS_VER_DRA7xx;
>  	else
>  		return OMAPDSS_VER_UNKNOWN;
>  }
> @@ -573,6 +575,7 @@ static const char * const omapdss_compat_names[] __initconst = {
>  	"ti,omap3-dss",
>  	"ti,omap4-dss",
>  	"ti,omap5-dss",
> +	"ti,dra7-dss",
>  };
>  
>  struct device_node * __init omapdss_find_dss_of_node(void)
> -- 
> 2.1.4
> 
