From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: Fix warnings about enabling 32 KiHz timer
Date: Fri, 7 Oct 2011 13:03:37 -0700
Message-ID: <20111007200337.GP6324@atomide.com>
References: <20111007001216.GD6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51440 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab1JGUDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 16:03:39 -0400
Content-Disposition: inline
In-Reply-To: <20111007001216.GD6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [111006 16:38]:
> Fix "Enable 32kHz OS timer in order to allow sleep states in idle"
> warning. We are now compiling in bothe MPU timer and 32 KiHz timer,
> so this warning is only valid when CONFIG_OMAP_32K_TIMER is not set.
>  
> -#ifdef CONFIG_OMAP_MPU_TIMER
> +#if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_32K_TIMER)
>  #warning Enable 32kHz OS timer in order to allow sleep states in idle
>  	use_idlect1 = use_idlect1 & ~(1 << 9);
>  #else

This should be !defined(CONFIG_OMAP_DM_TIMER) instead of CONFIG_OMAP_32K
timer. Corrected patch below.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 6 Oct 2011 17:05:51 -0700
Subject: [PATCH] ARM: OMAP1: Fix warnings about enabling 32 KiHz timer

Fix "Enable 32kHz OS timer in order to allow sleep states in idle"
warning. We are now compiling in bothe MPU timer and 32 KiHz timer,
so this warning is only valid when MPU_TIMER is set and OMAP_DM_TIMER
is not set.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 495b398..89ea20c 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -116,7 +116,7 @@ void omap1_pm_idle(void)
 		return;
 	}
 
-#ifdef CONFIG_OMAP_MPU_TIMER
+#if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
 	use_idlect1 = use_idlect1 & ~(1 << 9);
 #else
