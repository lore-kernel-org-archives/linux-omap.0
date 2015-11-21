From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dra7: constify clk_hw_omap_ops structure
Date: Fri, 20 Nov 2015 16:31:30 -0800
Message-ID: <20151121003130.GB28998@codeaurora.org>
References: <1447616894-31717-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447616894-31717-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-clk-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tero Kristo <t-kristo@ti.com>, kernel-janitors@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/15, Julia Lawall wrote:
> The clk_hw_omap_ops structures are never modified, so declare this one as
> const, like the others.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
