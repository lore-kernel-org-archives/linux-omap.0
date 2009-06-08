From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:  Re: Beagleboard rev C memory timings & suspend/resume)
Date: Mon, 8 Jun 2009 11:02:00 +0200
Message-ID: <200906081102.00779.jpihet@mvista.com>
References: <200904291553.49378.jpihet@mvista.com> <alpine.DEB.2.00.0906051308370.31531@utopia.booyaka.com> <6ed0b2680906060350i4de093fbj3575ba117c084295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:21476 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbZFHJCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 05:02:35 -0400
In-Reply-To: <6ed0b2680906060350i4de093fbj3575ba117c084295@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

Paul, Gra=9Evydas,

Ok, thanks!

Here is a patch that addresses the Pandora's use of 2 SDRAM chip select=
s.
It applies on top of 'OMAP3: add support for 2 SDRAM chip selects'.

Is that OK? It has been build tested only.

Regards,
Jean

=46rom 297a0b09267fc1a0ae4428771ff54b73b27d5bbe Mon Sep 17 00:00:00 200=
1
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Mon, 8 Jun 2009 10:49:53 +0200
Subject: OMAP3 Pandora: add support for 2 SDRAM chip selects

This allows the self refresh to work correctly on
Pandora.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c=20
b/arch/arm/mach-omap2/board-omap3pandora.c
index 05ab99e..ba015b4 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -44,6 +44,7 @@
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 #include <mach/usb.h>
 #include <mach/mcspi.h>
=20
@@ -220,7 +221,8 @@ static int __init omap3pandora_i2c_init(void)
=20
 static void __init omap3pandora_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params,
 			     NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
@@ -307,6 +309,10 @@ static void __init omap3pandora_init(void)
 	usb_ehci_init();
 	omap3pandora_flash_init();
 	omap3pandora_ads7846_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
=20
 static void __init omap3pandora_map_io(void)
--=20
1.6.2.5.168.g3823


On Saturday 06 June 2009 12:50:42 Grazvydas Ignotas wrote:
> On Fri, Jun 5, 2009 at 10:14 PM, Paul Walmsley<paul@pwsan.com> wrote:
> > Hi Jean,
> >
> > On Fri, 5 Jun 2009, Jean Pihet wrote:
> >> Some notes:
> >> - all calls to omap2_init_common_hw have been adapted in the board
> >> files. it looks like 2430SDP and Pandora board files are broken si=
nce
> >> they use only one param. Can that be checked on those boards?
> >
> > Yep, builds with those two boards are broken on the PM branch, and =
it
> > looks like your patch fixes both.
> >
> > Gra=9Eyvdas, looks like Pandora might use 2 SDRAM chipselects also?
>
> Yes it does, it uses different part than Beagle rev C (256/512
> RAM/NAND instead of 256/256), but RAM portion should be identical I
> guess.
>
>
> Gra=9Evydas


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
