From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] clk: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 12:24:58 +0200
Message-ID: <2fd832a5-ec78-7563-8349-4321db745767@gmail.com>
References: <20170718214339.7774-12-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?Q?Emilio_L=c3=b3pez?= <emilio@elopez.com.ar>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 07/18/2017 11:42 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: "Emilio López" <emilio@elopez.com.ar>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>   drivers/clk/berlin/bg2.c             |  3 +--
>   drivers/clk/berlin/bg2q.c            |  7 +++----
>   drivers/clk/clk-asm9260.c            |  4 ++--
>   drivers/clk/clk-conf.c               | 16 ++++++++--------
>   drivers/clk/clk-moxart.c             | 12 ++++++------
>   drivers/clk/clk-qoriq.c              |  7 +++----
>   drivers/clk/clk-stm32f4.c            |  4 ++--
>   drivers/clk/clk-xgene.c              | 15 ++++++---------
>   drivers/clk/clk.c                    |  4 ++--
>   drivers/clk/clkdev.c                 |  4 ++--
>   drivers/clk/mediatek/clk-cpumux.c    |  2 +-
>   drivers/clk/mediatek/clk-mtk.c       |  2 +-
>   drivers/clk/mediatek/reset.c         |  2 +-

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

For the mediatek parts.

Thanks,
Matthias
