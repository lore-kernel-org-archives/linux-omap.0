From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 12/13] gpio/omap: fix incorrect context restore logic
 in omap_gpio_runtime_resume
Date: Wed, 07 Mar 2012 13:07:49 +0100
Message-ID: <4F574F95.7090801@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com> <1331118963-26364-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50950 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754931Ab2CGMHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:07:54 -0500
Received: by yenl12 with SMTP id l12so3518818yen.33
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:07:53 -0800 (PST)
In-Reply-To: <1331118963-26364-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
> In omap_gpio_runtime_resume() the context restore should be independent
> of bank->enabled_non_wakeup_gpios. This was preventing context restore
> of GPIO lines which are not wakeup enabled.
> 
> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 2e8e476..ccfbae0 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1227,7 +1227,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
>  	__raw_writel(bank->context.risingdetect,
>  		     bank->base + bank->regs->risingdetect);
>  
> -	if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabled) {
> +	if (!bank->workaround_enabled) {
This doesn't seem to be right.
Don't you want to avoid GPIO restore for banks which are in
always on domain. Infact the purpose of "enabled_non_wakeup_gpios"
is exactly that ? Isn't it.

What am I missing ?

Regards
Santosh
