From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Sun, 10 Jul 2011 05:43:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com> <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50527 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab1GJLnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 07:43:25 -0400
In-Reply-To: <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

On Sun, 10 Jul 2011, Felipe Balbi wrote:

> On Sat, Jul 09, 2011 at 07:57:20PM -0600, Paul Walmsley wrote:
> > Hello Hema, Felipe,
> > 
> > Commits 208466dc10083e734a8af71d10f923ee4bff950c ("usb: otg:
> > OMAP4430: Powerdown the internal PHY when USB is disabled") and
> > fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430:
> > Power down the PHY during board init") break compilation on OMAP2:
> > 
> >   LD      .tmp_vmlinux1
> > arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to `omap4430_phy_init'
> > arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to `omap4430_phy_exit'
> > arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to `omap4430_phy_power'
> > arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to `omap4430_phy_set_clk'
> > arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to `omap4430_phy_suspend'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > 
> > Could you please figure out a clean way to fix this for the 3.1 rc series?
> 
> Patch attached, if you want to queue it for the merge window.

This patch doesn't build when based on the arm-soc omap/cleanup branch.

arch/arm/mach-omap2/twl-common.c:55:19: error: 'omap4430_phy_set_clk' 
undeclared here (not in a function)

- Paul
