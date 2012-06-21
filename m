From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 6/7] ARM: OMAP2+: CM: increase the module disable
 timeout
Date: Thu, 21 Jun 2012 15:10:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206211509100.10198@utopia.booyaka.com>
References: <20120618061037.30632.28539.stgit@dusk> <20120618061611.30632.51094.stgit@dusk> <4FE074A8.5010109@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54771 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760156Ab2FUVKo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 17:10:44 -0400
In-Reply-To: <4FE074A8.5010109@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>


Hello Sergei,

On Tue, 19 Jun 2012, Sergei Shtylyov wrote:

> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 6b0aedc..a428305 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -30,6 +30,7 @@
> >   #include<plat/mmc.h>
> >   #include<plat/dmtimer.h>
> >   #include<plat/common.h>
> > +#include<plat/usb.h>
> 
>    How this hunk is related?

Indeed, it's not.  Thanks for pointing this out.  Updated patch below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 17 Jun 2012 11:57:53 -0600
Subject: [PATCH] ARM: OMAP2+: CM: increase the module disable timeout

Increase the timeout for disabling an IP block to five milliseconds.
This is to handle the usb_host_fs idle latency, which takes almost
four milliseconds after a host controller reset.

This is the second of two patches needed to resolve the following
boot warning:

omap_hwmod: usb_host_fs: _wait_target_disable failed

Thanks to Sergei Shtylyov <sshtylyov@mvista.com> for finding
an unrelated hunk in a previous version of this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h         |   11 +++++++++++
 arch/arm/mach-omap2/cminst44xx.c |    4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index a7bc096..f24e3f7 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -22,4 +22,15 @@
  */
 #define MAX_MODULE_READY_TIME		2000
 
+/*
+ * MAX_MODULE_DISABLE_TIME: max duration in microseconds to wait for
+ * the PRCM to request that a module enter the inactive state in the
+ * case of OMAP2 & 3.  In the case of OMAP4 this is the max duration
+ * in microseconds for the module to reach the inactive state from
+ * a functional state.
+ * XXX FSUSB on OMAP4430 takes ~4ms to idle after reset during
+ * kernel init.
+ */
+#define MAX_MODULE_DISABLE_TIME		5000
+
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 8c86d29..1a39945 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -313,9 +313,9 @@ int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_off
 
 	omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) ==
 			   CLKCTRL_IDLEST_DISABLED),
-			  MAX_MODULE_READY_TIME, i);
+			  MAX_MODULE_DISABLE_TIME, i);
 
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+	return (i < MAX_MODULE_DISABLE_TIME) ? 0 : -EBUSY;
 }
 
 /**
-- 
1.7.10

