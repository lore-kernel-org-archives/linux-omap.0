From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 04/14] ARM: OMAP5: Add minimal support for OMAP5430
 SOC
Date: Thu, 5 Jul 2012 09:02:22 -0700
Message-ID: <20120705160222.GH1122@atomide.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
 <1341490136-25901-7-git-send-email-santosh.shilimkar@ti.com>
 <20120705143333.GE1122@atomide.com>
 <CAMQu2gwD9wXgs0b1OnSmimgXbpG4YU3i2uZs=kGr08kA3AOJZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19418 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab2GEQC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 12:02:26 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gwD9wXgs0b1OnSmimgXbpG4YU3i2uZs=kGr08kA3AOJZw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120705 07:41]:
> On Thu, Jul 5, 2012 at 8:03 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [120705 05:13]:
> >> --- a/arch/arm/plat-omap/Makefile
> >> +++ b/arch/arm/plat-omap/Makefile
> >> @@ -10,9 +10,7 @@ obj-n :=
> >>  obj-  :=
> >>
> >>  # omap_device support (OMAP2+ only at the moment)
> >> -obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> >> -obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> >> -obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> >> +obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
> >>
> >>  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
> >>  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
> >
> > FYI, this we already have as commit b4cb410d in devel-am33xx-part2.
> > I can merge first few patches in devel-am33xx-part2 branch into
> > cleanup-part2 so this part can be just left out.
> >
> Ok. Once you update the branch this can be easily dropped.

Updated cleanup-part2 at commit ecc46cfd now has it.

Regards,

Tony
