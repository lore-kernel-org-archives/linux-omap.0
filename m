From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH][next] clk: ti: check for null return in strrchr to avoid
 null dereferencing
Date: Thu, 27 Jul 2017 09:05:13 +0300
Message-ID: <a39a4ba7-809d-a4af-6547-473978749451@ti.com>
References: <20170726235627.9163-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170726235627.9163-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 27/07/17 02:56, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> strrchr can potentially return a null so the following strlen on the
> null pointer can cause a null dereference. Add a check to see if
> the string postfix is not null before calling strlen.
> 
> Detected by CoverityScan, CID#1452039 ("Dereference null return")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/clk/ti/adpll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> index 255cafb18336..bd7cb9a413c9 100644
> --- a/drivers/clk/ti/adpll.c
> +++ b/drivers/clk/ti/adpll.c
> @@ -222,7 +222,7 @@ static int ti_adpll_setup_clock(struct ti_adpll_data *d, struct clk *clock,
>   
>   	/* Separate con_id in format "pll040dcoclkldo" to fit MAX_CON_ID */
>   	postfix = strrchr(name, '.');
> -	if (strlen(postfix) > 1) {
> +	if (postfix && strlen(postfix) > 1) {
>   		if (strlen(postfix) > ADPLL_MAX_CON_ID)
>   			dev_warn(d->dev, "clock %s con_id lookup may fail\n",
>   				 name);
> 

Looks fine to me.

Acked-by: Tero Kristo <t-kristo@ti.com>
