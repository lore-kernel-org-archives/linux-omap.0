From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v4 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be
 more maintainable
Date: Wed, 14 Dec 2011 16:03:14 +0400
Message-ID: <20111214120314.GA9841@oksana.dev.rtsoft.ru>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323862781-3465-2-git-send-email-dave.martin@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 11:39:37AM +0000, Dave Martin wrote:
> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms have a L2x0 or
> PL310 cache controller to the individual machines.  To enable this,
> a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
> machines to indicate that they may have such a cache controller
> independently of each other.
> 
> Boards/SoCs which cannot reliably operate without the L2 cache
> controller support will need to select CACHE_L2X0 directly from
> their own Kconfigs instead.  This applies to some TrustZone-enabled
> boards where Linux runs in the Normal World, for example.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

For CNS3xxx bits:

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
