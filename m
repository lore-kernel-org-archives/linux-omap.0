From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v12 4/6] clk: Add rate constraints to clocks
Date: Thu, 22 Jan 2015 14:48:47 -0800
Message-ID: <20150122224847.GQ27202@codeaurora.org>
References: <1421943207-5180-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421943207-5180-5-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421943207-5180-5-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Manuel Lauss <manuel.lauss@gmail.com>, Alex Elder <elder@linaro.org>, Matt Porter <mporter@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Bintian Wang <bintian.wang@huawei.com>, Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-omap@vger.kernel.org

On 01/22, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This
> can be used for thermal drivers to set minimum rates, or by misc.
> drivers to set maximum rates to assure a minimum performance level.
> 
> Changes the signature of the determine_rate callback by adding the
> parameters min_rate and max_rate.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
