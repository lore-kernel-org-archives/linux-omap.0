From: Kovacs Peter Tamas <p.kovacs@holografika.com>
Subject: Enabling HSUSB1 port on OMAP3430 labrador
Date: Tue, 24 Nov 2009 15:33:56 +0100
Message-ID: <4B0BEED4.1060005@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail02d.mail.t-online.hu ([84.2.42.7]:57620 "EHLO
	mail02d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbZKXOlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 09:41:50 -0500
Received: from holoiroda.com (holoiroda.com [81.182.243.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail02d.mail.t-online.hu (Postfix) with ESMTPSA id E1201758B81
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 15:33:15 +0100 (CET)
Received: from adsl-2052.externet.hu ([212.40.118.18]:58231 helo=[192.168.10.121])
	by holoiroda.com with esmtpsa (Exim 4.69-NetSys #4)
	id 1NCwSm-0005eK-1T
	for linux-omap@vger.kernel.org; Tue, 24 Nov 2009 15:33:52 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear All,

We are trying to make the HSUSB1 port on the OMAP3430 work as an USB host.
To do that, an ISP1507A ULPI HighSpeed USB transceiver is connected to 
the HSUSB1pins (HSUSB1_STP, CLK, D-0..D7, DIR, NXT).

I have all these USB related kernel config options enabled:
USB_EHCI_HCD
USB_OHCI_HCD
USB_MUSB_HDRC
TWL4030_USB

My guess was that either EHCI or the Inventra should be the one enabling 
that USB port on the OMAP, but no luck.
The external USB port on the MDK works fine with this configuration.

The pin multiplexing configuration in the board file omap3430-labrador.c 
in u-boot also seems to be correct (although the config of USB1_STP 
seems to be strange, but changing that didn't work either).

My assumption is that the ISP1507A does not need support from the 
kernel, as it acts as an ULPI transceiver only, but please correct me on 
this point if wrong.

What happens is that after connecting an USB mouse is that the LED is on 
for a sec, but nothing is written in the kernel log.
We can see that the transceiver is generating a clock signal, but for 
some reason, the STP is constantly high.

I've also tried setting the port to PHY or TLL, but didn't help. I guess 
PHY is the correct setting in this situation, right? 

Note, the ISP1507A is connected to the following pins of the BGA:
HSUSB1_STP (AF10)
HSUSB1_CLK (AE10)
HSUSB1_DIR (AF9)
HSUSB1_NXP (AG9)
HSUSB1_D0 (AF11)
HSUSB1_D1 (AG12)
HSUSB1_D2 (AH12)
HSUSB1_D3 (AH14)
HSUSB1_D4 (AE11)
HSUSB1_D5 (AH9)
HSUSB1_D6 (AF13)
HSUSB1_D7 (AE13)

Any suggestion on making this work is greatly appreciated.

Thanks for your help,
Peter
