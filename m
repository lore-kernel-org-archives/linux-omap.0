From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 06/28] clk: ti: clkctrl: add support for retrying
 failed init
Date: Mon, 13 Nov 2017 18:07:14 -0800
Message-ID: <20171114020714.GW11955@codeaurora.org>
References: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
 <1510218917-1725-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510218917-1725-4-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 11/09, Tero Kristo wrote:
> In case the clkctrl node contains assigned-clock-* entries, registering
> the provider can fail with -EPROBE_DEFER. In this case, add the
> provider to the retry_init clock list so it will be cleaned up later.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
