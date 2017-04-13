From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 13 Apr 2017 15:20:06 -0500
Message-ID: <20170413202006.k4qs3rttftzrcb43@rob-hp-laptop>
References: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 10, 2017 at 02:51:35PM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> V2:
> - Added more *-by tags.
> - Included TI DT and example files as well.
> 
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 20 +++----
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
>  Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
>  arch/arm/boot/dts/am4372.dtsi                      | 10 ++--
>  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
>  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
>  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
>  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
>  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
>  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
>  arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
>  arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  8 +--
>  arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
>  arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
>  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
>  arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
>  20 files changed, 295 insertions(+), 295 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
