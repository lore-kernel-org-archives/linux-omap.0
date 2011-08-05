From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/4] regulator: omap smps regulator driver
Date: Fri, 05 Aug 2011 16:48:42 -0700
Message-ID: <87ei0zo1wl.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:38579 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753592Ab1HEXsq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 19:48:46 -0400
Received: by mail-iy0-f182.google.com with SMTP id 1so4111364iye.27
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 16:48:44 -0700 (PDT)
In-Reply-To: <1311853739-18984-3-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 28 Jul 2011 14:48:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

Tero Kristo <t-kristo@ti.com> writes:

> OMAP SMPS regulator driver provides access to OMAP voltage processor
> controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
> additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
> layer for the actual voltage regulation operations.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

FYI, this adds a section mismatch warning:

WARNING: vmlinux.o(.devinit.text+0x1984): Section mismatch in reference from the function omap_smps_reg_probe() to the (unknown reference) .init.data:(unknown)
The function __devinit omap_smps_reg_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by omap_smps_reg_probe then
annotate (unknown) with a matching annotation.

