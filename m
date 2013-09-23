From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 5/5] dma: cppi41: add support for suspend and resume
Date: Mon, 23 Sep 2013 09:39:47 +0530
Message-ID: <20130923040947.GV17188@intel.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com>
 <1379861404-8250-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379861404-8250-6-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 22, 2013 at 04:50:04PM +0200, Daniel Mack wrote:
> This patch adds support for suspend/resume functionality to the cppi41
> DMA driver. The steps necessary to make the system resume properly were
> figured out by trial-and-error. The code as it stands now is the
> minimum that has to be done to put the musb host system on an AM33xx
> system into an operable state after resume.
> 
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 3347321..89decc9 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -1040,12 +1040,41 @@ static int cppi41_dma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
ahhhh

> +static int cppi41_suspend(struct device *dev)
> +{
> +	struct cppi41_dd *cdd = dev_get_drvdata(dev);
> +
> +	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
> +	disable_sched(cdd);
> +
> +	return 0;
> +}
> +
> +static int cppi41_resume(struct device *dev)
> +{
> +	struct cppi41_dd *cdd = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < DESCS_AREAS; i++)
> +		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
> +
> +	init_sched(cdd);
> +	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cppi41_pm_ops, cppi41_suspend, cppi41_resume);
Here is the macro in pm.h

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend = suspend_fn, \
        .resume = resume_fn, \
        .freeze = suspend_fn, \
        .thaw = resume_fn, \
        .poweroff = suspend_fn, \
        .restore = resume_fn,
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif

/*
 * Use this if you want to use the same suspend and resume callbacks for suspend
 * to RAM and hibernation.
 */
#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
const struct dev_pm_ops name = { \
        SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \

Now since you are using the macro there should be no need to wrap ifdef around
your code, the macro will take care of it. 

~Vinod

> +
>  static struct platform_driver cpp41_dma_driver = {
>  	.probe  = cppi41_dma_probe,
>  	.remove = cppi41_dma_remove,
>  	.driver = {
>  		.name = "cppi41-dma-engine",
>  		.owner = THIS_MODULE,
> +		.pm = &cppi41_pm_ops,
>  		.of_match_table = of_match_ptr(cppi41_dma_ids),
>  	},
>  };
> -- 
> 1.8.3.1
> 

-- 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
