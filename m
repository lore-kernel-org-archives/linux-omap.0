From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Tue, 8 May 2012 14:58:16 -0700
Message-ID: <20120508215816.GJ5088@atomide.com>
References: <1336490630-7272-1-git-send-email-hvaibhav@ti.com>
 <87ipg6l4jp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19502 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab2EHV6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:58:20 -0400
Content-Disposition: inline
In-Reply-To: <87ipg6l4jp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

* Kevin Hilman <khilman@ti.com> [120508 15:00]:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > Initially, we decided to make am33xx family of device to fall
> > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > Cortex-A8 core. But while adding complete baseport support
> > (like, clock, power and hwmod) support, it is observed that,
> > we are creating more and more problems by treating am33xx device
> > as omap3 family, as nothing matches between them
> > (except cortex-A8 mpu).
> >
> > So,  after long discussion we have came to the conclusion that,
> > we should not consider am33xx device as omap3 family, instead
> > create separate class (SOC_OMAPAM33XX) under OMAP2PLUS.
> > This means, for am33xx device, cpu_is_omap34xx() will return false,
> > and only cpu_is_am33xx() will be true.
> 
> Not directly related to this patch, but does anyone have any objection
> to dropping the OMAP from the SOC_ names for AM33xx and TI81XX?
> 
> I'll post a series shortly to do so.

No objection.

Tony
