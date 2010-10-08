From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 01/10] OMAP: mach-omap2: Fix incorrect assignment warnings
Date: Fri, 08 Oct 2010 13:12:58 -0700
Message-ID: <878w28v3xx.fsf@deeprootsystems.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48388 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab0JHUNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 16:13:01 -0400
Received: by pzk34 with SMTP id 34so407364pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 13:13:01 -0700 (PDT)
In-Reply-To: <1285063280-4057-2-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 21 Sep 2010 15:31:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> This patch fixes below sparse warnings for incorrect assignments.

As pointed out by Jean, this patch fixed some sparse warnings, but also
broke some things, specifically off mode.

In the future, *please* be sure to test the code paths that are being
changed.  This patch changed some code that is only exercised during
off-mode, but was clearly not tested with off mode enabled.

As background for why this broke functionality, keep this in mind:

 	void *a = NULL;
	u32 *b = NULL;

a + 1 = 1
b + 1 = 4

IOW, you cannot simply replace a 'u32 *' by a 'void *' without checking
and fixing any pointer arithmetic.

[...]

> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index a8d20ee..7405936 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -190,7 +190,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
>  void omap3_clear_scratchpad_contents(void)
>  {
>  	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
> -	u32 *v_addr;
> +	void __iomem *v_addr;
>  	u32 offset = 0;
>  	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
>  	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &

Interestingly, this one not only fixed the sparse warning but also fixed
a bug. :) Before this change, only every 4th entry of the scratchpad was
zeroed.

> @@ -206,7 +206,7 @@ void omap3_clear_scratchpad_contents(void)
>  /* Populate the scratchpad structure with restore structure */
>  void omap3_save_scratchpad_contents(void)
>  {
> -	void * __iomem scratchpad_address;
> +	void  __iomem *scratchpad_address;
>  	u32 arm_context_addr;
>  	struct omap3_scratchpad scratchpad_contents;
>  	struct omap3_scratchpad_prcm_block prcm_block_contents;

This one is fine.

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7b03426..4af19a6 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -316,7 +316,7 @@ static void restore_control_register(u32 val)
>  /* Function to restore the table entry that was modified for enabling MMU */
>  static void restore_table_entry(void)
>  {
> -	u32 *scratchpad_address;
> +	void __iomem *scratchpad_address;
>  	u32 previous_value, control_reg_value;
>  	u32 *address;

This one changes the result of any 'scratchpad_address + foo'.  

So, if this is changed from u32 to void, all the offsets used when
adding to the base need to be changed as well.

Kevin
