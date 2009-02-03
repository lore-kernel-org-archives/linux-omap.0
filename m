From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()
	function
Date: Tue, 3 Feb 2009 12:42:36 -0800
Message-ID: <20090203204235.GH7215@atomide.com>
References: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49791 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZBCUml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 15:42:41 -0500
Content-Disposition: inline
In-Reply-To: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?utf-8?B?6rmA6rec7JuQ?= <q1.kim@samsung.com>

* Kim Kyuwon <chammoru@gmail.com> [090131 00:22]:
> USB should be suspended with interrupt disabled[1]. If USB is suspended with
> interrupt enabled and connected to host PC, a kernel panic would occur When
> it wakes up. Because, after the arch_suspend_enable_irqs() function is called
> in the suspend_enter() function, USB Interrupt handler is called, even though
> USB controller is still not resumed! All devices are resumed after the
> device_resume() is called.

Please send the usb patches to the linux-usb@vger.kernel.org list
with linux-omap list Cc'd.

Regards,

Tony


> [1] /Documentation/power/devices.txt: 412 line
> 
> Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
> ---
>  drivers/usb/musb/musb_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2cc34fa..0dfe15e 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2151,6 +2151,8 @@ static int musb_suspend(struct platform_device
> *pdev, pm_message_t message)
> 
>  	spin_lock_irqsave(&musb->lock, flags);
> 
> +	disable_irq(musb->nIrq);
> +
>  	if (is_peripheral_active(musb)) {
>  		/* FIXME force disconnect unless we know USB will wake
>  		 * the system up quickly enough to respond ...
> @@ -2184,6 +2186,8 @@ static int musb_resume(struct platform_device *pdev)
>  	else
>  		clk_enable(musb->clock);
> 
> +	enable_irq(musb->nIrq);
> +
>  	/* for static cmos like DaVinci, register values were preserved
>  	 * unless for some reason the whole soc powered down and we're
>  	 * not treating that as a whole-system restart (e.g. swsusp)
> -- 
> Kim Kyuwon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
