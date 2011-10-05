From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 12:09:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110051206090.4611@utopia.booyaka.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45995 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812Ab1JESJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 14:09:56 -0400
In-Reply-To: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Hylands <dhylands@gmail.com>
Cc: linux-omap@vger.kernel.org, sakoman@gmail.com

Hi Dave,

On Wed, 5 Oct 2011, Dave Hylands wrote:

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

Looking at the 2.6.39 kernel sources, those messages are coming from 
mach-omap2/pm34xx.c:omap3_enable_io_chain().  That means that something is 
seriously wrong since that code should only be executing on ES3.1 chips 
and higher.

Could you put something similar to a

pr_err("** omap_rev is %08x\n", omap_rev());

in your pm34xx.c right above the #if 0 that you added and let us know what 
it says?


thanks

- Paul
