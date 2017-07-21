From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: Convert to using %pOF instead of full_name
Date: Fri, 21 Jul 2017 15:49:59 -0700
Message-ID: <20170721224959.GA2146@codeaurora.org>
References: <20170718214339.7774-12-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.orglinu
List-Id: linux-omap@vger.kernel.org

On 07/18, Rob Herring wrote:
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

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
