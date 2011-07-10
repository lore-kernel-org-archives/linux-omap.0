From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP2-only kernel compile broken
Date: Sat, 9 Jul 2011 19:57:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50386 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab1GJB5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 21:57:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, hemahk@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org


Hello Hema, Felipe,

Commits 208466dc10083e734a8af71d10f923ee4bff950c ("usb: otg:
OMAP4430: Powerdown the internal PHY when USB is disabled") and
fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430:
Power down the PHY during board init") break compilation on OMAP2:

  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to `omap4430_phy_init'
arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to `omap4430_phy_exit'
arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to `omap4430_phy_power'
arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to `omap4430_phy_set_clk'
arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to `omap4430_phy_suspend'
make: *** [.tmp_vmlinux1] Error 1


Could you please figure out a clean way to fix this for the 3.1 rc series?

thanks,

- Paul
