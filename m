From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 1/8] ARM: OMAP: clk: add support for omap_clk_for_each
Date: Mon, 16 Jul 2012 15:34:39 +0530
Message-ID: <5003E737.60406@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com> <1342189185-5306-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:54143 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab2GPKEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 06:04:46 -0400
Received: by obfk16 with SMTP id k16so20904809obf.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 03:04:45 -0700 (PDT)
In-Reply-To: <1342189185-5306-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> This works similarly to e.g. pwrdm_for_each(). Needed by enhanced
> usecounting debug functionality that will be added to pm-debug.

OMAP clock framework has its own debugfs entry (/debug/clock) to expose
usecounts for clocks, so does the COMMON clock framework (/debug/clk).
Maybe there isn't one which dumps usecounts for the complete tree,
instead there is one per each clock node.

I agree having a complete dump of the clock tree usecounts can be
useful, but can we keep it in /debug/clock for now?
The reason I am saying this is because once we move from OMAP clock to
COMMON clock, something like what 'omap_clk_for_each' does will
not be possible anyway. We might have to add the support for
dumping complete tree usecounts into the COMMON clock core.

>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/plat-omap/clock.c              |   33 +++++++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/clock.h |    2 +
>   2 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 706b7e2..ad9dc59 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -355,6 +355,39 @@ int omap_clk_enable_autoidle_all(void)
>   	return 0;
>   }
>
> +/**
> + * omap_clk_for_each - call a function for each registered clock
> + * @fn: pointer to callback function
> + * @data: void * data to pass to callback function
> + *
> + * Call @fn for each registered clock, passing @data to each function.
> + * @fn must return 0 for success or any other value for failure. If
> + * @fn returns non-zero, the iteration across clocks will stop and
> + * the non-zero return value will be passed to the caller of
> + * omap_clk_for_each(). @fn is called with clockfw_lock held.
> + */
> +int omap_clk_for_each(int (*fn)(struct clk *clk, void *user), void *user)
> +{
> +	struct clk *c;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!fn)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +
> +	list_for_each_entry(c,&clocks, node) {
> +		ret = fn(c, user);
> +		if (ret)
> +			break;
> +	}
> +
> +	spin_unlock_irqrestore(&clockfw_lock, flags);
> +
> +	return ret;
> +}
> +
>   int omap_clk_disable_autoidle_all(void)
>   {
>   	struct clk *c;
> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> index d0ef57c..998947e 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -294,6 +294,8 @@ extern void propagate_rate(struct clk *clk);
>   extern void recalculate_root_clocks(void);
>   extern unsigned long followparent_recalc(struct clk *clk);
>   extern void clk_enable_init_clocks(void);
> +extern int omap_clk_for_each(int (*fn)(struct clk *clk, void *user),
> +				void *user);
>   unsigned long omap_fixed_divisor_recalc(struct clk *clk);
>   extern struct clk *omap_clk_get_by_name(const char *name);
>   extern int omap_clk_enable_autoidle_all(void);

