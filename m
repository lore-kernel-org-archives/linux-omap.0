From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/4] drivers: input: Fix OMAP_GPIO_IRQ with
 gpio_to_irq() in ams_delta_serio_exit()
Date: Tue, 20 Mar 2012 09:52:46 -0700
Message-ID: <20120320165246.GH9859@atomide.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <1332158817-26311-4-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab2CTQwu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 12:52:50 -0400
Content-Disposition: inline
In-Reply-To: <1332158817-26311-4-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hi Dmitry,

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120319 05:09]:
> Even though ams-delta-serio input driver uses gpio_to_irq() in all
> relevent places to get irq number, the ams_delta_serio_exit() still
> uses OMAP_GPIO_IRQ macro. Fix this.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Care to ack this one? I'd like to apply all four as fixes
at the end of the merge window so we can drop the old and
now broken OMAP_GPIO_IRQ macro.

Regards,

Tony

> ---
>  drivers/input/serio/ams_delta_serio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index d4d08bd..dbe1ae8 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -170,7 +170,7 @@ module_init(ams_delta_serio_init);
>  static void __exit ams_delta_serio_exit(void)
>  {
>  	serio_unregister_port(ams_delta_serio);
> -	free_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
> +	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
>  	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
>  }
> -- 
> 1.7.0.4
> 
