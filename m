From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate
 class
Date: Thu, 5 Jul 2012 08:27:43 -0700
Message-ID: <20120705152743.GG1122@atomide.com>
References: <1341320447-18918-1-git-send-email-hvaibhav@ti.com>
 <1341320447-18918-2-git-send-email-hvaibhav@ti.com>
 <20120704072454.GO1122@atomide.com>
 <20120704081546.GR1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58176 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933177Ab2GEP1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 11:27:46 -0400
Content-Disposition: inline
In-Reply-To: <20120704081546.GR1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Tony Lindgren <tony@atomide.com> [120704 01:20]:
> * Tony Lindgren <tony@atomide.com> [120704 00:29]:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120703 06:12]:
> > > Initially, we decided to make am33xx family of device to fall
> > > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > > Cortex-A8 core. But while adding complete baseport support
> > > (like, clock, power and hwmod) support, it is observed that,
> > > we are creating more and more problems by treating am33xx device
> > > as omap3 family, as nothing matches between them
> > > (except cortex-A8 mpu).
> > > 
> > > So,  after long discussion we have came to the conclusion that,
> > > we should not consider am33xx device as omap3 family, instead
> > > create separate class (SOC_AM33XX) under OMAP2PLUS.
> > > This means, for am33xx device, cpu_is_omap34xx() will return false,
> > > and only cpu_is_am33xx() will be true.
> > 
> > Thanks applying both.
> 
> I believe all your patches are now applied. I've pushed them out
> into devel-am33xx-part2 branch. Can you please check and send
> additional patches as needed?

I ended up moving some patches into cleanup-part2 branch as omap5
patches also need those. So the new branch for am33xx is called
devel-am33xx-data at commit 79ab2664. The old devel-am33xx-part2
branch should be ignored now.

Regards,

Tony
