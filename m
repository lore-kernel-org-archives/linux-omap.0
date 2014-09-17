From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] CLK: TI: consider the fact that of_clk_get() might return
 an error
Date: Wed, 17 Sep 2014 07:52:33 -0500
Message-ID: <54198411.1080706@ti.com>
References: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44307 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbaIQMwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 08:52:35 -0400
Received: by mail-oi0-f43.google.com with SMTP id v63so784856oia.30
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2014 05:52:34 -0700 (PDT)
In-Reply-To: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org

On 09/11/2014 11:01 AM, Sebastian Andrzej Siewior wrote:
> I "forgot" to update the dtb and the kernel crashed:
> |Unable to handle kernel NULL pointer dereference at virtual address 0000002e
> |PC is at __clk_get_flags+0x4/0xc
> |LR is at ti_dt_clockdomains_setup+0x70/0xe8
>
> because I did not have the clock nodes. of_clk_get() returns an error
> pointer which is not checked here.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   drivers/clk/ti/clockdomain.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
> index f1e0038d76ac..fdd458600c2c 100644
> --- a/drivers/clk/ti/clockdomain.c
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -36,6 +36,11 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
>
>   	for (i = 0; i < num_clks; i++) {
>   		clk = of_clk_get(node, i);
> +		if (IS_ERR(clk)) {
> +			pr_err("Failed get %s' clock nr %d (%ld)\n",
> +					node->full_name, i, PTR_ERR(clk));


Could you add %s: __func__ as well - it kinda helps understand this is 
part of clockdomain setup and not some driver cribbing that it did not 
get some clock.

> +			continue;
> +		}
>   		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
>   			pr_warn("can't setup clkdm for basic clk %s\n",
>   				__clk_get_name(clk));
>

