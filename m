From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [RFC/PATCH] twl4030: Set irq number based upon cpu type rather than requiring #define in board.h files
Date: Tue, 6 May 2008 12:14:04 -0700
Message-ID: <5e088bd90805061214i2ff9a22x118bcc26b0578cbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:2418 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761910AbYEFTOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 15:14:12 -0400
Received: by mu-out-0910.google.com with SMTP id w8so325615mue.1
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 12:14:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Steve Sakoman <steve@sakoman.com>

Set twl4030 irq number based upon cpu type rather than requiring
#define in board.h files

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
diff -uprN a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
--- a/drivers/i2c/chips/twl4030-core.c	2008-05-06 10:45:14.000000000 -0700
+++ b/drivers/i2c/chips/twl4030-core.c	2008-05-06 10:57:01.000000000 -0700
@@ -716,6 +716,7 @@ static void twl_init_irq(void)
 	int	i = 0;
 	int	res = 0;
 	char	*msg = "Unable to register interrupt subsystem";
+	unsigned int irq_num;

 	/*
 	 * We end up with interrupts from other modules before
@@ -880,10 +881,12 @@ static void twl_init_irq(void)
 		set_irq_flags(i, IRQF_VALID);
 	}

+	irq_num = (cpu_is_omap2430()) ? INT_24XX_SYS_NIRQ : INT_34XX_SYS_NIRQ;
+
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
-	set_irq_data(TWL4030_IRQNUM, start_twl4030_irq_thread(TWL4030_IRQNUM));
-	set_irq_type(TWL4030_IRQNUM, IRQT_FALLING);
-	set_irq_chained_handler(TWL4030_IRQNUM, do_twl4030_irq);
+	set_irq_data(irq_num, start_twl4030_irq_thread(irq_num));
+	set_irq_type(irq_num, IRQT_FALLING);
+	set_irq_chained_handler(irq_num, do_twl4030_irq);

 	res = power_companion_init();
 	if (res < 0)
diff -uprN a/include/asm-arm/arch-omap/board-2430osk.h
b/include/asm-arm/arch-omap/board-2430osk.h
--- a/include/asm-arm/arch-omap/board-2430osk.h	2008-05-05
22:30:26.000000000 -0700
+++ b/include/asm-arm/arch-omap/board-2430osk.h	2008-05-06
11:02:37.000000000 -0700
@@ -33,6 +33,4 @@
 #define OMAP24XX_ETHR_START		0x08000300
 #define OMAP24XX_ETHR_GPIO_IRQ		149

-#define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
-
 #endif /* __ASM_ARCH_OMAP_2430OSK_H */
diff -uprN a/include/asm-arm/arch-omap/board-2430sdp.h
b/include/asm-arm/arch-omap/board-2430sdp.h
--- a/include/asm-arm/arch-omap/board-2430sdp.h	2008-05-05
22:30:26.000000000 -0700
+++ b/include/asm-arm/arch-omap/board-2430sdp.h	2008-05-06
11:02:57.000000000 -0700
@@ -34,8 +34,6 @@
 #define OMAP24XX_ETHR_GPIO_IRQ		149
 #define SDP2430_CS0_BASE		0x04000000

-#define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
-
 /* Function prototypes */
 extern void sdp2430_flash_init(void);
 extern void sdp2430_usb_init(void);
diff -uprN a/include/asm-arm/arch-omap/board-3430sdp.h
b/include/asm-arm/arch-omap/board-3430sdp.h
--- a/include/asm-arm/arch-omap/board-3430sdp.h	2008-05-05
22:30:26.000000000 -0700
+++ b/include/asm-arm/arch-omap/board-3430sdp.h	2008-05-06
11:03:17.000000000 -0700
@@ -66,7 +66,5 @@ extern void sdp3430_usb_init(void);
 #define FLASH_SIZE_SDPV1	SZ_64M
 #define FLASH_SIZE_SDPV2	SZ_128M

-#define TWL4030_IRQNUM INT_34XX_SYS_NIRQ
-
 #endif /* __ASM_ARCH_OMAP_3430SDP_H */

diff -uprN a/include/asm-arm/arch-omap/board-omap3beagle.h
b/include/asm-arm/arch-omap/board-omap3beagle.h
--- a/include/asm-arm/arch-omap/board-omap3beagle.h	2008-05-05
22:30:26.000000000 -0700
+++ b/include/asm-arm/arch-omap/board-omap3beagle.h	2008-05-06
11:03:34.000000000 -0700
@@ -29,7 +29,5 @@
 #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
 #define __ASM_ARCH_OMAP3_BEAGLE_H

-#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
-
 #endif /* __ASM_ARCH_OMAP3_BEAGLE_H */

diff -uprN a/include/asm-arm/arch-omap/board-omap3evm.h
b/include/asm-arm/arch-omap/board-omap3evm.h
--- a/include/asm-arm/arch-omap/board-omap3evm.h	2008-05-05
22:30:26.000000000 -0700
+++ b/include/asm-arm/arch-omap/board-omap3evm.h	2008-05-06
11:04:01.000000000 -0700
@@ -31,8 +31,6 @@

 extern void omap3evm_flash_init(void);

-#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
-
 #define ONENAND_MAP		0x20000000

 #endif /* __ASM_ARCH_OMAP3_EVM_H */
