From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/9] ARM: OMAP: Fix hsmmc init, v2
Date: Thu, 29 Jan 2009 10:48:17 -0800
Message-ID: <20090129184815.GB7215@atomide.com>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182935.21007.41010.stgit@localhost> <20090128190802.GE23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50241 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZA2SsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 13:48:25 -0500
Content-Disposition: inline
In-Reply-To: <20090128190802.GE23301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 11:08]:
> On Wed, Jan 28, 2009 at 10:29:35AM -0800, Tony Lindgren wrote:
> > It accidentally broke while changing the name for the driver
> > to not to conflict with the other mmc driver.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/devices.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> > index ac15c23..d22529c 100644
> > --- a/arch/arm/plat-omap/devices.c
> > +++ b/arch/arm/plat-omap/devices.c
> > @@ -205,9 +205,15 @@ int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
> >  {
> >  	struct platform_device *pdev;
> >  	struct resource res[OMAP_MMC_NR_RES];
> > +	char *name;
> >  	int ret;
> >  
> > -	pdev = platform_device_alloc("mmci-omap", id);
> > +	if (cpu_class_is_omap1() || cpu_is_omap242x())
> > +		name = "mmci-omap";
> > +	else
> > +		name = "mmci-omap-hs";
> > +
> > +	pdev = platform_device_alloc(name, id);
> >  	if (!pdev)
> >  		return -ENOMEM;
> >  
> 
> This is error prone.  I suggest instead:
> 
> int __init omap_mmc_add(const char *name, int id, unsigned long base,
> 		unsigned long size, unsigned int irq,
> 		struct omap_mmc_platform_data *data)
> 
> and moving that conditional up a level - OMAP1 not having it conditional,
> and OMAP2 having the condition there along side the other in
> omap2_init_mmc.
> 
> And, it's already in error.  Look at these two conditionals closely:
> 
> from plat-omap/devices.c:
> +	if (cpu_class_is_omap1() || cpu_is_omap242x())
> +		name = "mmci-omap";
> +	else
> +		name = "mmci-omap-hs";
> 
> and from mach-omap2/devices.c::omap2_init_mmc():
>                 if (cpu_is_omap2420())
>                         size = OMAP2420_MMC_SIZE;
>                 else
>                         size = HSMMC_SIZE;
> 
> These disagree about which CPUs have HSMMC and which don't.

OK, here's the updated version.

Tony

--fdj2RfSjLxBAspz7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-init-v2.patch"

>From 0dffb5c57a1d76532e2f2c7398579bfce81c3e5c Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 29 Jan 2009 08:57:16 -0800
Subject: [PATCH] ARM: OMAP: Fix hsmmc init, v2

The naming accidentally broke while changing the name for the
driver to not to conflict with the other mmc driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 77382d8..ba5d7c0 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -181,7 +181,7 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		}
 		size = OMAP1_MMC_SIZE;
 
-		omap_mmc_add(i, base, size, irq, mmc_data[i]);
+		omap_mmc_add("mmci-omap", i, base, size, irq, mmc_data[i]);
 	};
 }
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9d7216f..ce03fa7 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -421,6 +421,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			int nr_controllers)
 {
 	int i;
+	char *name;
 
 	for (i = 0; i < nr_controllers; i++) {
 		unsigned long base, size;
@@ -450,12 +451,14 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			continue;
 		}
 
-		if (cpu_is_omap2420())
+		if (cpu_is_omap2420()) {
 			size = OMAP2420_MMC_SIZE;
-		else
+			name = "mmci-omap";
+		} else {
 			size = HSMMC_SIZE;
-
-		omap_mmc_add(i, base, size, irq, mmc_data[i]);
+			name = "mmci-omap-hs";
+		}
+		omap_mmc_add(name, i, base, size, irq, mmc_data[i]);
 	};
 }
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ac15c23..208dbb1 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -200,14 +200,15 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 /*
  * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
  */
-int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
-		unsigned int irq, struct omap_mmc_platform_data *data)
+int __init omap_mmc_add(const char *name, int id, unsigned long base,
+				unsigned long size, unsigned int irq,
+				struct omap_mmc_platform_data *data)
 {
 	struct platform_device *pdev;
 	struct resource res[OMAP_MMC_NR_RES];
 	int ret;
 
-	pdev = platform_device_alloc("mmci-omap", id);
+	pdev = platform_device_alloc(name, id);
 	if (!pdev)
 		return -ENOMEM;
 
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 031250f..73a9e15 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -115,8 +115,9 @@ void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
 void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers);
-int omap_mmc_add(int id, unsigned long base, unsigned long size,
-			unsigned int irq, struct omap_mmc_platform_data *data);
+int omap_mmc_add(const char *name, int id, unsigned long base,
+				unsigned long size, unsigned int irq,
+				struct omap_mmc_platform_data *data);
 #else
 static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers)
@@ -126,8 +127,9 @@ static inline void omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 				int nr_controllers)
 {
 }
-static inline int omap_mmc_add(int id, unsigned long base, unsigned long size,
-		unsigned int irq, struct omap_mmc_platform_data *data)
+static inline int omap_mmc_add(const char *name, int id, unsigned long base,
+				unsigned long size, unsigned int irq,
+				struct omap_mmc_platform_data *data)
 {
 	return 0;
 }

--fdj2RfSjLxBAspz7--
