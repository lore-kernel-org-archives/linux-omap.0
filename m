From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/11] mfd: twl-core: Fix idle mode signaling for omaps
 when booted with device tree
Date: Thu, 17 Apr 2014 08:37:23 -0700
Message-ID: <20140417153722.GA23385@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-11-git-send-email-tony@atomide.com>
 <20140417080051.GE28725@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47049 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751163AbaDQPh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 11:37:29 -0400
Content-Disposition: inline
In-Reply-To: <20140417080051.GE28725@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

* Lee Jones <lee.jones@linaro.org> [140417 01:01]:
> > I noticed a regression where the omap sys_clkreq signal will never
> > trigger for omap3 when booted with device tree while it triggers
> > when booted in legacy mode. This means voltage scaling does not
> > do anything when booted with device tree.
> >=20
> > Turns out the reason is we fail to initialize the SmartReflex
> > enable bit in twl4030 with the following error:
> >=20
> > twl: not initialized
> >=20
> > And that happens because we are wrongly tinkering with the twl4030
> > registers in arch/arm/mach-omap2/omap_twl.c before the driver is
> > initialized. Looking at the the SmartReflex bit enable code in
> > omap_twl.c, we need to always set it.
> >=20
> > So let's fix the issue by always enabling the twl4030 SmartReflex
> > bit in the drivers/mfd/twl-core.c probe, and drop the related
> > code in omap_twl.c.
> >=20
> > Note that we still have some twl4030 tinkering left in omap_twl.c
> > for the twl6030 case, but that's a different patch.
> >=20
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/omap_twl.c | 60 ------------------------------=
------------
> >  drivers/mfd/twl-core.c         | 15 +++++++++++
> >  2 files changed, 15 insertions(+), 60 deletions(-)
>=20
> Patch looks okay to me, and removes lots of code which is nice to
> see. How do you want to handle this patch? How about if I set up an
> MFD-OMAP immutable branch for us to use leading up to the v3.16 merge
> window?

Yes, that would be good thanks. Can you please set up the immutable
branch against v3.14 for this, that should merge just fine against
v3.15-rc AFAIK.

I have also DT support coming up for drivers/mfd/twl4030-power.c
generic configuration that can then go into the same branch when=20
ready.

Regards,

Tony
=20
> Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
