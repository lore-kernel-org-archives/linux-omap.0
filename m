From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap1: pm_bus: Fix compilation warning.
Date: Tue, 07 Dec 2010 14:23:02 -0800
Message-ID: <87lj41jk8p.fsf@deeprootsystems.com>
References: <1291641828-19909-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291641828-19909-1-git-send-email-marek.belisko@open-nandra.com>
	(Marek Belisko's message of "Mon, 6 Dec 2010 14:23:48 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Marek Belisko <marek.belisko@open-nandra.com> writes:

> Fix following compilation warning:
> arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
> arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'
>
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap1/pm_bus.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
> index 8b66392..f97c6e9 100644
> --- a/arch/arm/mach-omap1/pm_bus.c
> +++ b/arch/arm/mach-omap1/pm_bus.c
> @@ -48,7 +48,6 @@ static int omap1_pm_runtime_suspend(struct device *dev)
>  
>  static int omap1_pm_runtime_resume(struct device *dev)
>  {
> -	int ret = 0;
>  	struct clk *iclk, *fclk;
>  
>  	dev_dbg(dev, "%s\n", __func__);
