From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/6] OMAP: powerdomain: Move powerdomain.c from mach-omap2
 to plat-omap
Date: Sun, 28 Nov 2010 17:05:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011281658460.2515@utopia.booyaka.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com> <1289921886-5139-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60788 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab0K2AFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 19:05:55 -0500
In-Reply-To: <1289921886-5139-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

Hello Rajendra,

some comments:

On Tue, 16 Nov 2010, Rajendra Nayak wrote:

> This is in preparation of splitting the powerdomain framework into
> platform-independent part (for all omaps) and platform-specific
> parts.
> The platform-independent code would reside in plat-omap/powerdomain.c
> and the platform-specific code will resides in
> mach-omap2/powerdomain-xxxx.c files.

Since we're not implementing powerdomain support for OMAP1 right now, is 
there any reason why we can't just leave the powerdomain-common stuff in 
the mach-omap2/ directory for now?

> Some of the hacks to include header files are done to make sure the
> patch compiles and works fine. These hacks will be removed in the
> subsequent patches.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/Makefile                     |    2 +-
>  arch/arm/plat-omap/Makefile                      |    6 +++---
>  arch/arm/{mach-omap2 => plat-omap}/powerdomain.c |   14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>  rename arch/arm/{mach-omap2 => plat-omap}/powerdomain.c (99%)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 60e51bc..4bfadc5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -9,7 +9,7 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
>  omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
>  hwmod-common				= omap_hwmod.o \
>  					  omap_hwmod_common_data.o
> -prcm-common				= prcm.o powerdomain.o
> +prcm-common				= prcm.o
>  clock-common				= clock.o clock_common_data.o \
>  					  clockdomain.o clkt_dpll.o \
>  					  clkt_clksel.o
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index a4a1285..424a9ae 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -13,9 +13,9 @@ obj-  :=
>  obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>  
>  # omap_device support (OMAP2+ only at the moment)
> -obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> -obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> -obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> +obj-$(CONFIG_ARCH_OMAP2) += omap_device.o powerdomain.o
> +obj-$(CONFIG_ARCH_OMAP3) += omap_device.o powerdomain.o
> +obj-$(CONFIG_ARCH_OMAP4) += omap_device.o powerdomain.o

The powerdomain code isn't directly related to the omap_device code, so 
please create a new section in the mach-omap2/Makefile for this stuff.  
Perhaps something like:

# OMAP PRCM powerdomain support
obj-$(CONFIG_ARCH_OMAP2) += powerdomain.o
obj-$(CONFIG_ARCH_OMAP3) += powerdomain.o
obj-$(CONFIG_ARCH_OMAP4) += powerdomain.o

>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
> similarity index 99%
> rename from arch/arm/mach-omap2/powerdomain.c
> rename to arch/arm/plat-omap/powerdomain.c

(see the first comment)

> index 6527ec3..9204799 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/plat-omap/powerdomain.c

> @@ -26,19 +26,19 @@
>  
>  #include <asm/atomic.h>
>  
> -#include "cm.h"
> -#include "cm-regbits-34xx.h"
> -#include "cm-regbits-44xx.h"
> -#include "prm.h"
> -#include "prm-regbits-34xx.h"
> -#include "prm-regbits-44xx.h"
> +#include "../mach-omap2/cm.h"
> +#include "../mach-omap2/cm-regbits-34xx.h"
> +#include "../mach-omap2/cm-regbits-44xx.h"
> +#include "../mach-omap2/prm.h"
> +#include "../mach-omap2/prm-regbits-34xx.h"
> +#include "../mach-omap2/prm-regbits-44xx.h"
>  
>  #include <plat/cpu.h>
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
>  #include <plat/prcm.h>
>  
> -#include "pm.h"
> +#include "../mach-omap2/pm.h"
>  
>  enum {
>  	PWRDM_STATE_NOW = 0,
> -- 
> 1.7.0.4
> 


- Paul
