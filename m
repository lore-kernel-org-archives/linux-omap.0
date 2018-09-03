From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] clk: Convert to using %pOFn instead of device_node.name
Date: Mon, 3 Sep 2018 13:29:39 +0800
Message-ID: <CAGb2v64axajQmvjt4Ht=3AG2Ybou_VP7v_m6mk4aa7CKyPDYbg@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-12-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-12-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>, "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 28, 2018 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>  drivers/clk/sunxi/clk-mod0.c        |  6 +++---
>  drivers/clk/sunxi/clk-sun9i-core.c  | 20 ++++++++++----------
>  drivers/clk/sunxi/clk-sunxi.c       |  4 ++--

For the sunxi bits,

Acked-by: Chen-Yu Tsai <wens@csie.org>
