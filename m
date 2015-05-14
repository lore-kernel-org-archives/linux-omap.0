From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFT PATCH 1/8] clk: ti: dra7-atl-clock: Fix possible ERR_PTR
 dereference
Date: Thu, 14 May 2015 15:31:02 -0700
Message-ID: <20150514223102.GA31753@codeaurora.org>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
 <1431500087-2275-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431500087-2275-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/13, Krzysztof Kozlowski wrote:
> of_clk_get_from_provider() returns ERR_PTR on failure. The
> dra7-atl-clock driver was not checking its return value and immediately
> used it in __clk_get_hw().  __clk_get_hw() dereferences supplied clock,
> if it is not NULL, so in that case it would dereference an ERR_PTR.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
