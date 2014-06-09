From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Mon, 9 Jun 2014 09:56:59 +0800
Message-ID: <20140609015658.GV8860@dragon>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 06, 2014 at 11:36:56AM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since the OPP layer is a kernel library which has been converted to be
> directly selectable by its callers rather than user selectable and
> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
> has become redundant and can be removed. Do so.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
...
>  arch/arm/mach-imx/Kconfig      | 1 -

Acked-by: Shawn Guo <shawn.guo@freescale.com>
