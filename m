From: Kevin Hilman <khilman@ti.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 05 Oct 2011 11:10:31 -0700
Message-ID: <877h4j5my0.fsf@ti.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55863 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932812Ab1JESKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 14:10:45 -0400
Received: by vcbfo1 with SMTP id fo1so2343345vcb.22
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 11:10:43 -0700 (PDT)
In-Reply-To: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
	(Dave Hylands's message of "Wed, 5 Oct 2011 00:14:57 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Hylands <dhylands@gmail.com>
Cc: linux-omap@vger.kernel.org

Dave Hylands <dhylands@gmail.com> writes:

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

The need to comment this out suggests that omap3_has_io_wakeup() is
returning true for this SoC but should not.

Looking at mach-omap2/io.c, that feature flag is not set on the 3505 and
3517, but is set on the 3503:

	if (!cpu_is_omap3505() && !cpu_is_omap3517())
		omap_features |= OMAP3_HAS_IO_WAKEUP;

Adding a case for the 3503 here should fix this problem.

Maybe check other checks for cpu_is_omap3505() and see if those should
also be checking for the 3503.

Kevin


