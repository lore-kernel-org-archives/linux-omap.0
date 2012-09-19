From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/4] mfd: introduce retu-mfd driver
Date: Wed, 19 Sep 2012 23:09:53 +0300
Message-ID: <20120919200953.GB2063@blackmetal.musicnaut.iki.fi>
References: <1346703805-31598-1-git-send-email-aaro.koskinen@iki.fi>
 <1346703805-31598-3-git-send-email-aaro.koskinen@iki.fi>
 <20120919160230.GK28670@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120919160230.GK28670@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 19, 2012 at 06:02:30PM +0200, Samuel Ortiz wrote:
> On Mon, Sep 03, 2012 at 11:23:23PM +0300, Aaro Koskinen wrote:
> > Retu is a multi-function device found on Nokia Internet Tablets
> > implementing at least watchdog, RTC, headset detection and power button
> > functionality.
> > 
> > This patch implements minimum functionality providing register access,
> > IRQ handling and power off functions.
> > 
> > Cc: sameo@linux.intel.com
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/mfd/Kconfig      |    8 +
> >  drivers/mfd/Makefile     |    1 +
> >  drivers/mfd/retu-mfd.c   |  347 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/retu.h |   22 +++
> >  4 files changed, 378 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/mfd/retu-mfd.c
> >  create mode 100644 include/linux/mfd/retu.h
> Now with the IRQ chip code, using the regmap APIs would be even more
> benefitial.

Thanks for feedback, I'll look into this.

A.
