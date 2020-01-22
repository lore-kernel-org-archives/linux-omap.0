From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH RESEND 3/3] hwspinlock: omap: Use
 devm_hwspin_lock_register() to register hwlock controller
Date: Tue, 21 Jan 2020 16:15:15 -0800
Message-ID: <20200122001515.GA14744@builder>
References: <cover.1578453062.git.baolin.wang7@gmail.com>
 <315adcc5dfc6aa5c001448401dda4065e33deef2.1578453062.git.baolin.wang7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37803 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAVAPT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2020 19:15:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so2365421pfn.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jan 2020 16:15:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <315adcc5dfc6aa5c001448401dda4065e33deef2.1578453062.git.baolin.wang7@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Baolin Wang <baolin.wang7@gmail.com>
Cc: ohad@wizery.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue 07 Jan 19:14 PST 2020, Baolin Wang wrote:

> Use devm_hwspin_lock_register() to register the hwlock controller instead of
> unregistering the hwlock controller explicitly when removing the device.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/hwspinlock/omap_hwspinlock.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> index 3b05560..9e8a8c2 100644
> --- a/drivers/hwspinlock/omap_hwspinlock.c
> +++ b/drivers/hwspinlock/omap_hwspinlock.c
> @@ -131,8 +131,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
>  		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
>  
> -	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
> -						base_id, num_locks);
> +	ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
> +					base_id, num_locks);
>  	if (ret)
>  		goto runtime_err;
>  
> @@ -148,15 +148,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  
>  static int omap_hwspinlock_remove(struct platform_device *pdev)
>  {
> -	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret = hwspin_lock_unregister(bank);
> -	if (ret) {
> -		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
> -		return ret;
> -	}
> -

Relying on devm_hwspin_lock_register() to hwspin_lock_unregister() will
mean that pm_runtime_disable() will now be called before the spinlocks
are unregistered.

Regards,
Bjorn

>  	pm_runtime_disable(&pdev->dev);
>  
>  	return 0;
> -- 
> 1.7.9.5
> 
