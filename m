From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to clk_hw_get_name(hw)
Date: Thu, 13 Aug 2015 10:56:31 +0200
Message-ID: <55CC5BBF.9060600@gmail.com>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org> <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Tero Kristo <t-kristo@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Bresticker <abrestic@chromium.org>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Kevin Cernekee <cernekee@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/13/2015 01:12 AM, Stephen Boyd wrote:
> Use the provider based method to get a clock's name so that we
> can get rid of the clk member in struct clk_hw one day. Mostly
> converted with the following coccinelle script.
>
> @@
> struct clk_hw *E;
> @@
>
> -__clk_get_name(E->clk)
> +clk_hw_get_name(E)
[...]
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>   drivers/clk/berlin/berlin2-pll.c     |  4 ++--

For Berlin,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks!

[...]
> diff --git a/drivers/clk/berlin/berlin2-pll.c b/drivers/clk/berlin/berlin2-pll.c
> index f4b8d324b083..1c2294d3ba85 100644
> --- a/drivers/clk/berlin/berlin2-pll.c
> +++ b/drivers/clk/berlin/berlin2-pll.c
> @@ -61,7 +61,7 @@ berlin2_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>   	fbdiv = (val >> map->fbdiv_shift) & FBDIV_MASK;
>   	rfdiv = (val >> map->rfdiv_shift) & RFDIV_MASK;
>   	if (rfdiv == 0) {
> -		pr_warn("%s has zero rfdiv\n", __clk_get_name(hw->clk));
> +		pr_warn("%s has zero rfdiv\n", clk_hw_get_name(hw));
>   		rfdiv = 1;
>   	}
>
> @@ -70,7 +70,7 @@ berlin2_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>   	vcodiv = map->vcodiv[vcodivsel];
>   	if (vcodiv == 0) {
>   		pr_warn("%s has zero vcodiv (index %d)\n",
> -			__clk_get_name(hw->clk), vcodivsel);
> +			clk_hw_get_name(hw), vcodivsel);
>   		vcodiv = 1;
>   	}
