From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: move the common clock's to_clk_*(_hw) macros to
 clk-provider.h
Date: Mon, 1 Feb 2016 17:09:39 -0800
Message-ID: <20160202010939.GF4848@codeaurora.org>
References: <568F9960.9040209@gmail.com>
 <704f6d5aa50acc4723f6756c217a865641d927fe.1452267334.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <704f6d5aa50acc4723f6756c217a865641d927fe.1452267334.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Joachim Eastwood <manabian@gmail.com>, Tero Kristo <t-kristo@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/08, Geliang Tang wrote:
> to_clk_*(_hw) macros have been repeatedly defined in many places.
> This patch moves all the to_clk_*(_hw) definitions in the common
> clock framework to public header clk-provider.h, and drop the local
> definitions.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
