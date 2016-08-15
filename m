From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v1 02/14] clk: twl6040: Register the clock as
 of_clk_provider
Date: Mon, 15 Aug 2016 12:10:24 -0700
Message-ID: <20160815191024.GX361@codeaurora.org>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
 <20160530085522.30398-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160530085522.30398-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: mturquette@baylibre.com, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On 05/30, Peter Ujfalusi wrote:
> In order ot be able to use the pdmclk clock via DT it need to be registered
> as of_clk_provide.
> Since the twl6040 clock driver does not have it's own DT node, use the
> parent's node for registering.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
