From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 28/29] PM FIX: convert TI io_p2v() usage to OMAP2_IO_ADDRESS()
Date: Thu, 11 Sep 2008 14:05:50 +0100
Message-ID: <20080911130550.GA4986@flint.arm.linux.org.uk>
References: <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-23-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-24-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-25-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-26-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-27-git-send-email-khilman@deeprootsystems.com> <1221136453-16697-28-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48453 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbYIKNGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 09:06:04 -0400
Content-Disposition: inline
In-Reply-To: <1221136453-16697-28-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 11, 2008 at 03:34:12PM +0300, Kevin Hilman wrote:
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 5242ba0..7436332 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -222,7 +222,7 @@ static void restore_table_entry(void)
>  	u32 previous_value, control_reg_value;
>  	u32 *address;
>  	/* Get virtual address of SCRATCHPAD */
> -	scratchpad_address = (u32 *) io_p2v(SCRATCHPAD);
> +	scratchpad_address = (u32 *) OMAP2_IO_ADDRESS(SCRATCHPAD);

scratchpad_address should be u32 __iomem *, and that cast shouldn't
be there.

>  	/* Get address of entry that was modified */
>  	address = (u32 *) *(scratchpad_address + TABLE_ADDRESS_OFFSET);
>  	/* Get the previous value which needs to be restored */
> @@ -924,7 +924,7 @@ void clear_scratchpad_contents(void)
>  	u32 max_offset = SCRATHPAD_ROM_OFFSET;
>  	u32 offset = 0;
>  	u32 v;
> -	u32 v_addr = io_p2v(SCRATCHPAD_ROM);
> +	u32 v_addr = OMAP2_IO_ADDRESS(SCRATCHPAD_ROM);

Ditto.

>  	if (__raw_readl(OMAP3430_PRM_RSTST) & 0x1) {
>  		for ( ; offset <= max_offset; offset += 0x4)
>  			 __raw_writel(0x0, (v_addr + offset));
> @@ -942,7 +942,7 @@ void save_scratchpad_contents(void)
>  	u32 *sdram_context_address;
>  
>  	/* Get virtual address of SCRATCHPAD */
> -	scratchpad_address = (u32 *) io_p2v(SCRATCHPAD);
> +	scratchpad_address = (u32 *) OMAP2_IO_ADDRESS(SCRATCHPAD);

Ditto.
