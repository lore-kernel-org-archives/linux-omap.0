From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/3] clk: let init callback return an error code
Date: Tue, 24 Sep 2019 18:19:39 +0200
Message-ID: <20190924161939.GD28770@lunn.ch>
References: <20190924123954.31561-1-jbrunet@baylibre.com>
 <20190924123954.31561-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190924123954.31561-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Tero Kristo <t-kristo@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 24, 2019 at 02:39:53PM +0200, Jerome Brunet wrote:
> If the init callback is allowed to request resources, it needs a return
> value to report the outcome of such a request.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
>  Sorry about the spam.
>  This patch change quite a few files so I have tried to Cc the
>  relevant people. Stephen, You may notice that I have added a
>  couple of the network people. You need an Ack from one of them
>  since the Amlogic G12a mdio mux has a clock which uses the .init()
>  callback

>  static void __init of_ti_clockdomain_setup(struct device_node *node)
> diff --git a/drivers/net/phy/mdio-mux-meson-g12a.c b/drivers/net/phy/mdio-mux-meson-g12a.c
> index 7a9ad54582e1..bf86c9c7a288 100644
> --- a/drivers/net/phy/mdio-mux-meson-g12a.c
> +++ b/drivers/net/phy/mdio-mux-meson-g12a.c
> @@ -123,7 +123,7 @@ static int g12a_ephy_pll_is_enabled(struct clk_hw *hw)
>  	return (val & PLL_CTL0_LOCK_DIG) ? 1 : 0;
>  }
>  
> -static void g12a_ephy_pll_init(struct clk_hw *hw)
> +static int g12a_ephy_pll_init(struct clk_hw *hw)
>  {
>  	struct g12a_ephy_pll *pll = g12a_ephy_pll_to_dev(hw);
>  
> @@ -136,6 +136,8 @@ static void g12a_ephy_pll_init(struct clk_hw *hw)
>  	writel(0x20200000, pll->base + ETH_PLL_CTL5);
>  	writel(0x0000c002, pll->base + ETH_PLL_CTL6);
>  	writel(0x00000023, pll->base + ETH_PLL_CTL7);
> +
> +	return 0;
>  }

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It should be safe to merge this via the clk tree. You would probably
know about an possible merge conflicts, since you wrote this driver!

    Andrew
