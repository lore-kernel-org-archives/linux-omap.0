From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH] GPMC: Limited addressing support
Date: Fri, 15 Jul 2011 16:16:01 -0400
Message-ID: <4E20A001.6060508@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:48453 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563Ab1GOUQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 16:16:04 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Qhonp-0006l4-Up
	for linux-omap@vger.kernel.org; Fri, 15 Jul 2011 16:16:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch provides a way to enable the GPMC limited addressing
mode which is needed to access nonmultiplexed devices.

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 130034b..521944a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -540,6 +540,15 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
 		break;
 
+	case GPMC_EN_LIMITEDADDRESS:
+		regval = gpmc_read_reg(GPMC_CONFIG);
+		if (wval)
+			regval |= GPMC_CONFIG_LIMITEDADDRESS;
+		else
+			regval &= ~GPMC_CONFIG_LIMITEDADDRESS;
+		gpmc_write_reg(GPMC_CONFIG, regval);
+		break;
+
 	default:
 		printk(KERN_ERR "gpmc_configure_cs: Not supported\n");
 		err = -EINVAL;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 1527929..7fdbbb8 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -42,6 +42,7 @@
 #define GPMC_NAND_DATA		0x0000000c
 
 #define GPMC_ENABLE_IRQ		0x0000000d
+#define GPMC_EN_LIMITEDADDRESS	0x0000000e
 
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
@@ -75,6 +76,7 @@
 
 #define GPMC_DEVICETYPE_NOR		0
 #define GPMC_DEVICETYPE_NAND		2
+#define GPMC_CONFIG_LIMITEDADDRESS	0x00000002
 #define GPMC_CONFIG_WRITEPROTECT	0x00000010
 #define GPMC_STATUS_BUFF_EMPTY		0x00000001
 #define WR_RD_PIN_MONITORING		0x00600000
