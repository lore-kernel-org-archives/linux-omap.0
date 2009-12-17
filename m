From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mfd: twl4030-irq: irq_desc->lock converted to
 raw_spinlock_t
Date: Thu, 17 Dec 2009 01:04:20 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912170100440.2755@localhost.localdomain>
References: <1260987530-20221-1-git-send-email-felipe.balbi@nokia.com> <20091216182022.GA20302@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763423AbZLQAEp@vger.kernel.org>
In-Reply-To: <20091216182022.GA20302@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Dec 2009, Felipe Balbi wrote:
> commit 239007b8440abff689632f50cdf0f2b9e895b534 converted
> the spinlock_t to raw_spinlock_t. Unfortunately twl4030-irq
> was left aside on the conversion.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> 
> I'm not sure this is the expected fix since twl4030-irq handler
> should be running in thread context. Currently mask/unmask/set_type
> are deferred to a workqueue. Thomas, should this be done ? How
> do you expect irq chips on slow busses to implement mask/unmask/set_type ?

That does not matter whether this runs in thread context or not. We
changed the type of the lock from spinlock to raw_spinlock. So we need
to use the corresponding raw_spin_* functions for it independent of
the context. Your patch is completely correct.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
 
>  drivers/mfd/twl4030-irq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 20d29ba..9df9a5a 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -568,12 +568,12 @@ static void twl4030_sih_do_edge(struct work_struct
> *work)
>   		bytes[byte] &= ~(0x03 << off);
>  -		spin_lock_irq(&d->lock);
> +		raw_spin_lock_irq(&d->lock);
>  		if (d->status & IRQ_TYPE_EDGE_RISING)
>  			bytes[byte] |= BIT(off + 1);
>  		if (d->status & IRQ_TYPE_EDGE_FALLING)
>  			bytes[byte] |= BIT(off + 0);
> -		spin_unlock_irq(&d->lock);
> +		raw_spin_unlock_irq(&d->lock);
>   		edge_change &= ~BIT(i);
>  	}
> -- 
> 1.6.6.rc0
> 
> 
> -- 
> balbi
> 
