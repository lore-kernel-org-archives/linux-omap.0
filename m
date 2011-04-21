From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/7] OMAP4: GPIO: Save/restore context
Date: Wed, 20 Apr 2011 17:26:55 -0700
Message-ID: <87hb9s4fg0.fsf@ti.com>
References: <1303139217-10285-4-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37561 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab1DUA07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 20:26:59 -0400
Received: by mail-pz0-f54.google.com with SMTP id 27so962371pzk.27
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 17:26:58 -0700 (PDT)
In-Reply-To: <1303139217-10285-4-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Mon, 18 Apr 2011 20:36:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify the omap_gpio_save/restore_context to support OMAP4
> architecture so that the OMAP GPIO driver need not be modified
> when OMAP4 off mode support is available.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |  131 +++++++++++++++++++++++++++++---------------
>  1 files changed, 86 insertions(+), 45 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 74085b5..e68da08 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -2022,43 +2022,62 @@ void omap2_gpio_resume_after_idle(void)
>  
>  #endif
>  
> -#ifdef CONFIG_ARCH_OMAP3
> -/* save the registers of bank 2-6 */
>  void omap_gpio_save_context(void)
>  {
>  	int i;
>  
> -	/* saving banks from 2-6 only since GPIO1 is in WKUP */

Minor: these comment removals belong in the previous patch.

Kevin
