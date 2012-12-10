From: Jack Mitchell <ml@communistcode.co.uk>
Subject: AM335x BeagleBone SPI Issues
Date: Mon, 10 Dec 2012 13:17:36 +0000
Message-ID: <50C5E0F0.4030306@communistcode.co.uk>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:42018 "EHLO eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab2LJNVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 08:21:32 -0500
Received: from localhost ([127.0.0.1]:35314 helo=eumx.net)
	by eumx.net with esmtp (Exim 4.72)
	(envelope-from <ml@communistcode.co.uk>)
	id 1Ti3CX-0007a7-Ko
	for linux-omap@vger.kernel.org; Mon, 10 Dec 2012 13:15:17 +0000
Received: from [195.171.99.130] (port=56624 helo=[192.168.0.54])
	by eumx.net with esmtpa (Exim 4.72)
	(envelope-from <ml@communistcode.co.uk>)
	id 1Ti3CX-0007a3-IV
	for linux-omap@vger.kernel.org; Mon, 10 Dec 2012 13:15:17 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am currently having issues with the SPI driver on the beaglebone using 
the 3.7-rc8 kernel[1]. I have probed the SPI pins and I have found that 
writing works however reading doesn't. When using DMA the program seems 
to lock hard and no data is sent on the bus. I am testing the bus using 
spidev and the spidev_test[2] application, however I first came across 
spi issues with a custom spi driver which stopped working when I 
transitioned from 3.2-psp to 3.7-rc8.

The current output I am seeing from the spidev_test program is just a 
series of 0x00 data, which looks to me like no data is getting in at 
all. The spidev_test program is not using DMA as the buffer size is too 
low, so I forced the dma on when buffer size is > 1 and the program 
hangs hard with the system still responding to other commands.I have 
briged the pins 18 and 21 on the BeagleBone P9 header.

Has anyone seen issues like this, or if not if someone could please test 
the latest 3.7-rc8 from [1] and let me know if it works for them and the 
issue is at my end.

To get spidev working with devicetree I applied the patch from [3] and 
changed the dtb as in the patch pasted below.

[1] https://github.com/beagleboard/kernel/tree/3.7
[2] http://lxr.linux.no/#linux+v3.6.9/Documentation/spi/spidev_test.c
[3] 
http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg09958.html

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi 
b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 543365d..8fff665 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -440,10 +440,19 @@
  };

  &spi0 {
+  status = "okay";
         pinctrl-names = "default";
         pinctrl-0 = <&spi0_pins>;
+
+  spidev: spidev@0 {
+  compatible = "linux,spidev";
+  reg = <0>;
+  spi-max-frequency = <24000000>;
+  };
+
  };

+
  &spi1 {
         pinctrl-names = "default";
         pinctrl-0 = <&spi1_pins>;


-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--

