From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v2] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
Date: Thu, 26 Jul 2018 20:54:26 +0200
Message-ID: <20180726185426.GA3546@lenoch>
References: <20180726133658.23902-1-drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180726133658.23902-1-drivshin@awxrd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Rivshin <drivshin@awxrd.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 26, 2018 at 09:36:58AM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
> 
> If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> data won't be set yet.
> 
> Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
> Cc: <stable@vger.kernel.org> # 4.17+
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> ---
> Changes in v2:
> * Added Pavel's Acked-by/Tested-by [1]
> 
> [1] https://lkml.org/lkml/2018/7/16/346
> 
>  drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 665da3c8fbceb..d3d7ea7a53146 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>  
>  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>  	if (!timer_pdata) {
> -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> -		ret = -EINVAL;
> +		dev_info(&pdev->dev,
> +			 "dmtimer pdata structure NULL, deferring probe\n");

This seems to be a bit verbose for EPROBE_DEFER case. Could we either remove
it as it is done later in pdata->request_by_node(timer) failure case or at
least make it dev_dbg? Otherwise thank you and with mentioned change
Acked-by: Ladislav Michl <ladis@linux-mips.org>

> +		ret = -EPROBE_DEFER;
>  		goto put;
>  	}
>  
> 
> base-commit: d72e90f33aa4709ebecc5005562f52335e106a60
> -- 
> 2.17.1
