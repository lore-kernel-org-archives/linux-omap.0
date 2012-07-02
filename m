From: Kevin Hilman <khilman@ti.com>
Subject: Re: 3.5-rc3: vdd_mpu_iva warnings
Date: Mon, 02 Jul 2012 14:18:31 -0700
Message-ID: <8762a56evs.fsf@ti.com>
References: <WC20120618103957.6103F2@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40617 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932209Ab2GBVS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 17:18:27 -0400
Received: by ggnv5 with SMTP id v5so5053155ggn.40
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 14:18:24 -0700 (PDT)
In-Reply-To: <WC20120618103957.6103F2@terrafix.co.uk> (Joe Woodward's message
	of "Mon, 18 Jun 2012 11:39:57 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> I have a GUMSTIX Overo AirSTORM module (AM3703-based).
>
> When booting the kernel the following features are listed:
> OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
>
> After booting I get the following (repeating every few seconds):
>
> [   81.122558] voltdm_scale: No voltage scale API registered for vdd_mpu_iva
> [   81.130340] platform mpu.0: omap_target: unable to scale voltage up.

Do you have CPUfreq enabled?  I suspect so. 

With CPUfreq enabled, this seems to be happening once on boot, even on
platforms with an IVA (like my Overo FireSTORM).  But I'm very curious
how it is happening every few seconds on your platform.  Do you have the
CPUfreq ondemand governor running with an active load?

The boot-time warning seems to be an init ordering problem.  The CPUfreq
driver (upon registration) seems to try to set the frequency (and
voltage), and this is happening before the voltage layer is fully
initialized.  I'm looking into this one.

Why it would continue to happen after boot though is a bit of a
mystery.  I'm looking into that now.

> I have SmartReflex enabled, and the same defconfig used to work on 3.4.
> CONFIG_OMAP_SMARTREFLEX=y
> CONFIG_OMAP_SMARTREFLEX_CLASS3=y
>
> I'm assuming this is because of changes to twl-common.c to add the "IVA" voltage 
> domain, but on the OMAP I have there is no IVA - hence the warnings?

I don't think it's related to IVA.  The voltage domain contains both the
MPU and the IVA (if present), so that voltage domain will be present on
all SoCs in this family.

> Is there a known fix for this (disabling SmartReflex seems to make no difference)?

I don't think it's related to SmartReflex either.

Kevin
