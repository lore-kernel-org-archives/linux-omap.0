From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 2/4] clk: ti816x: Add missing dmtimer clkdev entries
Date: Tue, 24 Nov 2015 11:37:01 +0200
Message-ID: <56542FBD.8090404@ti.com>
References: <56461006.5080309@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56461006.5080309@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-clk@vger.kernel.org, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 11/13/2015 06:29 PM, Neil Armstrong wrote:
> Add missing clkdev dmtimer related entries for dm816x.
> 32Khz and ext sources were missing.
>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Your own sign-off should be at the top of the list, fixed this locally 
myself.

Queued for 4.4-rc-fixes, thanks.

-Tero

> ---
>   drivers/clk/ti/clk-816x.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
> index 1dfad0c..2a5d84f 100644
> --- a/drivers/clk/ti/clk-816x.c
> +++ b/drivers/clk/ti/clk-816x.c
> @@ -20,6 +20,8 @@ static struct ti_dt_clk dm816x_clks[] = {
>   	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
>   	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
>   	DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
> +	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
> +	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
>   	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
>   	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
>   	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
>
