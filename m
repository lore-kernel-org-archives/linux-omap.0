From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 REPOST 3/5] omap4: Unconditionally require l2x0 L2
 cache controller support
Date: Wed, 14 Dec 2011 13:48:27 -0800
Message-ID: <20111214214827.GM32251@atomide.com>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-4-git-send-email-dave.martin@linaro.org>
 <20111214181425.GB32251@atomide.com>
 <20111214183030.GB9331@linaro.org>
 <20111214183952.GG32251@atomide.com>
 <4EE90EB5.9070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EE90EB5.9070502@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robherring2@gmail.com> [111214 12:30]:
> 
> On 12/14/2011 12:39 PM, Tony Lindgren wrote:
> > 
> > I think we should keep L2 configurable for omaps until we have some
> > way of getting the configuration dynamically or from device tree.
> >  
> 
> This already exists with l2x0_of_init. OMAP just needs to start using
> it. It will initialize the l2 if present in the DT and skip it if not
> present.

That's great, that will allow doing the right thing with setting
up how to enable and disable it :) Considering that, this patch
should be OK to apply:

Acked-by: Tony Lindgren <tony@atomide.com>
