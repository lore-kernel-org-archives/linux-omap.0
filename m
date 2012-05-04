From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V6 1/3] ARM: OMAP1: FIX: check possible error condition
 in timer_init
Date: Fri, 4 May 2012 10:43:02 -0700
Message-ID: <20120504174301.GH5613@atomide.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
 <1335967014-11937-2-git-send-email-hvaibhav@ti.com>
 <87y5pafis6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46390 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab2EDRnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:43:08 -0400
Content-Disposition: inline
In-Reply-To: <87y5pafis6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

Hi,

* Kevin Hilman <khilman@ti.com> [120502 13:11]:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > OMAP1, omap_32k_timer_init() function always returns "true",
> > irrespective of whether error occurred while initializing 32k sync
> > counter as a kernel clocksource or not and execution will never
> > fallback to mpu_timer clocksource init code.
> >
> > This patch adds check for return value from function
> > omap_init_clocksource_32k(), and fallback to omap_mpu_timer_init()
> > in case of failure/error from omap_init_clocksource_32k().
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > ---
> > This is new patch addition compared to original series (<=V5).
> >
> > Also, note that, this patch is only compile tested, since
> > I do not have omap1 board with me to validate it.
> > Kevin, can you help me to validate it.
> 
> I boot tested on OMAP1 (5912/OSK) with 32k timer and MPU timer
> Kconfigs.  Works fine, but needs small change below for compile warnings.
> 
> Otherwise, looks good.

We need at least one tested-by on some 15xx platform for these changes.
Janusz, can you please give this series a try on your board too?

Regards,

Tony
