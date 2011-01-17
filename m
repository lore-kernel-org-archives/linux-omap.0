From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 06/14] ARM: v6k: Dove platforms use V6K architecture CPUs
Date: Mon, 17 Jan 2011 18:39:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101171835530.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1PeufN-0003Sd-W2@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:53658 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1AQXju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:39:50 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LF600EPEXPR4M50@vl-mo-mrz24.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 17 Jan 2011 18:39:27 -0500 (EST)
In-reply-to: <E1PeufN-0003Sd-W2@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:

> Make Dove platforms select the new V6K CPU option.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Nicolas Pitre <nicolas.pitre@linaro.org>

I'd suggest doing the following instead of attaching the selection to 
each individual board target , as the whole Dove architecture is V6K:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba304a3..d3f5674 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -457,6 +457,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
+	select CPU_V6K
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 822439a..dd937c5 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -5,14 +5,12 @@ menu "Marvell Dove Implementations"
 config MACH_DOVE_DB
 	bool "Marvell DB-MV88AP510 Development Board"
 	select I2C_BOARDINFO
-	select CPU_V6K
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-MV88AP510 Development Board.
 
 config MACH_CM_A510
 	bool "CompuLab CM-A510 Board"
-	select CPU_V6K
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  CompuLab CM-A510 Board.




> ---
>  arch/arm/mach-dove/Kconfig |    4 +++-
>  arch/arm/mm/Kconfig        |    4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
> index a4ed390..822439a 100644
> --- a/arch/arm/mach-dove/Kconfig
> +++ b/arch/arm/mach-dove/Kconfig
> @@ -5,12 +5,14 @@ menu "Marvell Dove Implementations"
>  config MACH_DOVE_DB
>  	bool "Marvell DB-MV88AP510 Development Board"
>  	select I2C_BOARDINFO
> +	select CPU_V6K
>  	help
>  	  Say 'Y' here if you want your kernel to support the
>  	  Marvell DB-MV88AP510 Development Board.
>  
> - config MACH_CM_A510
> +config MACH_CM_A510
>  	bool "CompuLab CM-A510 Board"
> +	select CPU_V6K
>  	help
>  	  Say 'Y' here if you want your kernel to support the
>  	  CompuLab CM-A510 Board.
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 559e933..22a3f4a 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -390,7 +390,7 @@ config CPU_PJ4
>  
>  # ARMv6
>  config CPU_V6
> -	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
> +	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
>  	select CPU_32v6
>  	select CPU_ABRT_EV6
>  	select CPU_PABRT_V6
> @@ -403,7 +403,7 @@ config CPU_V6
>  
>  # ARMv6k
>  config CPU_V6K
> -	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
> +	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
>  	select CPU_32v6
>  	select CPU_32v6K if !ARCH_OMAP2
>  	select CPU_ABRT_EV6
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
