From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
Date: Wed, 30 May 2018 23:03:50 -0500
Message-ID: <20180531040350.GA25132@rob-hp-laptop>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180530141133.3711-4-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, May 30, 2018 at 07:41:30PM +0530, Faiz Abbas wrote:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver
> 
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         | 1 +
>  include/dt-bindings/clock/dra7.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index fb249a1637a5..71a122b2dc67 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -708,6 +708,7 @@ static const struct omap_clkctrl_reg_data dra7_wkupaon_clkctrl_regs[] __initcons
>  	{ DRA7_COUNTER_32K_CLKCTRL, NULL, 0, "wkupaon_iclk_mux" },
>  	{ DRA7_UART10_CLKCTRL, dra7_uart10_bit_data, CLKF_SW_SUP, "wkupaon_cm:clk:0060:24" },
>  	{ DRA7_DCAN1_CLKCTRL, dra7_dcan1_bit_data, CLKF_SW_SUP, "wkupaon_cm:clk:0068:24" },
> +	{ DRA7_ADC_CLKCTRL, NULL, CLKF_SW_SUP, "mcan_clk" },
>  	{ 0 },
>  };
>  
> diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
> index 5e1061b15aed..d7549c57cac3 100644
> --- a/include/dt-bindings/clock/dra7.h
> +++ b/include/dt-bindings/clock/dra7.h
> @@ -168,5 +168,6 @@
>  #define DRA7_COUNTER_32K_CLKCTRL	DRA7_CLKCTRL_INDEX(0x50)
>  #define DRA7_UART10_CLKCTRL	DRA7_CLKCTRL_INDEX(0x80)
>  #define DRA7_DCAN1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x88)
> +#define DRA7_ADC_CLKCTRL	DRA7_CLKCTRL_INDEX(0xa0)

ADC and mcan are the same thing?

>  
>  #endif
> -- 
> 2.17.0
> 
