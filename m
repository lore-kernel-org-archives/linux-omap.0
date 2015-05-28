From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv3 01/27] ARM: OMAP2+: clock: export driver API to
 setup/get clock features
Date: Thu, 28 May 2015 15:04:10 -0700
Message-ID: <20150528220410.GG24204@codeaurora.org>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <1432566032-10860-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52553 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbE1WEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 18:04:11 -0400
Content-Disposition: inline
In-Reply-To: <1432566032-10860-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 05/25, Tero Kristo wrote:
> +
> +/**
> + * ti_clk_get_features - get clock driver features flags
> + *
> + * Get TI clock driver features description. Returns a pointer
> + * to the current feature setup.
> + */
> +struct ti_clk_features *ti_clk_get_features(void)

const?

> +{
> +	return &ti_clk_features;
> +}
>  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
