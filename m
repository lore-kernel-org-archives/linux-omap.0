From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/1] Add timer_32k_ck alias for dm816x in clk-816x.c
Date: Mon, 15 Jun 2015 22:38:14 +0300
Message-ID: <557F29A6.8040109@ti.com>
References: <CAFZh4h-ABVJ=TrePiZvv3vwNGx_CmeqFg3ck4OqCmws5UF8Q9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54530 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbbFOTiO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2015 15:38:14 -0400
In-Reply-To: <CAFZh4h-ABVJ=TrePiZvv3vwNGx_CmeqFg3ck4OqCmws5UF8Q9w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Hutchinson <b.hutchman@gmail.com>, mturquette@linaro.org, sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, paul@pwsan.com, Tony Lindgren <tony@atomide.com>

Subject should have clk: ti: in the beginning.

On 06/15/2015 09:54 PM, Brian Hutchinson wrote:
> dm816x needs timer_32k_ck alias to use dual mode timers in dmtimers.c
>
> This adds a timer_32k_ck alias for sys_32_ck in clk-816x.c so
> omap_dm_timer_set_source will work for dm816x.

Use checkpatch please. Or use a mailer that doesn't convert tabs to 
spaces. This patch seems to have something else that is strange also.

>
> Cc: Paul Walmsley <paul@pwsan.com <mailto:paul@pwsan.com>>
> Cc: Tero Kristo <t-kristo@ti.com <mailto:t-kristo@ti.com>>
> Cc: Tony Lindgren <tony@atomide.com <mailto:tony@atomide.com>>
> Signed-off-by: Brian Hutchinson <b.hutchman@gmail.com
> <mailto:b.hutchman@gmail.com>>
>
> --- drivers/clk/ti/clk-816x.c_orig      2015-06-15 13:46:53.058128064 -0400
> +++ drivers/clk/ti/clk-816x.c   2015-06-15 13:47:28.966306123 -0400

What is that _orig here? Are you using git to generate the patches?

-Tero

> @@ -18,6 +18,7 @@ static struct ti_dt_clk dm816x_clks[] =
>          DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
>          DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
>          DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
> +       DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
>          DT_CLK(NULL, "mpu_ck", "mpu_ck"),
>          DT_CLK(NULL, "timer1_fck", "timer1_fck"),
>          DT_CLK(NULL, "timer2_fck", "timer2_fck"),

