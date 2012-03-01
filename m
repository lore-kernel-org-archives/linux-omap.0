From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [GIT PULL 3/5] First set of omap1 related changes
Date: Thu, 01 Mar 2012 23:26:21 +0100
Message-ID: <3378572.m1z82NvySs@acer>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de> <201202292106.40731.arnd@arndb.de> <20120229211331.GP18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59669 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965273Ab2CAW2j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 17:28:39 -0500
In-Reply-To: <20120229211331.GP18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 29 Feb 2012 13:13:31 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [120229 12:35]:
> > On Wednesday 29 February 2012, Tony Lindgren wrote:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap 
omap1
> > > 
> > > Janusz Krzysztofik (7):
> > >       ARM: OMAP1: ams-delta: register latch dependent devices 
later
> > >       ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
> > >       ARM: OMAP1: ams-delta: supersede custom led device by leds-
gpio
> > >       LED: drop leds-ams-delta driver
> > >       MTD: NAND: ams-delta: use GPIO instead of custom I/O
> > >       omapfb: lcd_ams_delta: drive control lines over GPIO
> > >       input: serio: ams-delta: toggle keyboard power over GPIO
> > > 
> > 
> > Since these are all for ams-delta, I pulled them into next/boards 
together
> > with other board specific updates.
> 
> OK makes sense.

Any chance for the continuation series [1] as well as two section 
mismatch related fixes [2] [3] getting your attention? NB, that 
continuation series needs another section mismatch fix, which I was 
planing to submit once there was a stable base for it.

Thanks,
Janusz

[1] http://www.spinics.net/lists/linux-omap/msg64146.html
[2] http://www.spinics.net/lists/linux-omap/msg64441.html
[3] http://www.spinics.net/lists/linux-omap/msg64442.html
