From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Mon, 3 Jan 2011 17:40:02 -0800
Message-ID: <20110104014002.GV7771@atomide.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16274 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1ADBkG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 20:40:06 -0500
Content-Disposition: inline
In-Reply-To: <1294040988-21191-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110102 23:49]:
> @@ -53,23 +54,23 @@
>  struct retu {
>  	/* Device lock */
>  	spinlock_t		lock;
> -	struct tasklet_struct	tasklet;
> +	struct mutex		irq_lock;
>  	struct device		*dev;
>  
> +	int			irq_base;
> +	int			nirqs;
>  	int			irq;

This one oopses, looks like irq_base is not initialized?

Regards,

Tony
