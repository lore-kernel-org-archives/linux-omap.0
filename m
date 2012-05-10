From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V2] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Thu, 10 May 2012 11:05:36 -0700
Message-ID: <20120510180535.GG21851@atomide.com>
References: <1336562667-6741-1-git-send-email-hvaibhav@ti.com>
 <20120509185435.GU5088@atomide.com>
 <20120510180159.GF21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63060 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759943Ab2EJSFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:05:39 -0400
Content-Disposition: inline
In-Reply-To: <20120510180159.GF21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Tony Lindgren <tony@atomide.com> [120510 11:06]:
> * Tony Lindgren <tony@atomide.com> [120509 11:58]:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120509 04:28]:
> > > Initially, we decided to make am33xx family of device to fall
> > > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > > Cortex-A8 core. But while adding complete baseport support
> > > (like, clock, power and hwmod) support, it is observed that,
> > > we are creating more and more problems by treating am33xx device
> > > as omap3 family, as nothing matches between them
> > > (except cortex-A8 mpu).
> > 
> > Thanks applying into devel-soc after updating for soc_is change
> > and fixing typo in the description that stil said OMAPAM. Updated
> > patch below.
> 
> Turns out we still need to add defined(CONFIG_SOC_AM33XX) around
> __omap2_set_globals() to keep compile working when omap4 + am33xx
> are selected without omap2 or 3. Also removed the "default y"
> for am33xx as that's where we're heading to anyways.
> 
> Updated patch below.

Argh, now it breaks with:

arch/arm/mach-omap2/built-in.o: In function `omap2_set_globals_am33xx':
twl-common.c:(.init.text+0x1dd8): undefined reference to `omap2_set_globals_sdrc'

There are clearly some dependencies to the clean up patches being
discussed.. So I'll drop this for now until the clean up is sorted
out.

Regards,

Tony
