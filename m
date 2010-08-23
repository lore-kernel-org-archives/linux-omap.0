From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/5] OMAP4: runtime: Enable PM runtime core for OMAP4
Date: Mon, 23 Aug 2010 15:16:08 -0700
Message-ID: <87tymlvutz.fsf@deeprootsystems.com>
References: <1281364586-26323-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48929 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab0HWWQO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 18:16:14 -0400
Received: by iwn5 with SMTP id 5so3885533iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 15:16:13 -0700 (PDT)
In-Reply-To: <1281364586-26323-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Mon, 9 Aug 2010 20:06:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> The PM runtime core functions are implemented in pm_bus.c
> which needs to be compiled for CONFIG_ARCH_OMAP4 for
> runtime api's to work.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

I'll fold this one into the OMAP runtime PM core series (pm-wip/runtime
branch) so this goes upstream with the core code.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 800b430..18db759 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -50,7 +50,7 @@ ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o pm_bus.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
