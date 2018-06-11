From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
Date: Mon, 11 Jun 2018 12:22:43 -0600
Message-ID: <20180611182243.GA12727@rob-hp-laptop>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606060826.14671-3-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 06, 2018 at 11:38:22AM +0530, Faiz Abbas wrote:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver
> 
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         | 1 +
>  include/dt-bindings/clock/dra7.h | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 2 insertions(+)
> 
