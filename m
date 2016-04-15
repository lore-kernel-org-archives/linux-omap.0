From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dflt: remove redundant unlikely
Date: Fri, 15 Apr 2016 15:52:50 -0700
Message-ID: <20160415225250.GZ14441@codeaurora.org>
References: <1459880937-22349-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459880937-22349-1-git-send-email-s-anna@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/05, Suman Anna wrote:
> Commit 7aba4f5201d1 ("clk: ti: dflt: fix enable_reg validity check")
> fixed a validation check by using an IS_ERR() macro within the
> existing unlikely expression, but IS_ERR() macro already has an
> unlikely inside it, so get rid of the redundant unlikely macro
> from the validation check.
> 
> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
