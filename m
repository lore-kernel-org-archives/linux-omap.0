From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dra7-atl-clock: Fix of_node reference counting
Date: Fri, 15 Apr 2016 17:47:41 -0700
Message-ID: <20160416004741.GQ26353@codeaurora.org>
References: <1457705612-7684-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457705612-7684-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: t-kristo@ti.com, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 03/11, Peter Ujfalusi wrote:
> of_find_node_by_name() will call of_node_put() on the node so we need to
> get it first to avoid warnings.
> The cfg_node needs to be put after we have finished processing the
> properties.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
