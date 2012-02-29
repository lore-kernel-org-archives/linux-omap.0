From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/5] First set of omap1 related changes
Date: Wed, 29 Feb 2012 13:13:31 -0800
Message-ID: <20120229211331.GP18901@atomide.com>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
 <201202292106.40731.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56669 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199Ab2B2VNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 16:13:34 -0500
Content-Disposition: inline
In-Reply-To: <201202292106.40731.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120229 12:35]:
> On Wednesday 29 February 2012, Tony Lindgren wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
> > 
> > Janusz Krzysztofik (7):
> >       ARM: OMAP1: ams-delta: register latch dependent devices later
> >       ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
> >       ARM: OMAP1: ams-delta: supersede custom led device by leds-gpio
> >       LED: drop leds-ams-delta driver
> >       MTD: NAND: ams-delta: use GPIO instead of custom I/O
> >       omapfb: lcd_ams_delta: drive control lines over GPIO
> >       input: serio: ams-delta: toggle keyboard power over GPIO
> > 
> 
> Since these are all for ams-delta, I pulled them into next/boards together
> with other board specific updates.

OK makes sense.

Thanks,

Tony
