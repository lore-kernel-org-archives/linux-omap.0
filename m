From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
Date: Mon, 26 Sep 2011 10:50:07 +0200
Message-ID: <20110926085007.GB32263@sortiz-mobl>
References: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com>
 <20110915203738.GA23208@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25708 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1IZIrR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 04:47:17 -0400
Content-Disposition: inline
In-Reply-To: <20110915203738.GA23208@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Hi Todd,

On Thu, Sep 15, 2011 at 01:37:38PM -0700, Todd Poynor wrote:
> On Tue, Sep 06, 2011 at 09:29:30PM +0530, Santosh Shilimkar wrote:
> > TWL6030 devices have an interrupt line which is connected to
> > application processor like OMAP. These devices support multiple features
> > such as MMC card detect, USB cable detect, RTC interrupt, etc. that must
> > wake up the application processor.
> > 
> > With this change, TWL6030 client drivers can make use of
> > irq_wake() if the wakeup is desirable on it's irq events.
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > cc: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >  drivers/mfd/twl6030-irq.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> > index eb3b5f8..4477134 100644
> > --- a/drivers/mfd/twl6030-irq.c
> > +++ b/drivers/mfd/twl6030-irq.c
> > @@ -187,6 +187,13 @@ static inline void activate_irq(int irq)
> >  #endif
> >  }
> >  
> > +int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
> > +{
> > +	int twl_irq = (int)irq_get_chip_data(d->irq);
> > +
> > +	return irq_set_irq_wake(twl_irq, on);
> 
> Note that when running with this previously, LOCKDEP warnings
> were seen.  LOCKDEP explicitly sets all irq_desc locks as a single
> lock-class, causing "possible recursive locking detected" when the TWL
> RTC (or other) driver calls through enable_irq_wake to
> twl6030_irq_set_wake, which recursively calls irq_set_irq_wake.
> Although the irq_desc and lock are different, LOCKDEP treats these as
> equivalent, presumably due to problems that can be incurred when
> locking more than one irq_desc.
> 
> Currently we're running with twl6030_irq_set_wake keeping a count of
> sub-module wakeirqs, and setting the wakeup status for the twl_irq
> enabled or disabled as needed at suspend time.  Can send a patch if
> wanted.
Please do. I'm currently considering removing Santosh's patch without this
LOCKDEP warning fix.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
