From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/11] I2C: OMAP: Handle error check for pm runtime
Date: Tue, 26 Jun 2012 20:43:32 -0500
Message-ID: <874npxv8aj.fsf@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
	<1338288983-15026-8-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:53746 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753821Ab2F0Bn0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 21:43:26 -0400
Received: by yhfq46 with SMTP id q46so39749yhf.35
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 18:43:25 -0700 (PDT)
In-Reply-To: <1338288983-15026-8-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 29 May 2012 16:26:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> If PM runtime get_sync fails return with the error
> so that no further reads/writes goes through the interface.
> This will avoid possible abort. Add a error message in case
> of failure with the cause of the failure.
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

This patch introduced a regression where the runtime PM usecount will
never reach zero and so CORE retention is prevented after any xfer
failures...

> ---
> -v10 Use IS_ERR_VALUE
> -v9 Fix the error handling
>
>  drivers/i2c/busses/i2c-omap.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 44e8cfa..c39b72f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -585,7 +585,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	int i;
>  	int r;
>  
> -	pm_runtime_get_sync(dev->dev);
> +	r = pm_runtime_get_sync(dev->dev);<
> +	if (IS_ERR_VALUE(r))
> +		return r;

This return should be 'goto out' so the runtime PM usecount is
decremented by the 'put'.  Otherwise, after failure, the usecount
remains non-zero, so the device is considered 'active' and keeps the
containing power domain active.

I found this on a 3730/OveroSTORM where the suspend/resume of MMC fails
because I2C is already suspended.  After the suspend though, the CORE
powerdomain never again hits retention, and I tracked it down to this.

I'll send a separate patch to fix this shortly.

Kevin 
