From: Bin Liu <b-liu@ti.com>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu, 8 Mar 2018 10:46:13 -0600
Message-ID: <20180308164613.GH14921@uda0271908>
References: <20180308093121.11943-1-merlijn@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308093121.11943-1-merlijn@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 08, 2018 at 10:31:21AM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload. The fix is similar to the
> one in this commit: 0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 (USB: musb:
> fix late external abort on suspend), which only fixes the issue for
> musb_suspend.
> 
> musb_remove function now also flushes any work and also calls
> musb_platform_exit before disabling runtime pm.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
> 
> If I understand commit 0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 correctly,
> this patch should also be backported to 4.9 (and newer kernels).
> 
> I have verified that this works on the Nokia N900, RX-51. The problem did not
> occur on the Motorola Droid 4, but I have yet to test if this patch causes
> issues there.
> 
>  drivers/usb/musb/musb_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index e2e95071328a..4fb0f345c04e 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2472,13 +2472,19 @@ static int musb_remove(struct platform_device *pdev)
>  	musb_platform_disable(musb);
>  	spin_lock_irqsave(&musb->lock, flags);
>  	musb_disable_interrupts(musb);
> +
> +	musb->flush_irq_work = true;
> +	while (flush_delayed_work(&musb->irq_work))
> +		;
> +	musb->flush_irq_work = false;

No need to flush, the work is already cancelled at this point.

> +
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> +	musb_platform_exit(musb);

This can be move down to out side of holding the spinlock,

>  	spin_unlock_irqrestore(&musb->lock, flags);

to here.

>  
>  	pm_runtime_dont_use_autosuspend(musb->controller);
>  	pm_runtime_put_sync(musb->controller);
>  	pm_runtime_disable(musb->controller);
> -	musb_platform_exit(musb);
>  	musb_phy_callback = NULL;
>  	if (musb->dma_controller)
>  		musb_dma_controller_destroy(musb->dma_controller);
> -- 

Thanks for the patch.

Regards,
-Bin.
