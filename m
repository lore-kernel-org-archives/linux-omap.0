From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7][RFC] OMAP4: Enable basic build support.
Date: Tue, 21 Apr 2009 11:39:40 -0700
Message-ID: <20090421183940.GN25864@atomide.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49220 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542AbZDUSjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 14:39:43 -0400
Content-Disposition: inline
In-Reply-To: <1240319293-19662-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090421 06:08]:
> This patch updates the Makefile and defconfig for OMAP4. Minimal set of
> drivers are enabled fot the kernel bootup.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/Makefile                       |    1 +
>  arch/arm/configs/omap_4430sdp_defconfig |  807 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/Makefile            |    6 +-
>  3 files changed, 813 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/configs/omap_4430sdp_defconfig

<snip snip>

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index c49d9bf..68d50a8 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -3,9 +3,13 @@
>  #
>  
>  # Common support
> +ifeq ($(CONFIG_ARCH_OMAP4),y)
> +obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> +else
>  obj-y := irq.o id.o io.o sdrc.o control.o prcm.o clock.o mux.o \
>  		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
>  		clockdomain.o
> +endif

This ifeq else we don't want to do as it breaks things for multi-omap.

Regards,

Tony


>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  
> @@ -44,7 +48,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
>  					   mmc-twl4030.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
>  					   mmc-twl4030.o
> -
> +obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
>  obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
>  					   board-rx51-peripherals.o \
>  					   mmc-twl4030.o

