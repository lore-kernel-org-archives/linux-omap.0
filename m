From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 linux-next] clk: constify of_device_id array
Date: Wed, 01 Apr 2015 11:09:46 -0700
Message-ID: <551C346A.9040905@codeaurora.org>
References: <1427827843-30823-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427827843-30823-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/31/15 11:50, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> __initdata updated to __initconst for
> static const struct of_device_id ti_clkdm_match_table[]
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
>

Thanks. Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
