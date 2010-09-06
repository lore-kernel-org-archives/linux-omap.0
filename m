From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/4] ARM: l2x0: Optmise the range based operations
Date: Mon, 06 Sep 2010 11:26:30 +0100
Message-ID: <1283768790.1926.10.camel@e102109-lin.cambridge.arm.com>
References: <1280598372-4830-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41279 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab0IFK0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 06:26:36 -0400
In-Reply-To: <1280598372-4830-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sat, 2010-07-31 at 23:16 +0530, Santosh Shilimkar wrote:
> For the big buffers which are in excess of cache size, the maintaince
> operations by PA are very slow. For such buffers the maintainace
> operations can be speeded up by using the WAY based method.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/mm/cache-l2x0.c |   95 ++++++++++++++++++++++++++++------------------
>  1 files changed, 58 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index b2938d4..c0d6108 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -116,6 +116,18 @@ static void l2x0_flush_all(void)
>  	spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
>  
> +static void l2x0_clean_all(void)
> +{
> +	unsigned long flags;
> +
> +	/* clean all ways */
> +	spin_lock_irqsave(&l2x0_lock, flags);
> +	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
> +	cache_wait(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);

In case you'll base this on top of my PL310 optimisation, you should use
cache_wait_way() as the cache_wait() becomes a no-op.

>  static void l2x0_clean_range(unsigned long start, unsigned long end)
>  {
> -	void __iomem *base = l2x0_base;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&l2x0_lock, flags);
> -	start &= ~(CACHE_LINE_SIZE - 1);
> -	while (start < end) {
> -		unsigned long blk_end = start + min(end - start, 4096UL);
> +	if ((end - start) >= l2x0_size) {
> +		l2x0_clean_all();
> +	} else {
> +		void __iomem *base = l2x0_base;
> +		unsigned long flags, blk_end;

Minor thing - the patch may be cleaner if we use a 'return' instead of
'else' to avoid further indentation (same for the other functions):

	if ((end - start) >= l2x0_size) {
		l2x0_clean_all();
		return;
	}

Otherwise the patch looks fine to me.

-- 
Catalin

