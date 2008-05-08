From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [RFC/PATCH 1/3] net:smc911x Modify driver to also work with omap34xx
Date: Thu, 8 May 2008 09:48:31 -0700
Message-ID: <5e088bd90805080948g429df087je2a30ab3a80e28cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:2446 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbYEHQsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 12:48:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so566309fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2008 09:48:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Steve Sakoman <steve@sakoman.com>

net:smc911x Modify driver to also work with omap34xx

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 drivers/net/Kconfig   |    2 +-
 drivers/net/smc911x.c |    9 ++++++---
 drivers/net/smc911x.h |    5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index af46341..70192b6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -955,7 +955,7 @@ config SMC911X
 	tristate "SMSC LAN911[5678] support"
 	select CRC32
 	select MII
-	depends on ARCH_PXA || SH_MAGIC_PANEL_R2
+	depends on ARCH_PXA || SH_MAGIC_PANEL_R2 || ARCH_OMAP34XX
 	help
 	  This is a driver for SMSC's LAN911x series of Ethernet chipsets
 	  including the new LAN9115, LAN9116, LAN9117, and LAN9118.
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 4e28002..40ff2a5 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -2137,7 +2137,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto out;
 	}
-
+#ifndef SMC_MEM_RESERVED
 	/*
 	 * Request the regions.
 	 */
@@ -2145,7 +2145,7 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 		 ret = -EBUSY;
 		 goto out;
 	}
-
+#endif
 	ndev = alloc_etherdev(sizeof(struct smc911x_local));
 	if (!ndev) {
 		printk("%s: could not allocate device.\n", CARDNAME);
@@ -2173,7 +2173,9 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 release_both:
 		free_netdev(ndev);
 release_1:
+#ifndef SMC_MEM_RESERVED
 		release_mem_region(res->start, SMC911X_IO_EXTENT);
+#endif
 out:
 		printk("%s: not found (%d).\n", CARDNAME, ret);
 	}
@@ -2212,8 +2214,9 @@ static int smc911x_drv_remove(struct
platform_device *pdev)
 #endif
 	iounmap((void *)ndev->base_addr);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+#ifndef SMC_MEM_RESERVED
 	release_mem_region(res->start, SMC911X_IO_EXTENT);
-
+#endif
 	free_netdev(ndev);
 	return 0;
 }
diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
index 7defa63..dad93a8 100644
--- a/drivers/net/smc911x.h
+++ b/drivers/net/smc911x.h
@@ -42,6 +42,11 @@
   #define SMC_USE_16BIT		0
   #define SMC_USE_32BIT		1
   #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
+#elif defined(CONFIG_ARCH_OMAP34XX)
+  #define SMC_USE_16BIT		0
+  #define SMC_USE_32BIT		1
+  #define SMC_IRQ_SENSE		IRQF_TRIGGER_LOW
+  #define SMC_MEM_RESERVED	1
 #endif


-- 
1.5.4.5
