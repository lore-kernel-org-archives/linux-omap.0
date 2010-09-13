From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2: Add pm_bus.c file for OMAP2 architecture
Date: Mon, 13 Sep 2010 07:58:57 -0700
Message-ID: <878w351yha.fsf@deeprootsystems.com>
References: <1284367481-10508-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0IMO7J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 10:59:09 -0400
Received: by pwi3 with SMTP id 3so2186393pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 07:59:09 -0700 (PDT)
In-Reply-To: <1284367481-10508-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Mon, 13 Sep 2010 14:14:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> This patch adds pm_bus.o for OMAP2 architecture which is required
> while using PM runtime APIs on OMAP2.
>
> This patch series is created on "origin/pm-core" and is
> tested on 2430 SDP board (with watchdog and GPIO patches
> using PM runtime APIs. These patches would be sent to
> LO mailing list soon).
>
> Signed-off-by: Charulatha V <charu@ti.com>

Thanks, will merge into runtime PM core before final version is posted.

Kevin

> ---
>  arch/arm/mach-omap2/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 56133d4..a88b75a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -51,7 +51,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>  # Power Management
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> -obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
> +obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o pm_bus.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
