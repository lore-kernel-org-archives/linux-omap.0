From: Frank Agius <ftagius@yahoo.com>
Subject: ADC timeout on Overo
Date: Tue, 30 Dec 2008 16:29:02 -0500
Message-ID: <gje3o3$gmr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51216 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbYL3VzG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Dec 2008 16:55:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LHmYJ-00044l-1B
	for linux-omap@vger.kernel.org; Tue, 30 Dec 2008 21:55:03 +0000
Received: from static-71-111-254-119.rlghnc.dsl-w.verizon.net ([71.111.254.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 30 Dec 2008 21:55:03 +0000
Received: from ftagius by static-71-111-254-119.rlghnc.dsl-w.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 30 Dec 2008 21:55:03 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to enable ADC measurements on an Overo/Summit system running 
Linux 2.6.28.  I started with a fresh git pull of 2.6.28.  I added what 
I thought was the appropriate code to the Overo specific initialization:

--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -152,6 +152,10 @@ static struct twl4030_gpio_platform_data 
overo_gpio_data =
         .irq_end        = TWL4030_GPIO_IRQ_END,
  };

+static struct twl4030_madc_platform_data overo_madc_data = {
+       .irq_line       = 1,
+};
+
  static struct twl4030_usb_data overo_usb_data = {
         .usb_mode       = T2_USB_MODE_ULPI,
  };
@@ -162,6 +166,7 @@ static struct twl4030_platform_data overo_twldata = {
         .gpio           = &overo_gpio_data,
         .usb            = &overo_usb_data,
         .power          = GENERIC3430_T2SCRIPTS_DATA,
+        .madc           = &overo_madc_data,
  };

I built the kernel and the MADC driver module (twl4030-madc.ko).  After 
inserting the module, the file twl4030-madc showed up in /dev.  So far, 
so good.  I coded a small user space application that issued a raw read 
ioctl for adc channel 3.  The read timed out, as did reads for all other 
channels I tried.  I did some preliminary debug of the driver and found 
that the reason for the failure is that once the ADC conversion starts, 
the EOC_SW1 bit in the CTRL_SW1 register (the indicator of completion) 
never goes to 1.  Further debug shows that in the module initialization 
routine twl4030_madc_set_power, as soon as the MADC is powered on by 
setting CTRL1[0] MADCON bit to 1, the BUSY bit of CTRL_SW1 turns on and 
never turns off.  I'm guessing this constant state of busy is why the 
conversion never completes. This leads me to believe that the MADC is 
not set up properly. Steve Sakoman confirmed that the HFCLKIN signal is 
26 MHz for the Overo, so it does not look like a clock setup problem. 
Any ideas as to why the BUSY bit comes on and never turns off? Any other 
ideas?

regards,
frank

