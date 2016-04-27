From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v7 1/9] clk: ti: am335x/am4372: Add tbclk to pwm node
Date: Wed, 27 Apr 2016 15:48:30 +0300
Message-ID: <5720B51E.6050106@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
 <1461710209-6563-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461710209-6563-2-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On 27/04/16 01:36, Franklin S Cooper Jr wrote:
> Add tblck to the pwm nodes. This insures that the ehrpwm driver has access
> to the time-based clk.
>
> Do not remove similar entries for ehrpwm node. Later patches will switch
> from using ehrpwm node name to pwm. But to maintain ABI compatibility we
> shouldn't remove the old entries.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

I don't like adding new clock aliases to the list as I am trying to get 
rid of them, but in this case we can't avoid it I believe. Thus,

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/clk/ti/clk-33xx.c | 3 +++
>   drivers/clk/ti/clk-43xx.c | 6 ++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
> index ef2ec64..0e47d95 100644
> --- a/drivers/clk/ti/clk-33xx.c
> +++ b/drivers/clk/ti/clk-33xx.c
> @@ -108,6 +108,9 @@ static struct ti_dt_clk am33xx_clks[] = {
>   	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
>   	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
>   	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
> +	DT_CLK("48300200.pwm", "tbclk", "ehrpwm0_tbclk"),
> +	DT_CLK("48302200.pwm", "tbclk", "ehrpwm1_tbclk"),
> +	DT_CLK("48304200.pwm", "tbclk", "ehrpwm2_tbclk"),
>   	{ .node_name = NULL },
>   };
>
> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
> index 097fc90..7255aa8 100644
> --- a/drivers/clk/ti/clk-43xx.c
> +++ b/drivers/clk/ti/clk-43xx.c
> @@ -115,6 +115,12 @@ static struct ti_dt_clk am43xx_clks[] = {
>   	DT_CLK("48306200.ehrpwm", "tbclk", "ehrpwm3_tbclk"),
>   	DT_CLK("48308200.ehrpwm", "tbclk", "ehrpwm4_tbclk"),
>   	DT_CLK("4830a200.ehrpwm", "tbclk", "ehrpwm5_tbclk"),
> +	DT_CLK("48300200.pwm", "tbclk", "ehrpwm0_tbclk"),
> +	DT_CLK("48302200.pwm", "tbclk", "ehrpwm1_tbclk"),
> +	DT_CLK("48304200.pwm", "tbclk", "ehrpwm2_tbclk"),
> +	DT_CLK("48306200.pwm", "tbclk", "ehrpwm3_tbclk"),
> +	DT_CLK("48308200.pwm", "tbclk", "ehrpwm4_tbclk"),
> +	DT_CLK("4830a200.pwm", "tbclk", "ehrpwm5_tbclk"),
>   	{ .node_name = NULL },
>   };
>
>
