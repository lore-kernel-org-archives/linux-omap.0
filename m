From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] clk: prevent erronous parsing of children during rate change
Date: Wed, 03 Sep 2014 12:22:03 -0700
Message-ID: <20140903192203.11368.5520@quantum>
References: <1408628866-32351-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43718 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbaICTWU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 15:22:20 -0400
Received: by mail-pd0-f174.google.com with SMTP id ft15so11761491pdb.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2014 12:22:18 -0700 (PDT)
In-Reply-To: <1408628866-32351-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Quoting Tero Kristo (2014-08-21 06:47:45)
> In some cases, clocks can switch their parent with clk_set_rate, for
> example clk_mux can do this in some cases. Current implementation of
> clk_change_rate uses un-safe list iteration on the clock children, which
> will cause wrong clocks to be parsed in case any of the clock children
> change their parents during the change rate operation. Fixed by using
> the safe list iterator instead.
> 
> The problem was detected due to some divide by zero errors generated
> by clock init on dra7-evm board, see discussion under
> http://article.gmane.org/gmane.linux.ports.arm.kernel/349180 for details.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> To: Mike Turquette <mturquette@linaro.org>
> Reported-by: Nishanth Menon <nm@ti.com>

Applied to clk-fixes.

Thanks!
Mike

> ---
>  drivers/clk/clk.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b76fa69..bacc06f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1467,6 +1467,7 @@ static struct clk *clk_propagate_rate_change(struct clk *clk, unsigned long even
>  static void clk_change_rate(struct clk *clk)
>  {
>         struct clk *child;
> +       struct hlist_node *tmp;
>         unsigned long old_rate;
>         unsigned long best_parent_rate = 0;
>         bool skip_set_rate = false;
> @@ -1502,7 +1503,11 @@ static void clk_change_rate(struct clk *clk)
>         if (clk->notifier_count && old_rate != clk->rate)
>                 __clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
>  
> -       hlist_for_each_entry(child, &clk->children, child_node) {
> +       /*
> +        * Use safe iteration, as change_rate can actually swap parents
> +        * for certain clock types.
> +        */
> +       hlist_for_each_entry_safe(child, tmp, &clk->children, child_node) {
>                 /* Skip children who will be reparented to another clock */
>                 if (child->new_parent && child->new_parent != clk)
>                         continue;
> -- 
> 1.7.9.5
> 
