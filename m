From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 5/5] drivers: bus: omap_l3: Change pr_crit() to
 dev_err() when IRQ request fails
Date: Tue, 4 Mar 2014 22:37:22 +0800
Message-ID: <5315E522.9090606@ti.com>
References: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com>
 <1393937293-6036-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393937293-6036-6-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 04 March 2014 08:48 PM, Peter Ujfalusi wrote:
> Use dev_err() which will going to print the driver's name as well and the
> KERN_ERR level is sufficient in this case (we also print via dev_err when
> there is an error with the mem resources)
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/bus/omap_l3_noc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> index 0eff48585ae3..972691a668a3 100644
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@ -158,8 +158,8 @@ static int omap4_l3_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt_handler,
>  			       IRQF_DISABLED, "l3-dbg-irq", l3);
>  	if (ret) {
> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
> -						l3->debug_irq);
> +		dev_err(&pdev->dev, "request_irq failed for %d\n",
> +			l3->debug_irq);
>  		return ret;
>  	}
>  
> @@ -167,8 +167,7 @@ static int omap4_l3_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_handler,
>  			       IRQF_DISABLED, "l3-app-irq", l3);
>  	if (ret)
> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
> -						l3->app_irq);
> +		dev_err(&pdev->dev, "request_irq failed for %d\n", l3->app_irq);
>  
>  	return ret;
>  }
> 
So this one change in the log level. If I look at now, may be dev_err
is fine but the change is not same.

Apart from above comment, rest of the series looks fine to me.
Feel free to add my ack...

Regards,
Santosh
