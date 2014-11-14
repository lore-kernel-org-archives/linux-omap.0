From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Add support for ADC on am437x-gp and am43x-epos-evm
Date: Fri, 14 Nov 2014 09:37:22 +0530
Message-ID: <54657FFA.1070200@ti.com>
References: <1415099728-10959-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415099728-10959-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On Tuesday 04 November 2014 04:45 PM, Vignesh R wrote:
> This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
> The ADC clock hwmod data of am33xx has been moved to commom place so that
> both am43xx and am33xx can reuse them.
> tscadc DT node has been adided to am437x-gp and am43x-epos dt files.
> With these patches, ADC functionalities are now available on am43xx.
> 
> Changelog:
> 
> v2:
> Removed phy addresses in hwmod. Using DT instead.
> Removed unused "ti,am4372" compatible string.
> Use macro to set clk domain name.
> Fixed subject format of all patches
> 

Please accept these patches.

Regards
Vignesh R

> Vignesh R (3):
>   ARM: OMAP2+: hwmod: AM335x/AM43x: Move am33xx_l4_hs_hwmod to
>     ipblock_data
>   ARM: OMAP2+: hwmod: AM335x/AM43x: add hwmod support for tscadc on
>     am43x-evm
>   ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and
>     am43x-epos-evm
> 
>  arch/arm/boot/dts/am4372.dtsi                      | 20 ++++++
>  arch/arm/boot/dts/am437x-gp-evm.dts                |  8 +++
>  arch/arm/boot/dts/am43x-epos-evm.dts               |  8 +++
>  .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  2 +
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 71 ++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 64 -------------------
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  1 +
>  7 files changed, 110 insertions(+), 64 deletions(-)
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
