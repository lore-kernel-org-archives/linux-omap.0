From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/12] arm: omap3: am35x: Add do_wfi routine for EMIF4 submodules
Date: Wed, 11 Apr 2012 15:35:53 -0700
Message-ID: <871untrj5i.fsf@ti.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
	<1334171147-7517-12-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50765 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270Ab2DKWfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 18:35:44 -0400
Received: by dajx4 with SMTP id x4so2178025daj.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 15:35:43 -0700 (PDT)
In-Reply-To: <1334171147-7517-12-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Wed, 11 Apr 2012 12:05:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Ranjith Lohithakshan <ranjithl@ti.com>

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The typical SDRAM Controller Subsystem module (SDRC)
> on TI OMAP3 devices has two submodules: the SDRAM Memory
> Scheduler (SMS) submodule, and the SDRC submodule--the
> 'SDRC' acronym/term is overloaded.  The am35x family of
> devices is different in that it has an EMIF4 submodule
> instead of an SDRC submodule.  The SMS submodules are
> similar, though.
>
> The difference in SDRC/EMIF4 submodules is important because
> omap34xx_cpu_suspend() will ultimately access the submodule's
> registers and the register sets are different.  To support
> the EMIF4 submodule, add the omap3_emif4_do_wfi() routine which
> roughly does for the EMIF4 submodule what omap3_do_wfi() does
> for the SDRC submodule.  This requires omap34xx_cpu_suspend()
> to use a pointer set up in omap_push_sram_idle() so that it
> jumps to the correct omap3*_do_wfi() routine in either SDRAM
> or SRAM.
>
> Credits: arch/arm/mach-omap2/sleep3517.S in TI's am35x SDK
> (05.03.02.00) which appears to be authored by Ranjith Lohithakshan
> <ranjithl@ti.com> was used as a reference.
>
> CC: Ranjith Lohithakshan <ranjithl@ti.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Dumb Q: do you actually need to do the EMIF4 self-refresh control from
SRAM?

The reason I ask is because on OMAP3, we tried going down the path of
not running any of this from SRAM (run it from cache instead.)  However,
due to some errata (c.f. wait_sdrc*, wait_dll_* ...), we had to handle
these errata from SRAM.

Looking at your omap3_emif4_do_wfi, it looks like that's very minimal,
and can probably be prefetched/run from cache.

Kevin

