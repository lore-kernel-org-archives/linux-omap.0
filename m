From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3] CLK: TI: consider the fact that of_clk_get() might
 return an error
Date: Mon, 29 Sep 2014 11:56:20 +0300
Message-ID: <54291EB4.9000906@ti.com>
References: <1410451272-31068-1-git-send-email-bigeasy@linutronix.de> <54198411.1080706@ti.com> <20140917155623.GA28043@linutronix.de> <20140917163559.GA25790@kahuna> <20140918143327.GA4418@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36142 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbaI2Izn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2014 04:55:43 -0400
In-Reply-To: <20140918143327.GA4418@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Mike Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

On 09/18/2014 05:33 PM, Sebastian Andrzej Siewior wrote:
> I "forgot" to update the dtb and the kernel crashed:
> |Unable to handle kernel NULL pointer dereference at virtual address =
0000002e
> |PC is at __clk_get_flags+0x4/0xc
> |LR is at ti_dt_clockdomains_setup+0x70/0xe8
>
> because I did not have the clock nodes. of_clk_get() returns an error
> pointer which is not checked here.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks, v3 applied to for-v3.18/ti-clk-drv.

-Tero

> ---
>   v2=E2=80=A6v3:
>      - added acked by
>      - fixed "CHECK: Alignment should match open parenthesis"
>
>   v1=E2=80=A6v2:
>       add "%s __func__" to the added pr_err
>
>   drivers/clk/ti/clockdomain.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomai=
n.c
> index f1e0038d76ac..b4c5faccaece 100644
> --- a/drivers/clk/ti/clockdomain.c
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -36,6 +36,11 @@ static void __init of_ti_clockdomain_setup(struct =
device_node *node)
>
>   	for (i =3D 0; i < num_clks; i++) {
>   		clk =3D of_clk_get(node, i);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: Failed get %s' clock nr %d (%ld)\n",
> +			       __func__, node->full_name, i, PTR_ERR(clk));
> +			continue;
> +		}
>   		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
>   			pr_warn("can't setup clkdm for basic clk %s\n",
>   				__clk_get_name(clk));
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
