From: Dave Hylands <dhylands@gmail.com>
Subject: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 00:14:57 -0700
Message-ID: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48983 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab1JEHO6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 03:14:58 -0400
Received: by wwf22 with SMTP id 22so2052911wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 00:14:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have an older overo board, which has an OMAP3503

U-booot reports:
OMAP3503-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz

In order to get the 2.6.39 kernel to boot, I had to make 2 modifications:

In arch/arm/mach-omap2/pm34xx.c, in the omap_sram_idle routine I had
to put an #if 0 around:

#if 0
       if (omap3_has_io_wakeup() &&
           (per_next_state < PWRDM_POWER_ON ||
            core_next_state < PWRDM_POWER_ON)) {
               omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK,
WKUP_MOD, PM_WKEN);
               omap3_enable_io_chain();
       }
#endif

or I would get continuous

Wake up daisy chain activation failed.

messages on the console.

I then also had to modify drivers/mmc/card/block.c and initializing
disable_multi to 1 in the mmc_blk_issue_rw_rq function to get rid of
the following messages for every I/O request.

mmcblk0: retrying using single block read
mmcblk0: retrying using single block read
mmcblk0: retrying using single block read
mmcblk0: retrying using single block read

(since this revision of the silicon doesn't support multi-block MMC reads).

Looking at the code in LXR, it appears that the same problems would
also appear in 3.0.4.

I threw in some printks in the id.c omap3_check_features function:

        printk( KERN_INFO "%s: cpu_is_omap3503() = %d\n", __func__,
cpu_is_omap3503() );
        printk( KERN_INFO "%s: cpu_is_omap3505() = %d\n", __func__,
cpu_is_omap3505() );
        printk( KERN_INFO "%s: cpu_is_omap3517() = %d\n", __func__,
cpu_is_omap3517() );
        printk( KERN_INFO "%s: omap3_features = 0x%08x\n", __func__, status );
        printk( KERN_INFO "%s: HAS_IO_WAKEUP = %d\n", __func__,
(omap3_features & OMAP3_HAS_IO_WAKEUP) != 0 );

and it reports:

omap3_check_features: cpu_is_omap3503() = 1
omap3_check_features: cpu_is_omap3505() = 0
omap3_check_features: cpu_is_omap3517() = 0
omap3_check_features: omap3_features = 0x00005c00
omap3_check_features: HAS_IO_WAKEUP = 1

and the print from the end of omap3_cpuinfo reports:

OMAP3503 ES2.1 (l2cache neon isp )


-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
