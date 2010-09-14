From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
Date: Tue, 14 Sep 2010 13:27:43 -0700
Message-ID: <20100914202743.GK8647@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com>
 <20100914190314.GH8647@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50598 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0INU15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 16:27:57 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100914 12:09]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Wednesday, September 15, 2010 12:33 AM
> > To: Russell King - ARM Linux
> > Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> > bryan.wu@canonical.com
> > Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
> > 
> > With the recent changes to core ARM kernel code, we can now
> > boot SMP kernel on UP systems. Update omap3_defconfig to
> > enable SMP. This allows us to remove omap_4430sdp_defconfig.
> >
> Not yet.
> We still have some issues around Ethernet, bridge/syslink,
> sensors but hopefully we should be able to fix those.
> Will have a closer look at this and see if these can be
> easily fixed.

Sounds like you're having these problems anyways and they
are not related to the defconfigs?

Considering Linus' earlier comments on the defconfigs, I don't
see any reasonds not to merge this patch. If TI wants to fix up
some other things, there's still about two weeks before -rc6.

> > In addition to enabling SMP, we also need to disable some
> > options to make the system boot:
> > 
> > - For some reason LOCK_STAT causes tons of
> >   WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
> >   so disable it for now.
> > 
> > - MUSB init fails for multi-omap, disable it for now.
> > 
> > - LOCAL_TIMERS hangs on omap4, disable it for now.
>
> This is expected on omap4 ES1.0 and hence not enabled
> in the omap_4430sdp_defconfig.

Maybe add a check for ES1.0 there to the init then?

Regards,

Tony
