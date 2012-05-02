From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/7] ARM: OMAP2+: Clean up wrapping multiple objects in
	Makefile
Date: Wed, 2 May 2012 10:56:12 +0100
Message-ID: <20120502095612.GG25053@n2100.arm.linux.org.uk>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com> <1335952093-12541-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46755 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab2EBJ4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 05:56:21 -0400
Content-Disposition: inline
In-Reply-To: <1335952093-12541-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, May 02, 2012 at 03:18:08PM +0530, Santosh Shilimkar wrote:
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |  160 ++++++++++++++++++++---------------------
>  1 files changed, 78 insertions(+), 82 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 56ed62e..669e2b1 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -24,10 +24,11 @@ endif
>  obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
>  
>  # SMP support ONLY available for OMAP4
> +
>  obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o \
> -					   sleep44xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o

Using \ in makefiles really isn't a problem.  I don't think this is something
which we need to do, and it just creates additional changes where none is
required.
