From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v5 0/7] Per-user clock constraints
Date: Fri, 31 Oct 2014 13:33:58 +0200
Message-ID: <20141031113358.GY32045@tbergstrom-lnx.Nvidia.com>
References: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13487 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781AbaJaLeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2014 07:34:20 -0400
Content-Disposition: inline
In-Reply-To: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Boyd <sboyd@codeaurora.org>, Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Haojian Zhuang <haojian.zhuang@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-omap@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>, Matt Porter <mporter@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Zhangfei Gao <zhangfei.gao@linaro.org>

On Thu, Oct 30, 2014 at 11:48:26AM +0100, Tomeu Vizoso wrote:
> Hello,
> 
> this fifth version of the series has just one change, suggested by Stephen:
> 
> * Initialize clk.ceiling_constraint to ULONG_MAX and warn about new floor
> constraints being higher than the existing ceiling.
> 
> The first five patches are just cleanups that should be desirable on their own,
> and that should make easier to review the actual per-user clock patch.
> 
> The sixth patch actually moves the per-clock data that was stored in struct
> clk to a new struct clk_core and adds references to it from both struct clk and
> struct clk_hw. struct clk is now ready to contain information that is specific
> to a given clk consumer.
> 
> The seventh patch adds API for setting floor and ceiling constraints and stores
> that information on the per-user struct clk, which is iterable from struct
> clk_core.
> 
> They are based on top of 3.18-rc1.
> 
> http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v5
> 

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

Mike,

Do you think this will be merged for 3.19?

Thanks,

Peter.
