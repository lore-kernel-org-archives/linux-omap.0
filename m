From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Please fix lcd_sx1.c
Date: Sun, 23 Nov 2008 16:46:18 +0000
Message-ID: <20081123164618.GA17438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47577 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYKWQq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Nov 2008 11:46:27 -0500
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1L4I6H-0007zA-M1
	for linux-omap@vger.kernel.org; Sun, 23 Nov 2008 16:46:22 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

kautobuild is reporting this error against sx1_defconfig:

drivers/video/omap/lcd_sx1.c: In function 'epson_sendbyte':
drivers/video/omap/lcd_sx1.c:90: error: implicit declaration of function 'OMAP_MCBSP_WRITE'
drivers/video/omap/lcd_sx1.c:90: error: 'PCR0' undeclared (first use in this function)
drivers/video/omap/lcd_sx1.c:90: error: (Each undeclared identifier is reported only once
drivers/video/omap/lcd_sx1.c:90: error: for each function it appears in.)
make[3]: *** [drivers/video/omap/lcd_sx1.o] Error 1

Some comments on this:

1. Unused definitions:

#define GPIO_DATA_INPUT         0xfffce000
#define GPIO_DATA_OUTPUT        0xfffce004
#define GPIO_DIR_CONTROL        0xfffce008
#define GPIO_INT_CONTROL        0xfffce00c
#define GPIO_INT_MASK           0xfffce010
#define GPIO_INT_STATUS         0xfffce014
#define GPIO_PIN_CONTROL        0xfffce018
...
#define DSP_REG         0xE1017024

2. Interferes with MCBSP3 by writing direct to the control register.
   What if someone else is using MCBSP3?

        OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2200);
        OMAP_MCBSP_WRITE(OMAP1510_MCBSP3_BASE, PCR0, 0x2202);

   Besides, these aren't available for this driver (and quite
   rightfully so.)

3. doesn't check the omap_mcbsp_request() return value:

        omap_mcbsp_request(OMAP_MCBSP3);

4. doesn't check the return code from gpio_request():

        gpio_request(A_LCD_SSC_RD, "lcd_ssc_rd");
        gpio_request(A_LCD_SSC_SD, "lcd_ssc_sd");
        gpio_request(_A_LCD_RESET, "lcd_reset");
        gpio_request(_A_LCD_SSC_CS, "lcd_ssc_cs");
        gpio_request(_A_LCD_SSC_A0, "lcd_ssc_a0");

To me, it looks like this driver was tossed over into mainline without
any thought - it has never been in a buildable state.  Please fix or
remove this driver from mainline.
