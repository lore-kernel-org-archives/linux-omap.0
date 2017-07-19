From: James Liao <jamesjj.liao@mediatek.com>
Subject: Re: [PATCH] clk: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 15:58:35 +0800
Message-ID: <1500451115.30067.1.camel@mtksdaap41>
References: <20170718214339.7774-12-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, Prashant Gaikwad <pgaikwad@nvidia.com>, Alexandre Torgue <alexandre.torgue@st.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-omap@vger.kernel.org, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Peter De Schrijver <pdeschrijver@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-tegra@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-renesas-soc@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>Maxime
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-07-18 at 16:42 -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> ---
>  drivers/clk/mediatek/clk-cpumux.c    |  2 +-
>  drivers/clk/mediatek/clk-mtk.c       |  2 +-
>  drivers/clk/mediatek/reset.c         |  2 +-

For clk/mediatek:
Acked-by: James Liao <jamesjj.liao@mediatek.com>


Best regards,

James
