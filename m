From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Wed, 26 May 2010 22:40:37 +0100
Message-ID: <20100526214037.GB16418@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk> <20100522215848.GB29889@n2100.arm.linux.org.uk> <20100526004418.GM9645@atomide.com> <20100526075059.GA25435@n2100.arm.linux.org.uk> <20100526135128.GN9645@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55873 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab0EZVky (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 17:40:54 -0400
Content-Disposition: inline
In-Reply-To: <20100526135128.GN9645@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Wed, May 26, 2010 at 06:51:29AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100526 00:45]:
> > On Tue, May 25, 2010 at 05:44:18PM -0700, Tony Lindgren wrote:
> > 
> > > After applying the next patch in your lmb branch "ARM: OMAP: Convert
> > > to use ->reserve method to reserve boot time memory" tux still works
> > > on 5912osk, but not on n900. The difference is that osk5912 uses
> > > the old omapfb code.
> > 
> > I guess this is because I don't have board-n900.c in my tree.  All OMAP
> > boards need a ".reserve = omap_reserve," line added in their machine
> > descriptor.
> 
> It's there but well hidden, board-rx51.c is the one for n900.
>  
> > I just noticed that board-n8x0.c contains more than one machine descriptor,
> > which I've now fixed up.
> 
> OK good catch.
> 
> > > Anyways, I've picked the patches from lmb branch up to the one below
> > > into omap-testing. Will add more of them once we get them working.
> > 
> > You should now be able to pick all but the last patch.
> 
> Yeah I'll do that once the dss2 code has been verified to work.

It'd help with this patch - it seems rx51 needs some additional stuff.
Any other OMAP platforms with this kind of thing?

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 3bd956f..e3a42d1 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -144,17 +144,22 @@ static void __init rx51_init(void)
 static void __init rx51_map_io(void)
 {
 	omap2_set_globals_343x();
-	rx51_video_mem_init();
 	omap34xx_map_common_io();
 }
 
+static void __init rx51_reserve(void)
+{
+	rx51_video_mem_init();
+	omap_reserve();
+}
+
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= rx51_map_io,
-	.reserve	= omap_reserve,
+	.reserve	= rx51_reserve,
 	.init_irq	= rx51_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap_timer,

