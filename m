From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 10:36:24 -0800
Message-ID: <20120209183624.GJ1426@atomide.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30273 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab2BISgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 13:36:35 -0500
Content-Disposition: inline
In-Reply-To: <20120209133739.GB2590@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120209 05:06]:
> On Thu, Feb 09, 2012 at 09:25:36AM +0200, Jarkko Nikula wrote:
> > On 02/09/2012 02:47 AM, Greg KH wrote:
> > > Show me an OMAP user that actually runs a mainline kernel :)
> 
> > I guess pretty much all these days? Most error reports what I recall
> > seeing during past 2-3 years are from mainline kernel and not that much
> > from linux-omap or some board support package kernel.
> 
> Most of the other guys are going in via the TI support channels rather
> than asking on the public lists I expect (and remember that even if
> people are basing their code on mainline the chances are they've still
> got a bunch of out of tree changes on top for their own boards if
> they're not directly using one of the reference boards).

Please everybody using omaps with mainline give a test for the
merge of the various fixes planned. I've done a branch with
v3.3-rc3 + Russell's fixes + Paul's serial port fixes + fixes
that I've queued up.

This fixes the various build and boot issues with custom .configs
that don't select CONFIG_MACH_OMAP_GENERIC. It should fix slow serial
console issues. And it fixes booting with DT to minimal enviroment.

If you still see problems with compiling, booting, or slow serial
port, please post the issues to linux-omap and LAKML lists
immediately.

The testing branch is available at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap testing-omap-fixes

For reference, see below what commits this branch contains.

Regards,

Tony


Benoit Cousson (1):
      ARM: OMAP2+: board-generic: Add missing handle_irq callbacks

Igor Grinberg (1):
      ARM: OMAP3: cm-t35: fix section mismatch warning

Paul Walmsley (3):
      tty: serial: omap-serial: wakeup latency constraint is in microseconds, not milliseconds
      tty: serial: OMAP: block idle while the UART is transferring data in PIO mode
      tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode

Russell King - ARM Linux (15):
      ARM: omap: fix oops in arch/arm/mach-omap2/vp.c when pmic is not found
      ARM: omap: fix oops in drivers/video/omap2/dss/dpi.c
      ARM: omap: fix broken twl-core dependencies and ifdefs
      ARM: omap: fix prm44xx.c OMAP44XX_IRQ_PRCM build error
      ARM: omap: fix vc.c PMIC error message
      ARM: omap: fix uninformative vc/i2c configuration error message
      ARM: omap: fix section mismatch errors in TWL PMIC driver
      ARM: omap: fix section mismatch warning in mux.c
      ARM: omap: preemptively fix section mismatch in omap4_sdp4430_wifi_mux_init()
      ARM: omap: fix section mismatch warning for omap_secondary_startup()
      ARM: omap: fix section mismatch error for omap_4430sdp_display_init()
      ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_setup()
      ARM: omap: fix section mismatch warnings in mux.c caused by hsmmc.c
      ARM: omap: fix wrapped error messages in omap_hwmod.c
      ARM: omap: resolve nebulous 'Error setting wl12xx data'

Santosh Shilimkar (1):
      ARM: OMAP2: Fix the OMAP2 only build break seen with 2011+ ARM tool-chains

Tony Lindgren (2):
      Merge branch 'fixes-dt' into fixes
      Merge branch 'fixes' into testing-omap-fixes
