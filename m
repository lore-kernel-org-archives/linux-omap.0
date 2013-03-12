From: Tony Lindgren <tony@atomide.com>
Subject: Re: IS_ERR_VALUE()
Date: Tue, 12 Mar 2013 09:34:22 -0700
Message-ID: <20130312163422.GY26093@atomide.com>
References: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10312 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932206Ab3CLQe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 12:34:27 -0400
Content-Disposition: inline
In-Reply-To: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130312 07:25]:
> I am removing almost all references to the above macro from arch/arm.
> Many of them are wrong.  Some of them are buggy.
> 
> For instance:
> 
> int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
> {
>         int div;
>         div = gpmc_calc_divider(t->sync_clk);
>         if (div < 0)
>                 return div;
> static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
> {
> ...
>         return gpmc_cs_set_timings(cs, t);
> 
> .....
>         ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
>         if (IS_ERR_VALUE(ret))
>                 return ret;
> 
> So, gpmc_cs_set_timings() thinks any negative return value is an error,
> but where we check that in higher levels, only a limited range are
> errors... seriously?  Come on guys, get with the program.  Get your
> error checking in order.
> 
> There is only _one_ use of IS_ERR_VALUE() in arch/arm which is correct,
> and that is in arch/arm/include/asm/syscall.h:
> 
> static inline long syscall_get_error(struct task_struct *task,
>                                      struct pt_regs *regs)
> {
>         unsigned long error = regs->ARM_r0;
>         return IS_ERR_VALUE(error) ? error : 0;
> }
> 
> So, here's a patch to remove them all, except for the above.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This patch will be going into my "cleanup" branch along with the removal
> of many wrong IS_ERR_OR_NULL() uses - with any errors anyone spots fixed.

Looks good to me. Can you please also let us know some immutable
commit for your cleanup branch? I'd like to use that as a base
to pull in further GPMC changes to avoid unnecessary merge conflicts.

Acked-by: Tony Lindgren <tony@atomide.com>
