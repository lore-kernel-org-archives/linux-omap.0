From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 9/9] OMAP3 clock: add omap3_core_dpll_m2_set_rate()
Date: Mon, 7 Jul 2008 22:20:22 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807072218250.12684@utopia.booyaka.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain> <20080708025511.11646.13749.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50804 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYGHEUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 00:20:24 -0400
In-Reply-To: <20080708025511.11646.13749.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


By the way, this last patch will need to be hand-edited to 
remove the following part to apply cleanly on mainline.  I'll post a 
refreshed series later for merging.

- Paul

On Mon, 7 Jul 2008, Paul Walmsley wrote:

> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 482f05c..0caa4dd 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -15,7 +15,6 @@
>   * published by the Free Software Foundation.
>   */
>  #undef DEBUG
> -#define DEBUG
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
