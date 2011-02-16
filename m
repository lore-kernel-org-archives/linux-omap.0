From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks, OMAP2xxx
Date: Wed, 16 Feb 2011 16:45:17 +0530
Message-ID: <43af56d25809fa616f0e17d7e641ebc0@mail.gmail.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34190 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756034Ab1BPLPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:15:22 -0500
Received: by fxm5 with SMTP id 5so1273791fxm.25
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 03:15:19 -0800 (PST)
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org
[mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf
> Of Paul Walmsley
> Sent: Wednesday, February 16, 2011 12:23 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
OMAP2xxx
>
> Hello,
>
> This patch series adds clock framework-controlled autoidle support for
> the OMAP2xxx DPLL, APLLs, and OMAP2/3 interface clocks.  The old
> direct register writes in the PM code to enable clock autoidle have been
> removed.
>
> This series also ensures that all clock autoidle is disabled during
> boot and only re-enabled if CONFIG_PM is enabled.
>
> The series applies on the 'clk_autoidle_a_2.6.39' branch of
> git://git.pwsan.com/linux-2.6.
>
> Boot-tested on N800, and dynamic idle-tested on OMAP3430 Beagleboard.
> Compile-tested with omap1_defconfig, omap2plus_defconfig, a 5912
> OSK-only config, an N8x0-only config, an OMAP3-only config, and an
OMAP4-only
> config.

Boot-tested on 3430sdp/4430sdp, with CONFIG_PM and with !CONFIG_PM.
suspend-offmode tested on 3430sdp and suspend-retmode on 4430sdp (with
some out-of-tree patches)
Dynamic idle testing on 3430sdp showed me some very jerky debug console
the
moment a 'echo 1 > /debug/pm_debug/sleep_while_idle' is done.
This however seems to be the case even on 2.6.38-rc4 and not related to
the
current patch series. Will debug further, but seems to some 3430sdp
specific
issue, since you did not see it on Beagleboard and seems it is not seen on
OMAP3
zoom's either.
Just out of curiosity, what dynamic-idle state where you able to achieve
on
Beagle? And what was the debug console timeout that you configured?

Regards,
Rajendra

>
>
> - Paul
>
> ---
>
> clk_autoidle_b_2.6.39
>    text	   data	    bss	    dec	    hex	filename
> 5530703	 330544	5594520	11455767	 aecd17
vmlinux.omap2plus_defconfig.orig
> 5531167	 330544	5594520	11456231	 aecee7
vmlinux.omap2plus_defconfig.patched
>
> Paul Walmsley (11):
>       OMAP2+: clock: disable autoidle on all clocks during clock init
>       OMAP2: clock: add DPLL autoidle support
>       OMAP2xxx: clock: add clockfw autoidle support for APLLs
>       OMAP2+: clock: comment that osc_ck/osc_sys_ck should use clockfw
autoidle control
>       OMAP2+: clock: add interface clock type code with autoidle support
>       OMAP2420: clock: add sdrc_ick
>       OMAP2420: clock: use autoidle clkops for all autoidle-controllable
interface clocks
>       OMAP2430/3xxx: clock: add modem clock autoidle support
>       OMAP2430: clock: use autoidle clkops for all autoidle-controllable
interface clocks
>       OMAP3: clock: use autoidle clkops for all autoidle-controllable
interface clocks
>       OMAP2/3: PM: remove manual CM_AUTOIDLE bit setting in
mach-omap2/pm*xx.c
>
>
>  arch/arm/mach-omap2/Makefile          |    7 +
>  arch/arm/mach-omap2/clkt2xxx_apll.c   |   24 +++++
>  arch/arm/mach-omap2/clkt2xxx_dpll.c   |   63 +++++++++++++
>  arch/arm/mach-omap2/clkt2xxx_osc.c    |   14 +++
>  arch/arm/mach-omap2/clkt_iclk.c       |   82 +++++++++++++++++
>  arch/arm/mach-omap2/clock.h           |   11 ++
>  arch/arm/mach-omap2/clock2420_data.c  |  130
+++++++++++++++++-----------
>  arch/arm/mach-omap2/clock2430_data.c  |  130
++++++++++++++++------------
>  arch/arm/mach-omap2/clock34xx.c       |   29 ++++++
>  arch/arm/mach-omap2/clock34xx.h       |    5 +
>  arch/arm/mach-omap2/clock3517.c       |    4 +
>  arch/arm/mach-omap2/clock3xxx.c       |    3 -
>  arch/arm/mach-omap2/clock3xxx_data.c  |  155
+++++++++++++++++----------------
>  arch/arm/mach-omap2/clock44xx_data.c  |    3 +
>  arch/arm/mach-omap2/cm-regbits-24xx.h |    3 +
>  arch/arm/mach-omap2/cm2xxx_3xxx.c     |   69 +++++++++++++++
>  arch/arm/mach-omap2/cm2xxx_3xxx.h     |    8 ++
>  arch/arm/mach-omap2/pm24xx.c          |   69 +--------------
>  arch/arm/mach-omap2/pm34xx.c          |  105 ----------------------
>  19 files changed, 557 insertions(+), 357 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clkt2xxx_dpll.c
>  create mode 100644 arch/arm/mach-omap2/clkt_iclk.c
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
