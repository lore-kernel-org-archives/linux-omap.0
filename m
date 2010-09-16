From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] omap4: l2x0: Override the default l2x0_disable
Date: Wed, 15 Sep 2010 17:21:35 -0700
Message-ID: <20100916002134.GL4174@atomide.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60802 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab0IPAVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 20:21:48 -0400
Content-Disposition: inline
In-Reply-To: <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100907 00:50]:
> The machine_kexec() calls outer_disable which can crash on OMAP4
> becasue of trustzone restrictions.
> 
> This patch overrides the default l2x0_disable with a OMAP4
> specific implementation taking care of trustzone

<snip>

> @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
>
>  	 */
>  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>
> +	/*
> +	 * Override default outer_cache.disable with a OMAP4
> +	 * specific one
> +	*/
> +	outer_cache.disable = omap4_l2x0_disable;
> +
>  	return 0;
>  }
>  early_initcall(omap_l2_cache_init);

Just to be sure.. No outer_cache functions get set unless
l2x0_init gets called, right? So omap2 and omap3 functions
always stay NULL with omap3_defconfig?

Tony
