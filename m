From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] cpufreq: omap: clk_round_rate() can return a zero upon
 error
Date: Mon, 16 Dec 2013 09:58:58 -0500
Message-ID: <52AF1532.6030904@ti.com>
References: <alpine.DEB.2.02.1312091812440.4127@tamien>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54805 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573Ab3LPO7B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:59:01 -0500
In-Reply-To: <alpine.DEB.2.02.1312091812440.4127@tamien>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 09 December 2013 09:18 PM, Paul Walmsley wrote:
> 
> Treat both negative and zero return values from clk_round_rate() as errors.  This is needed since subsequent patches will convert clk_round_rate()'s return value to be an unsigned type, rather than a signed type, since some clock sources can generate rates higher than (2^31)-1 Hz.
> 
> Eventually, when calling clk_round_rate(), only a return value of
> zero will be considered a error.  All other values will be
> considered valid rates.  The comparison against values less than
> 0 is kept to preserve the correct behavior in the meantime.
> 
> This patch also removes a bogus usage of IS_ERR_VALUE(), which is intended to be used only on combination pointer/error code return values; a side-benefit.
> 
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


