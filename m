From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 10/11] mfd: twl-core: Fix idle mode signaling for omaps
 when booted with device tree
Date: Thu, 17 Apr 2014 09:00:51 +0100
Message-ID: <20140417080051.GE28725@lee--X1>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-11-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:38515 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaDQIA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 04:00:56 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so96800wes.8
        for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2014 01:00:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397173639-29587-11-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

> I noticed a regression where the omap sys_clkreq signal will never
> trigger for omap3 when booted with device tree while it triggers
> when booted in legacy mode. This means voltage scaling does not
> do anything when booted with device tree.
>=20
> Turns out the reason is we fail to initialize the SmartReflex
> enable bit in twl4030 with the following error:
>=20
> twl: not initialized
>=20
> And that happens because we are wrongly tinkering with the twl4030
> registers in arch/arm/mach-omap2/omap_twl.c before the driver is
> initialized. Looking at the the SmartReflex bit enable code in
> omap_twl.c, we need to always set it.
>=20
> So let's fix the issue by always enabling the twl4030 SmartReflex
> bit in the drivers/mfd/twl-core.c probe, and drop the related
> code in omap_twl.c.
>=20
> Note that we still have some twl4030 tinkering left in omap_twl.c
> for the twl6030 case, but that's a different patch.
>=20
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c | 60 --------------------------------=
----------
>  drivers/mfd/twl-core.c         | 15 +++++++++++
>  2 files changed, 15 insertions(+), 60 deletions(-)

Patch looks okay to me, and removes lots of code which is nice to
see. How do you want to handle this patch? How about if I set up an
MFD-OMAP immutable branch for us to use leading up to the v3.16 merge
window?

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
