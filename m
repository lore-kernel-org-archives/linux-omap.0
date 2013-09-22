From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 5/5] dma: cppi41: add support for suspend and resume
Date: Sun, 22 Sep 2013 18:25:29 +0400
Message-ID: <523EFDD9.4060906@cogentembedded.com>
References: <1379851068-18675-1-git-send-email-zonque@gmail.com> <1379851068-18675-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:51454 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab3IVOZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Sep 2013 10:25:34 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so1996271lbd.30
        for <linux-omap@vger.kernel.org>; Sun, 22 Sep 2013 07:25:33 -0700 (PDT)
In-Reply-To: <1379851068-18675-6-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

Hello.

On 22-09-2013 15:57, Daniel Mack wrote:

> This patch adds support for suspend/resume functionality to the cppi41
> DMA driver. The steps neccessary to make the system resume properly were

    Necessary.

> figured out by hefty trial-and-error. The code as it stands now is the
> minimum that has to be done to put the musb host system on an AM33xx
> system into an operable state after resume.

> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>   drivers/dma/cppi41.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 3347321..59dfa8e 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -1040,12 +1040,45 @@ static int cppi41_dma_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_PM_SLEEP
[...]
> +static SIMPLE_DEV_PM_OPS(cppi41_pm_ops, cppi41_suspend, cppi41_resume);
> +
> +#define DEV_PM_OPS (&cppi41_pm_ops)
> +#else
> +#define DEV_PM_OPS NULL
> +#endif

    You don't need that with SIMPLE_DEV_PM_OPS(), just get it out of #ifdef.

WBR, Sergei

