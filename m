From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to clk_hw_get_name(hw)
Date: Thu, 13 Aug 2015 09:40:07 -0700
Message-ID: <CAL1qeaE-UJD3CBx=6feF=Hu4=gu5AtQiWwQAZmbg+6qYLhOy2Q@mail.gmail.com>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
	<1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Tero Kristo <t-kristo@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Kevin Cernekee <cernekee@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 12, 2015 at 4:12 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
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
>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Kevin Cernekee <cernekee@chromium.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

>  drivers/clk/pistachio/clk-pll.c      |  4 ++--

For Pistachio,

Acked-by: Andrew Bresticker <abrestic@chromium.org>
