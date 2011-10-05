From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 09:26:19 -0700
Message-ID: <20111005162618.GA6324@atomide.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19797 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934476Ab1JEQ0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 12:26:21 -0400
Content-Disposition: inline
In-Reply-To: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Hylands <dhylands@gmail.com>
Cc: linux-omap@vger.kernel.org

* Dave Hylands <dhylands@gmail.com> [111004 23:41]:
> Hi,
> 
> I have an older overo board, which has an OMAP3503
> 
> U-booot reports:
> OMAP3503-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
> 
> In order to get the 2.6.39 kernel to boot, I had to make 2 modifications:
> 
> In arch/arm/mach-omap2/pm34xx.c, in the omap_sram_idle routine I had
> to put an #if 0 around:
> 
> #if 0
>        if (omap3_has_io_wakeup() &&
>            (per_next_state < PWRDM_POWER_ON ||
>             core_next_state < PWRDM_POWER_ON)) {
>                omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK,
> WKUP_MOD, PM_WKEN);
>                omap3_enable_io_chain();
>        }
> #endif
> 
> or I would get continuous
> 
> Wake up daisy chain activation failed.
> 
> messages on the console.

No idea why this fails..
 
> I then also had to modify drivers/mmc/card/block.c and initializing
> disable_multi to 1 in the mmc_blk_issue_rw_rq function to get rid of
> the following messages for every I/O request.
> 
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> 
> (since this revision of the silicon doesn't support multi-block MMC reads).

..but this one is usually a problem muxing the MMC data lines.

Are you sure this revision only supports one data line?

Tony
