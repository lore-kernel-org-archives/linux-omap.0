From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 01/29] clk: Add support for rate table based dividers
Date: Mon, 18 Jun 2012 13:04:42 -0700
Message-ID: <20120618200442.GA4402@gmail.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34792 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265Ab2FRUEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 16:04:51 -0400
Received: by dajt11 with SMTP id t11so8314435daj.24
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 13:04:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339678038-23082-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 20120614-18:16, Rajendra Nayak wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index e548c43..e4911ee 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -32,30 +32,69 @@
>  #define div_mask(d)	((1 << (d->width)) - 1)
>  #define is_power_of_two(i)	!(i & ~i)
>  
> +static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
> +{
> +	unsigned int maxdiv;
> +	const struct clk_div_table *clkt;
> +
> +	for (clkt = table; clkt->div; clkt++)
> +		if (clkt->div > maxdiv)
> +			maxdiv = clkt->div;
> +	return maxdiv;
> +}
> +

Hi Rajendra,

During testing the compiler warns that maxdiv is uninitialized here.

Regards,
Mike
