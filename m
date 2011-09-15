From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
Date: Thu, 15 Sep 2011 13:37:38 -0700
Message-ID: <20110915203738.GA23208@google.com>
References: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:43165 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934787Ab1IOUhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 16:37:45 -0400
Content-Disposition: inline
In-Reply-To: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Sep 06, 2011 at 09:29:30PM +0530, Santosh Shilimkar wrote:
> TWL6030 devices have an interrupt line which is connected to
> application processor like OMAP. These devices support multiple features
> such as MMC card detect, USB cable detect, RTC interrupt, etc. that must
> wake up the application processor.
> 
> With this change, TWL6030 client drivers can make use of
> irq_wake() if the wakeup is desirable on it's irq events.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl6030-irq.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index eb3b5f8..4477134 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -187,6 +187,13 @@ static inline void activate_irq(int irq)
>  #endif
>  }
>  
> +int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	int twl_irq = (int)irq_get_chip_data(d->irq);
> +
> +	return irq_set_irq_wake(twl_irq, on);

Note that when running with this previously, LOCKDEP warnings
were seen.  LOCKDEP explicitly sets all irq_desc locks as a single
lock-class, causing "possible recursive locking detected" when the TWL
RTC (or other) driver calls through enable_irq_wake to
twl6030_irq_set_wake, which recursively calls irq_set_irq_wake.
Although the irq_desc and lock are different, LOCKDEP treats these as
equivalent, presumably due to problems that can be incurred when
locking more than one irq_desc.

Currently we're running with twl6030_irq_set_wake keeping a count of
sub-module wakeirqs, and setting the wakeup status for the twl_irq
enabled or disabled as needed at suspend time.  Can send a patch if
wanted.

> +}
> +
>  /*----------------------------------------------------------------------*/
>  
>  static unsigned twl6030_irq_next;
> @@ -318,10 +325,12 @@ int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
>  	twl6030_irq_chip = dummy_irq_chip;
>  	twl6030_irq_chip.name = "twl6030";
>  	twl6030_irq_chip.irq_set_type = NULL;
> +	twl6030_irq_chip.irq_set_wake = twl6030_irq_set_wake;
>  
>  	for (i = irq_base; i < irq_end; i++) {
>  		irq_set_chip_and_handler(i, &twl6030_irq_chip,
>  					 handle_simple_irq);
> +		irq_set_chip_data(i, (void *)irq_num);
>  		activate_irq(i);
>  	}
>  
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
