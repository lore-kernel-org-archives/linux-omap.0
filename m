From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix cpu_is_omap35xx default defines (Re: [PATCH]
	[RFC] omap: 3630: default cpu_is_omap3630 to zero)
Date: Tue, 13 Oct 2009 10:43:31 -0700
Message-ID: <20091013174330.GW12700@atomide.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com> <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB254E67@dbde02.ent.ti.com> <4AD452F1.7000309@gmail.com> <20091013171511.GS12700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56849 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760299AbZJMRoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 13:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20091013171511.GS12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sanjeev Premi <premi@ti.com>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091013 10:15]:
> * Nishanth Menon <menon.nishanth@gmail.com> [091013 03:44]:
> > Shilimkar, Santosh said the following on 10/13/2009 05:03 AM:
> > > Has anybody tried building latest linux-omap master ? The build is breaking for other OMAP processors.
> > >
> > > CC      arch/arm/mach-omap2/id.o
> > > arch/arm/mach-omap2/id.c: In function 'omap3_cpuinfo':
> > > arch/arm/mach-omap2/id.c:269: error: implicit declaration of function 'cpu_is_omap3630'
> > > make[1]: *** [arch/arm/mach-omap2/id.o] Error 1
> > > make: *** [arch/arm/mach-omap2] Error 2
> > >
> > > This is because of " 0a9b95f21995aa3cdda82ebc6e77b0b2ab401861"
> > > 	omap: Introduce OMAP3630
> > >
> > > Below patch from Vikram fixes the build break.
> > >   
> > ouch.. my bad.. thanks for answering my question. I am guessing we need
> > this coz of is_omap3630() translation..
> > Ack for the patch from me.
> 
> To me it looks like all the 35x defines need the same treatment.

And here's the patch to do that.

--WhfpMioaduB5tiZL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="35xx-default-defines.patch"

omap: Fix cpu_is_omap35xx default defines

Otherwise compilation on other processors
will fail if these are used in the code.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index a67a95c..770cb60 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -322,6 +322,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap3503()		0
+#define cpu_is_omap3515()		0
+#define cpu_is_omap3525()		0
+#define cpu_is_omap3530()		0
 #define cpu_is_omap3630()		0
 
 /*

--WhfpMioaduB5tiZL--
