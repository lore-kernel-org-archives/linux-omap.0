From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 3/3] twl4030: enable wakeup on twl4030 IRQ.
Date: Wed, 9 May 2012 18:03:29 +0200
Message-ID: <20120509160329.GP1794@sortiz-mobl>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.66013.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25473 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758067Ab2EIPyC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 11:54:02 -0400
Content-Disposition: inline
In-Reply-To: <20120425030524.7832.66013.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Neil,

On Wed, Apr 25, 2012 at 01:05:24PM +1000, NeilBrown wrote:
> Most of the interrupts that come through this line should trigger
> wakeups:
>   power button
>   RTC alarm
>   power available
>   usb plug/unplug
> 
> so mark the interrupt as a wakeup interrupt.
> This is particularly important for when the interrupt arrives during
> the late suspend phase.  Without this setting it will be ignored.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
>  drivers/mfd/twl4030-irq.c |    1 +
>  1 file changed, 1 insertion(+)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
