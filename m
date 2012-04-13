From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE
 flag from VENC slave interface
Date: Fri, 13 Apr 2012 17:07:00 +0530
Message-ID: <4F880FDC.9080908@ti.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com> <1334304116-18872-2-git-send-email-archit@ti.com> <alpine.DEB.2.00.1204130520170.25832@utopia.booyaka.com> <alpine.DEB.2.00.1204130523170.25832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40639 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab2DMLhe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 07:37:34 -0400
In-Reply-To: <alpine.DEB.2.00.1204130523170.25832@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi,

On Friday 13 April 2012 04:54 PM, Paul Walmsley wrote:
> On Fri, 13 Apr 2012, Paul Walmsley wrote:
>
>> On Fri, 13 Apr 2012, Archit Taneja wrote:
>>
>>> The clocks for all DSS slave interfaces were recently changed to "dss_ick" on
>>> OMAP2 and OMAP3, this clock can be autoidled by PRCM. The VENC interface
>>> previously had "dss_54m_fck" as it's clock which couldn't be autoidled, and
>>> hence the OCPIF_SWSUP_IDLE flag was needed.
>>>
>>> Remove the OCPIF_SWSUP_IDLE flag from VENC interfaces as it's clock is now
>>> "dss_ick".
>>>
>>> Signed-off-by: Archit Taneja<archit@ti.com>
>>
>> Thanks, queued for 3.4-rc.
>
> By the way, I added another sentence to the commit log to describe what is
> being fixed.  Please let me know if you have any comments.

Thanks for improving the commit. It looks good to me.

Archit


>
>
> - Paul
>
> From: Archit Taneja<archit@ti.com>
> Date: Fri, 13 Apr 2012 13:31:55 +0530
> Subject: [PATCH 3/3] ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag
>   from VENC slave interface
>
> The clocks for all DSS slave interfaces were recently changed to "dss_ick" on
> OMAP2 and OMAP3, this clock can be autoidled by PRCM. The VENC interface
> previously had "dss_54m_fck" as it's clock which couldn't be autoidled, and
> hence the OCPIF_SWSUP_IDLE flag was needed.
>
> Remove the OCPIF_SWSUP_IDLE flag from VENC interfaces as it's clock is
> now "dss_ick".  This allows the PRCM hardware to autoidle the VENC
> interface clocks when they are not active, rather than relying on the
> software to do it, which can keep the interface clocks active
> unnecessarily.
>
> Signed-off-by: Archit Taneja<archit@ti.com>
> [paul@pwsan.com: add a short description of the fix to the commit log]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 -
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 -
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index a5409ce..a6bde34 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1000,7 +1000,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
>   			.flags	= OMAP_FIREWALL_L4,
>   		}
>   	},
> -	.flags		= OCPIF_SWSUP_IDLE,
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index c4f56cb..04a3885 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1049,7 +1049,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
>   	.slave		=&omap2430_dss_venc_hwmod,
>   	.clk		= "dss_ick",
>   	.addr		= omap2_dss_venc_addrs,
> -	.flags		= OCPIF_SWSUP_IDLE,
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 34b9766d..db86ce9 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1676,7 +1676,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
>   			.flags	= OMAP_FIREWALL_L4,
>   		}
>   	},
> -	.flags		= OCPIF_SWSUP_IDLE,
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>

