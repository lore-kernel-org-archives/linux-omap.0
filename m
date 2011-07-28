From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Thu, 28 Jul 2011 00:53:47 -0500
Message-ID: <20110728055346.GA11921@foobar>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-4-git-send-email-khilman@ti.com>
 <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40119 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751971Ab1G1Fxx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 01:53:53 -0400
Received: by mail-gy0-f174.google.com with SMTP id 3so1976395gyh.5
        for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 22:53:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11:57-20110722, Felipe Balbi wrote:
[...]
> >  	/* Custom OPP enabled for all xM versions */
> >  	if (cpu_is_omap3630()) {
> > -		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> > -		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
> > -		struct device *dev;
> > +		struct device *mpu_dev, *iva_dev;
> >  
> > -		if (!mh || !dh) {
> > +		mpu_dev = omap2_get_mpuss_device();
> > +		iva_dev = omap2_get_iva_device();
> 
> out of curiosity again, nothing to do with this patch.
> 
> Maybe it would be nicer to have an api such as:
> 
> omap2_get_device(name);
> 
> there are already four devices to be gotten, if that number grows any
> bigger, so will the number of helper functions.
I agree, in fact, on a different topic, I hit the same requirement
here is the patch I had done:
>From 9f226def811bd50e4bac02f427604034cef77706 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Wed, 27 Jul 2011 15:02:32 -0500
Subject: [PATCH] OMAP: hwmod: add omap_hwmod_to_device

omap_hwmod_to_device is useful for drivers when they need to
look up the device associated with a hwmod name to map back
into the device structure pointers. These ideally should
be used by drivers in mach directory. This could in effect
replace apis such as omap2_get_mpuss_device,
omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device
etc..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..77d01a2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -142,6 +142,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2369,3 +2370,35 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/**
+ * omap_hwmod_to_device() - convert a hwmod name to device pointer
+ * @oh_name: name of the hwmod device
+ *
+ * returns back a struct device * pointer associated with a hwmod
+ * device represented by a hwmod_name
+ */
+struct device *omap_hwmod_to_device(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+
+	if (!oh_name) {
+		WARN(1, "%s: no hwmod name!\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	oh = _lookup(oh_name);
+	if (IS_ERR_OR_NULL(oh)) {
+		WARN(1, "%s: no hwmod for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(-ENODEV);
+	}
+	if (IS_ERR_OR_NULL(oh->od)) {
+		WARN(1, "%s: no omap_device for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return &oh->od->pdev.dev;
+}
+EXPORT_SYMBOL(omap_hwmod_to_device);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..b9eec08 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -611,4 +611,6 @@ extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
 
+extern struct device *omap_hwmod_to_device(const char *oh_name);
+
 #endif
-- 
1.7.4.1

