From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 10:51:47 -0700
Message-ID: <20150514175147.GN15563@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
 <20150514020634.GB20006@saruman.tx.rr.com>
 <20150514155945.GL15563@atomide.com>
 <20150514160902.GF24269@saruman.tx.rr.com>
 <20150514162822.GM15563@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514162822.GM15563@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150514 09:30]:
> * Felipe Balbi <balbi@ti.com> [150514 09:12]:
>  
> > > int dev_pm_request_wake_irq_managed(struct device *dev, int irq);
> > 
> > I don't get this. Would this request with devm_ while the former
> > wouldn't use devm_ ?
> 
> Typo :) Both can be devm no problem.
...

> > > The life cycle of the request and free of the wake irq is not the
> > > same as the life cycle of the device driver. For example, serial
> > > drivers can request interrupts on startup and free them on shutdown.
> > 
> > fair enough, but then we start to consider the benefits of using
> > devm_ IRQ :-)
> 
> Hmm probably the extra checks do not hurt there either.

We should keep the PM related functions called dev_pm_*, using
devm_pm_* just gets hard to pronounce.. So yeah I too am thinking
just not using devm here at all as the consumer drivers are not
allocating anything.

Regards,

Tony
