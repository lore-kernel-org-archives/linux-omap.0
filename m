From: Tony Lindgren <tony@atomide.com>
Subject: Re: mfd: twl4030-irq: irq_desc->lock converted to raw_spinlock_t
Date: Mon, 28 Dec 2009 12:01:45 -0800
Message-ID: <20091228200145.GN3512@atomide.com>
References: <1261998172-29760-1-git-send-email-felipe.balbi@nokia.com>
 <1261998172-29760-5-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751515AbZL1UBt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1261998172-29760-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [091228 03:04]:
> commit 239007b8440abff689632f50cdf0f2b9e895b534 converted
> the spinlock_t to raw_spinlock_t. Unfortunately twl4030-irq
> was left aside on the conversion.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> ---
> 
> resending because it wasn't applied before

This should go via Samuel as it's MFD related.

Acked-by: Tony Lindgren <tony@atomide.com>

 
> 
>  drivers/mfd/twl4030-irq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 20d29ba..9df9a5a 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -568,12 +568,12 @@ static void twl4030_sih_do_edge(struct work_struct *work)
>  
>  		bytes[byte] &= ~(0x03 << off);
>  
> -		spin_lock_irq(&d->lock);
> +		raw_spin_lock_irq(&d->lock);
>  		if (d->status & IRQ_TYPE_EDGE_RISING)
>  			bytes[byte] |= BIT(off + 1);
>  		if (d->status & IRQ_TYPE_EDGE_FALLING)
>  			bytes[byte] |= BIT(off + 0);
> -		spin_unlock_irq(&d->lock);
> +		raw_spin_unlock_irq(&d->lock);
>  
>  		edge_change &= ~BIT(i);
>  	}
