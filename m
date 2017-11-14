From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] clk: ti: dra7-atl-clock: fix child-node lookups
Date: Tue, 14 Nov 2017 15:53:32 -0800
Message-ID: <20171114235332.GF11955@codeaurora.org>
References: <20171111162929.11722-1-johan@kernel.org>
 <20171111162929.11722-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171111162929.11722-2-johan@kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 11/11, Johan Hovold wrote:
> Fix child node-lookup during probe, which ended up searching the whole
> device tree depth-first starting at parent rather than just matching on
> its children.
> 
> Note that the original premature free of the parent node has already
> been fixed separately, but that fix was apparently never backported to
> stable.
> 
> Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
> Fixes: 660e15519399 ("clk: ti: dra7-atl-clock: Fix of_node reference counting")
> Cc: stable <stable@vger.kernel.org>     # 3.16: 660e15519399
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
