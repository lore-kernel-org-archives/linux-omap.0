From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: TWL4030: Give a name to twl4030 irq_chip
Date: Wed, 14 May 2008 15:25:15 -0700
Message-ID: <20080514222510.GA8928@atomide.com>
References: <1210688444-17768-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:58063 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYENWZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:25:15 -0400
Content-Disposition: inline
In-Reply-To: <1210688444-17768-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080513 07:24]:
> Small cleanup to beautify /proc/interrupts.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
> index b8ee8e1..8822653 100644
> --- a/drivers/i2c/chips/twl4030-core.c
> +++ b/drivers/i2c/chips/twl4030-core.c
> @@ -238,6 +238,7 @@ static void twl4030_i2c_enableint(unsigned int irq) {}
>  
>  /* information for processing in the Work Item */
>  static struct irq_chip twl4030_irq_chip = {
> +	.name	= "twl4030",
>  	.ack	= twl4030_i2c_ackirq,
>  	.mask	= twl4030_i2c_disableint,
>  	.unmask	= twl4030_i2c_enableint,

Pushing today.

Tony
