From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into
 mach/io.h
Date: Wed, 29 Feb 2012 17:03:48 -0800
Message-ID: <20120301010348.GV18901@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234049.18709.28987.stgit@kaulin.local>
 <4F4451FB.7070007@gmail.com>
 <20120224000657.GJ18185@atomide.com>
 <20120224182246.GL18185@atomide.com>
 <4F4AFCC7.3020509@gmail.com>
 <20120229014719.GK18901@atomide.com>
 <4F4EBBDF.9090806@gmail.com>
 <20120301001140.GA18438@n2100.arm.linux.org.uk>
 <20120301003939.GU18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48804 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab2CABDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 20:03:55 -0500
Content-Disposition: inline
In-Reply-To: <20120301003939.GU18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rob Herring <robherring2@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org, Matt Mackall <mpm@selenic.com>

* Tony Lindgren <tony@atomide.com> [120229 16:08]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120229 15:40]:
> > On Wed, Feb 29, 2012 at 05:59:27PM -0600, Rob Herring wrote:
> > > BTW, all these includes need to get removed. I'll add a fix to my series
> > > unless you already have fixes:
> > > 
> > > arch/arm/mach-omap1/sleep.S:#include <mach/io.h>
> > > arch/arm/mach-omap1/sram.S:#include <mach/io.h>
> > > arch/arm/plat-omap/include/plat/sdrc.h:#include <mach/io.h>
> > > drivers/media/video/davinci/vpbe_osd.c:#include <mach/io.h>
> > > drivers/media/video/davinci/vpbe_venc.c:#include <mach/io.h>
> > > drivers/video/omap2/vrfb.c:#include <mach/io.h>
> > 
> > All the ones included from .h and .c files should be using linux/io.h
> > and not some other derivative.
> 
> Oops looks like I missed some files while fixing up the .c files.
> The .S files should be able to just use the local header now.
> 
> I'll do a patch for that, won't touch the davinci files though.

Here's the patch to remove mach/io.h for omaps. We can now remove
all of them like Rob suggested :)

Rob, I assume you'll apply this into your branch?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 29 Feb 2012 17:01:22 -0800
Subject: [PATCH] ARM: OMAP: Remove remaining includes for mach/io.h

These are no longer needed with the recent iomap.h
changes.

Reported-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -11,7 +11,6 @@
  */
 
 #include <mach/hardware.h>
-#include <mach/io.h>
 #include <mach/irqs.h>
 
 #include "../../iomap.h"
--- a/arch/arm/mach-omap1/sram.S
+++ b/arch/arm/mach-omap1/sram.S
@@ -12,7 +12,6 @@
 
 #include <asm/assembler.h>
 
-#include <mach/io.h>
 #include <mach/hardware.h>
 
 #include "iomap.h"
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -16,8 +16,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/io.h>
-
 /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
 
 #define SDRC_SYSCONFIG		0x010
--- a/drivers/video/omap2/vrfb.c
+++ b/drivers/video/omap2/vrfb.c
@@ -27,7 +27,6 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 
-#include <mach/io.h>
 #include <plat/vrfb.h>
 #include <plat/sdrc.h>
 
