From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 01/27] ARM: OMAP2+: clock: export driver API to
 setup/get clock features
Date: Tue, 19 May 2015 18:19:01 -0700
Message-ID: <20150520011901.GB31054@codeaurora.org>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39702 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbbETBTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 21:19:03 -0400
Content-Disposition: inline
In-Reply-To: <1431334493-24455-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 05/11, Tero Kristo wrote:
> +
> +/**
> + * ti_clk_get_features - get clock driver features flags
> + *
> + * Get TI clock driver features description. Returns a pointer
> + * to the current feature setup.
> + */
> +struct ti_clk_features *ti_clk_get_features(void)

Should this return a const pointer?

> +{
> +	return &ti_clk_features;
> +}
>  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
