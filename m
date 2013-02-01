From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Get rid of custom OMAP_32K_TIMER_HZ
Date: Fri, 1 Feb 2013 14:52:02 -0800
Message-ID: <20130201225202.GI22517@atomide.com>
References: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
 <1524396.4DaQLsSWOZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64123 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755035Ab3BAWwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:52:08 -0500
Content-Disposition: inline
In-Reply-To: <1524396.4DaQLsSWOZ@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, John Stultz <john.stultz@linaro.org>, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [130131 07:41]:
> On Thursday 31 January 2013 21:02:00 Santosh Shilimkar wrote:
> > The timekeeping doesn't depend on HZ value in presence of fine grained
> > clocksource and hence there should not be any time drift because of HZ
> > value which was chosen to be divisor of 32768.
> > 
> > OMAP has been using HZ = 128 value to avoid any time drift issues
> > because of 32768 HZ clock. But with various measurements performed
> > with HZ = 100, no time drift is observed and it also proves the
> > point about HZ not having impact on time keeping on OMAP.
> > 
> > Very informative thread on this topic is here:
> >         https://lkml.org/lkml/2013/1/29/435
> > 
> > Special thanks to John Stulz, Arnd Bergmann and Russell King for their
> > valuable suggestions.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks so much for looking into this!

Great thanks for checking it Santosh! Applying into
omap-for-v3.9/soc.

Tony
