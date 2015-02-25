From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] clk: ti: Fix FAPLL parent enable bit handling
Date: Wed, 25 Feb 2015 12:07:52 -0800
Message-ID: <20150225200752.421.26748@quantum>
References: <20150128170048.GO28663@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150128170048.GO28663@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2015-01-28 09:00:49)
> Commit 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
> added basic support for the FAPLL on dm818x, but has a bug for the
> parent PLL enable bit. The FAPLL_MAIN_PLLEN is defined as BIT(3)
> but the code is doing a shift on it.
> 
> This means the parent PLL won't get disabled even if all it's child
> synthesizers are disabled.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Missed this one for 3.20. Applied to clk-fixes.

Regards,
Mike

> 
> --- a/drivers/clk/ti/fapll.c
> +++ b/drivers/clk/ti/fapll.c
> @@ -84,7 +84,7 @@ static int ti_fapll_enable(struct clk_hw *hw)
>         struct fapll_data *fd = to_fapll(hw);
>         u32 v = readl_relaxed(fd->base);
>  
> -       v |= (1 << FAPLL_MAIN_PLLEN);
> +       v |= FAPLL_MAIN_PLLEN;
>         writel_relaxed(v, fd->base);
>  
>         return 0;
> @@ -95,7 +95,7 @@ static void ti_fapll_disable(struct clk_hw *hw)
>         struct fapll_data *fd = to_fapll(hw);
>         u32 v = readl_relaxed(fd->base);
>  
> -       v &= ~(1 << FAPLL_MAIN_PLLEN);
> +       v &= ~FAPLL_MAIN_PLLEN;
>         writel_relaxed(v, fd->base);
>  }
>  
> @@ -104,7 +104,7 @@ static int ti_fapll_is_enabled(struct clk_hw *hw)
>         struct fapll_data *fd = to_fapll(hw);
>         u32 v = readl_relaxed(fd->base);
>  
> -       return v & (1 << FAPLL_MAIN_PLLEN);
> +       return v & FAPLL_MAIN_PLLEN;
>  }
>  
>  static unsigned long ti_fapll_recalc_rate(struct clk_hw *hw,
