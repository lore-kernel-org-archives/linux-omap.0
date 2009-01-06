From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 08/23] OMAP clock: remove VIRTUAL_CLOCK
Date: Mon, 05 Jan 2009 18:03:43 -0800
Message-ID: <87hc4dp4w0.fsf@deeprootsystems.com>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
	<20090105023451.12661.18427.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:18781 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZAFCDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 21:03:49 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7901903wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Jan 2009 18:03:46 -0800 (PST)
In-Reply-To: <20090105023451.12661.18427.stgit@localhost.localdomain> (Paul Walmsley's message of "Sun\, 04 Jan 2009 19\:34\:52 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

Paul Walmsley <paul@pwsan.com> writes:

> From: Russell King <rmk@dyn-67.arm.linux.org.uk>
>
> Nothing tests the clock flags for this bit, so it serves no purpose.
> Remove it.

Actually, the CPUfreq support patches (from TI) in the PM branch are
currently using VIRTUAL_CLOCK.

I'm working on rebasing the PM branch onto this series but had to
revert this one for now.

Kevin

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap1/clock.h             |    8 +++-----
>  arch/arm/mach-omap2/clock24xx.h         |    2 +-
>  arch/arm/plat-omap/include/mach/clock.h |    6 ++----
>  3 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index 564f4bc..5ba55a0 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -736,7 +736,7 @@ static struct clk mmc2_ck = {
>  static struct clk virtual_ck_mpu = {
>  	.name		= "mpu",
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> -			  CLOCK_IN_OMAP310 | VIRTUAL_CLOCK | ALWAYS_ENABLED,
> +			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
>  	.parent		= &arm_ck, /* Is smarter alias for */
>  	.recalc		= &followparent_recalc,
>  	.set_rate	= &omap1_select_table_rate,
> @@ -751,8 +751,7 @@ static struct clk i2c_fck = {
>  	.name		= "i2c_fck",
>  	.id		= 1,
>  	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> -			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
> -			  ALWAYS_ENABLED,
> +			  CLOCK_NO_IDLE_PARENT | ALWAYS_ENABLED,
>  	.parent		= &armxor_ck.clk,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_generic,
> @@ -762,8 +761,7 @@ static struct clk i2c_fck = {
>  static struct clk i2c_ick = {
>  	.name		= "i2c_ick",
>  	.id		= 1,
> -	.flags		= CLOCK_IN_OMAP16XX |
> -			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
> +	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
>  			  ALWAYS_ENABLED,
>  	.parent		= &armper_ck.clk,
>  	.recalc		= &followparent_recalc,
> diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
> index 824413d..8e0b3f7 100644
> --- a/arch/arm/mach-omap2/clock24xx.h
> +++ b/arch/arm/mach-omap2/clock24xx.h
> @@ -2845,7 +2845,7 @@ static struct clk mmchsdb2_fck = {
>  static struct clk virt_prcm_set = {
>  	.name		= "virt_prcm_set",
>  	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
> -				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
> +				ALWAYS_ENABLED | DELAYED_APP,
>  	.clkdm		= { .name = "virt_opp_clkdm" },
>  	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
>  	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index 4b90531..b88e077 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -153,12 +153,10 @@ void omap_clk_del_child(struct clk *clk, struct clk *clk2);
>  
>  /* Clock flags */
>  #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
> -
> -
> -#define VIRTUAL_CLOCK		(1 << 3)	/* Composite clock from table */
> +/* bits 1-3 are currently free */
>  #define ALWAYS_ENABLED		(1 << 4)	/* Clock cannot be disabled */
>  #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
> -
> +/* bit 6 is currently free */
>  #define CLOCK_IDLE_CONTROL	(1 << 7)
>  #define CLOCK_NO_IDLE_PARENT	(1 << 8)
>  #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
