From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/5] [RFC] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
Date: Wed, 3 Jun 2015 16:44:27 -0700
Message-ID: <20150603234426.GB490@codeaurora.org>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
 <1432891549-23295-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45838 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbFCXoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 19:44:30 -0400
Content-Disposition: inline
In-Reply-To: <1432891549-23295-6-git-send-email-geert+renesas@glider.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org, kernel@stlinux.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/29, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is an RFC, as it depends on "[RFC] clk: Provide dummy
> of_clk_get_parent_count() for !OF/!CCF".
> ---
>  arch/arm/common/timer-sp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> index 19211324772f387c..be87a5d480ffb655 100644
> --- a/arch/arm/common/timer-sp.c
> +++ b/arch/arm/common/timer-sp.c
> @@ -21,6 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
> +#include <linux/clk-provider.h>

This looks weird. This is not a clock provider.

>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -234,7 +235,7 @@ static void __init sp804_of_init(struct device_node *np)
>  		clk1 = NULL;
>  
>  	/* Get the 2nd clock if the timer has 3 timer clocks */
> -	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
> +	if (of_clk_get_parent_count(np) == 3) {

So maybe it means if we want to expose of_clk_get_parent_count()
we should move it to some other header file (of_clk.h?). And then
maybe we should always compile said helpers if OF=y and
HAVE_CLK=y.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
