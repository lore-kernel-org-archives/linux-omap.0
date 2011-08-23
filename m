From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 13/22] gpio/omap: cleanup omap_gpio_mod_init function
Date: Tue, 23 Aug 2011 18:56:12 +0530
Message-ID: <4E53AA74.5090906@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-14-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38150 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890Ab1HWN0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 09:26:19 -0400
Received: by mail-yi0-f50.google.com with SMTP id 18so97301yib.23
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 06:26:18 -0700 (PDT)
In-Reply-To: <1312455893-14922-14-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. This function now has common initialization code for
> all OMAP versions. Initialization specific to OMAP16xx has been moved within
> omap16xx_gpio_init().
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap1/gpio16xx.c |   34 ++++++++++++++++++-
>   drivers/gpio/gpio-omap.c       |   71 +++++++++++-----------------------------
>   2 files changed, 52 insertions(+), 53 deletions(-)
>

[...]

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 21cb0d4..f6855e5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c

[...]

> @@ -1074,6 +1036,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>   	pm_runtime_enable(bank->dev);
>   	pm_runtime_get_sync(bank->dev);
>
> +	if (bank_is_mpuio(bank)) {
> +		if (bank->regs->wkup_status)
> +			mpuio_init(bank);
The above check looks strange. What are you trying here ?

Regards
Santosh
