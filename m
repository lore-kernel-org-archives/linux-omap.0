From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: speedup twl4030 irq response time and decrease
 irq disable time
Date: Mon, 27 Sep 2010 21:24:18 -0700
Message-ID: <20100928042416.GA9359@opensource.wolfsonmicro.com>
References: <1285120171-3030-1-git-send-email-tom.leiming@gmail.com>
 <20100927154809.GI2560@sortiz-mobl>
 <AANLkTikjGD32hPhwPhZfETZX9H+--_SduTtqgyuqY_72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikjGD32hPhwPhZfETZX9H+--_SduTtqgyuqY_72@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 28, 2010 at 08:25:24AM +0800, Ming Lei wrote:
> 2010/9/27 Samuel Ortiz <sameo@linux.intel.com>:

> > Wouldn't converting your twl4030_irq_thread() to the threaded IRQ framework
> > fix that problem ?

> IRQ_DISABLED flag is set by disable_irq_nosync called from PIH handler,
> then thread function can't be executed in irq thread function, so we can't
> convert this to threaded IRQ framework simply.

Have you raised this issue with the genirq guys?  This sounds like
something that the core infrastructure should be able to cope with.
