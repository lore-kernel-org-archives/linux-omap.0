From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] DSPGW: Fix build error for device_create()
Date: Tue, 12 Aug 2008 14:05:31 +0300
Message-ID: <20080812110530.GD6705@atomide.com>
References: <1218525113-25414-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55143 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYHLLDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 07:03:19 -0400
Content-Disposition: inline
In-Reply-To: <1218525113-25414-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080812 10:14]:
> Ideally, the contents mamagement should be handled by drv_data instead
> of homebrewed array.

Pushing today.

Tony

> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/dspgateway/dsp_ctl_core.c |    5 ++---
>  drivers/dsp/dspgateway/task.c         |    2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dsp/dspgateway/dsp_ctl_core.c b/drivers/dsp/dspgateway/dsp_ctl_core.c
> index 3c13572..25954bb 100644
> --- a/drivers/dsp/dspgateway/dsp_ctl_core.c
> +++ b/drivers/dsp/dspgateway/dsp_ctl_core.c
> @@ -110,9 +110,8 @@ int __init dsp_ctl_core_init(void)
>  	dsp_ctl_class = class_create(THIS_MODULE, "dspctl");
>  	for (i = 0; i < ARRAY_SIZE(dev_list); i++) {
>  		device_create(dsp_ctl_class, NULL,
> -				    MKDEV(OMAP_DSP_CTL_MAJOR,
> -					  dev_list[i].minor),
> -				    dev_list[i].devname);
> +			      MKDEV(OMAP_DSP_CTL_MAJOR, dev_list[i].minor),
> +			      NULL, dev_list[i].devname);
>  	}
>  
>  	return 0;
> diff --git a/drivers/dsp/dspgateway/task.c b/drivers/dsp/dspgateway/task.c
> index 4d7dcdd..ab18934 100644
> --- a/drivers/dsp/dspgateway/task.c
> +++ b/drivers/dsp/dspgateway/task.c
> @@ -1762,7 +1762,7 @@ static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
>  		goto fail_create_proclist;
>  
>  	task_dev = device_create(dsp_task_class, NULL,
> -				 MKDEV(OMAP_DSP_TASK_MAJOR, minor),
> +				 MKDEV(OMAP_DSP_TASK_MAJOR, minor), NULL,
>  				 "dsptask%d", (int)minor);
>  
>  	if (unlikely(IS_ERR(task_dev))) {
> -- 
> 1.5.5.1.357.g1af8b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
