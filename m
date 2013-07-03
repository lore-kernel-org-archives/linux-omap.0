From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: Enable Cortex A15 errata 798181
Date: Wed, 3 Jul 2013 09:55:21 -0400
Message-ID: <51D42D49.700@ti.com>
References: <1371671532-27071-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128Ab3GCNz4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jul 2013 09:55:56 -0400
In-Reply-To: <1371671532-27071-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Ping..

On Wednesday 19 June 2013 03:52 PM, Santosh Shilimkar wrote:
> ARM errata 798181 is applicable for OMAP5 based devices. So enable
> the same in the build. Errata extract and workaround information
> is as below.
> 
> On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
> adequately shooting down all use of the old entries. The
> ARM_ERRATA_798181 option enables the Linux kernel workaround
> for this erratum which sends an IPI to the CPUs that are running
> the same ASID as the one being invalidated.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f49cd51..fbd2b9f 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -112,6 +112,7 @@ config SOC_OMAP5
>  	select HAVE_SMP
>  	select COMMON_CLK
>  	select HAVE_ARM_ARCH_TIMER
> +	select ARM_ERRATA_798181
>  
>  comment "OMAP Core Type"
>  	depends on ARCH_OMAP2
> 

