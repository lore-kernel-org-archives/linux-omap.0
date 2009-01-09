From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 0/3] Add support for OMAP35x processors
Date: Fri, 9 Jan 2009 10:02:05 -0600
Message-ID: <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>
References: <1231513323-27379-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39197 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbZAIQCN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 11:02:13 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n09G28F8017566
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 10:02:13 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n09G27xk009550
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 10:02:07 -0600 (CST)
In-Reply-To: <1231513323-27379-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Friday, January 09, 2009 9:02 AM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH 0/3] Add support for OMAP35x processors
> 
> These patches provide support for the OMAP35x processors.
> 
> This is essentially a re-submit after series of discusions
> earlier in the list. It had always been getting pushed in
> my to-do list :(
> See: http://marc.info/?l=linux-omap&m=122029900603111&w=2
> 
> Based on the comments received, this patch includes following:
>   1) Updates to Kconfig
>   2) Runtime check for OMAP35x
>   3) Updates to omap3_evm_defconfig
> 
> If the changes look good, I can make updates to Beagle,
> Overo and Pandora boards as well.
> 
> Best regards,
> Sanjeev
> 
> Sanjeev Premi (3):
>   Add support for OMAP35x processors
>   Runitme check for OMAP35x
>   Updates for OMAP3EVM
> 
>  arch/arm/configs/omap3_evm_defconfig     |    5 ++
>  arch/arm/mach-omap2/Kconfig              |   54 +++++++++++++++++-
>  arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
>  arch/arm/plat-omap/common.c              |   68 +++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/common.h |    1 +
>  arch/arm/plat-omap/include/mach/cpu.h    |   88
> +++++++++++++++++++++++++++++-
>  6 files changed, 212 insertions(+), 6 deletions(-)
> 
> From 2be5d86821dd72c90eca438dbc5a1aa7237a9ebe Mon Sep 17 00:00:00 2001
> From: Sanjeev Premi <premi@ti.com>
> Date: Fri, 9 Jan 2009 20:01:10 +0530
> Subject: [PATCH 1/3] Add support for OMAP35x processors
> 
> This patch adds basic support for the OMAP35x Applications Processors.
> (See: http://focus.ti.com/general/docs/gencontent.tsp?contentId=46725)
>   - OMAP3503
>   - OMAP3515
>   - OMAP3525
>   - OMAP3530
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |   54
> ++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0a86a88..1b77b63 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -28,6 +28,54 @@ config ARCH_OMAP3430
>  	select ARCH_OMAP_OTG
>  	select CPU_V7
> 
> +config ARCH_OMAP35XX
> +	bool "OMAP35x Family"
> +	select ARCH_OMAP3
> +	select ARCH_OMAP34XX
> +	select ARCH_OMAP3430
> +	select OMAP3430_ES2

AFAIK the above select (OMAP3430_ES2) doesn't exist. omap_rev() is used in drivers to check instead.

> +	select NEON
> +	help
> +	  OMAP35x family of processors based on ARM Cortex-A8
> +	  in combination with IVA2.2 core and OpenGL ES2.0
> +	  compatible graphics engine.
> +
> +	  ARM Cortex-A8 contains NEON SIMD coprocessor.
> +
> +choice
> +	prompt "Current choice"
> +	default ARCH_OMAP3503
> +
> +config ARCH_OMAP3503
> +	bool "OMAP3503"
> +	depends on ARCH_OMAP35XX
> +	help
> +	  Contains ARM Cortex-A8 processor.
> +
> +config ARCH_OMAP3515
> +	bool "OMAP3515"
> +	depends on ARCH_OMAP35XX
> +	help
> +	   Contains ARM Cortex-A8 processor and SGX530 subsystem
> +	   for 2D and 3D graphics acceleration.
> +
> +config ARCH_OMAP3525
> +	bool "OMAP3525"
> +	depends on ARCH_OMAP35XX
> +	help
> +	  Contains ARM Cortex-A8 processor and IVA2.2 subsystem
> +	  with a C64x+ DSP core.
> +
> +config ARCH_OMAP3530
> +	bool "OMAP3530"
> +	depends on ARCH_OMAP35XX
> +	help
> +	   Contains ARM Cortex-A8 processor, IVA2.2 subsystem
> +	   with a C64x+ DSP Core and SGX530 subsystem for 2D
> +	   and 3D graphics acceleration.
> +
> +endchoice
> +
>  comment "OMAP Board Type"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3
> 
> @@ -107,7 +155,7 @@ config MACH_OMAP_2430SDP
> 
>  config MACH_OMAP_LDP
>  	bool "OMAP3 LDP board"
> -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> 
>  config MACH_OMAP2EVM
>  	bool "OMAP 2530 EVM board"
> @@ -115,11 +163,11 @@ config MACH_OMAP2EVM
> 
>  config MACH_OMAP_3430SDP
>  	bool "OMAP 3430 SDP board"
> -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> 
>  config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
> -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	depends on ARCH_OMAP35XX
> 
>  config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"

Question to all,

Why don't making above options as choice.. endchoice. Or is there any case that multiple boards are compiled at once?

Regards,
Sergio

