From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/12] Adds support for CPUIdle safe state
Date: Wed, 10 Sep 2008 09:41:55 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809100940400.20446@utopia.booyaka.com>
References: <62933.192.168.10.89.1220276529.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34331 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYIJPl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 11:41:56 -0400
In-Reply-To: <62933.192.168.10.89.1220276529.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra,

On Mon, 1 Sep 2008, Rajendra Nayak wrote:

> This patch adds the support to move to a safe-state on bm activity
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |  152 +++++++++++++++++++-------------------
>  1 files changed, 79 insertions(+), 73 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
> 18:25:25.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
> 18:27:10.000000000 +0530
> @@ -269,6 +272,7 @@ int omap3_idle_init(void)
>  	struct omap3_processor_cx *cx;
>  	struct cpuidle_state *state;
>  	struct cpuidle_device *dev;
> +	char clk_name[11];

Nothing in this patch uses this - please drop or move to the patch that 
uses this variable.

> 
>  	omap3_clear_scratchpad_contents();
>  	omap3_save_scratchpad_contents();

- Paul
