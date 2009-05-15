From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 3/3] OMAP3:zoom2: Makefile and Kconfig for Zoom2 board
Date: Fri, 15 May 2009 11:07:44 -0700
Message-ID: <87bppudytr.fsf@deeprootsystems.com>
References: <1242409235-18834-1-git-send-email-mlc@ti.com>
	<1242409235-18834-2-git-send-email-mlc@ti.com>
	<1242409235-18834-3-git-send-email-mlc@ti.com>
	<1242409235-18834-4-git-send-email-mlc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:64266 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbZEOSHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:07:45 -0400
Received: by pzk13 with SMTP id 13so1191656pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:07:46 -0700 (PDT)
In-Reply-To: <1242409235-18834-4-git-send-email-mlc@ti.com> (Mikkel Christensen's message of "Fri\, 15 May 2009 12\:40\:35 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikkel Christensen <mlc@ti.com>
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

Mikkel Christensen <mlc@ti.com> writes:

> This patch adds OMAP3 Zoom2 board to the Makefile and Kconfig.
>
> Signed-off-by: Mikkel Christensen <mlc@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

One more very minor nit...

> ---
>  arch/arm/mach-omap2/Kconfig  |    4 ++++
>  arch/arm/mach-omap2/Makefile |    4 +++-
>  2 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 64ab386..0b16255 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -67,3 +67,7 @@ config MACH_OMAP_3430SDP
>  config MACH_NOKIA_RX51
>  	bool "Nokia RX-51 board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +
> +config MACH_OMAP_ZOOM2
> +	bool "OMAP3 Zoom2 board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> \ No newline at end of file

Can you add a newline here.  I think Kconfig should parse this without
problems, but not entirely sure.

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index c49d9bf..fe4485f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -48,7 +48,9 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
>  obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
>  					   board-rx51-peripherals.o \
>  					   mmc-twl4030.o
> -
> +obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
> +					   mmc-twl4030.o \
> +					   board-zoom2-debugboard.o
>  # Platform specific device init code
>  ifeq ($(CONFIG_USB_MUSB_SOC),y)
>  obj-y					+= usb-musb.o
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
