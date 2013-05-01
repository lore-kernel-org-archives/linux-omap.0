From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 17:22:57 -0700
Message-ID: <20130501002257.GH28721@atomide.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201305010111.14247.arnd@arndb.de>
 <20130430235147.GG28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53140 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933945Ab3EAAXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 20:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20130430235147.GG28721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130430 16:57]:
> * Arnd Bergmann <arnd@arndb.de> [130430 16:16]:
> > 
> > I've uploaded this to the test-merge-20130430 branch in the arm-soc
> > tree if anyone is curious. I suppose we should get all the changes
> > in arch/arm included in the merge window and then work with the
> > subsystem maintainers on the other bugs.
> 
> >  arch/arm/mach-omap2/Kconfig                   | 133 +++++++++++++-------------
> >  arch/arm/mach-omap2/Makefile                  |   8 +-
> 
> Nice, I like your changes to flip ARCH_OMAP2PLUS to be selected
> by the SoC. That's a better way to fix things than just tinkering
> with the Makefile like I posted earlier today.
> 
> Now you have SOC_OMAP5 selected twice in omap2plus_defconfig though,
> which causes:
> 
> .config:283:warning: override: reassigning to symbol SOC_OMAP5
> 
> For the SERIAL_OMAP change, let's just use my earlier patch
> "ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP".
> We should not select optional drivers at all in Kconfig.

And looks like also the following should be folded in to allow building
ARCH_OMAP2. Other than that your branch seems to build & boot
fine on omaps.

Regards,

Tony


--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -21,6 +21,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_OMAP2=y
+CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
