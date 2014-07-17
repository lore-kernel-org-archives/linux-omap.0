From: mwelling <mwelling@emacinc.com>
Subject: AM3517 fails to boot 3.16-rc5 device tree kernel
Date: Thu, 17 Jul 2014 18:40:38 -0500
Message-ID: <20140717234037.GA9660@sysresccd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33544 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758651AbaGQXkl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 19:40:41 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so3913843iec.11
        for <linux-omap@vger.kernel.org>; Thu, 17 Jul 2014 16:40:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com

I am in the process of porting a device tree compatible version of the
linux kernel to a AM3517 based device.

First I tried 3.10.x and the device tree port appeared to be incomplete.
Neither the LCD or Ethernet were supported.

Next I tried 3.14.x and the Ethernet driver appeared to work but still
no LCD support.

Lastly I tried 3.16-rc5 and found that the kernel hangs in early boot
without any messages from the serial COM.

I was using the omap2plus_defconfig and the am3517-evm.dtb from each
kernel build. Is there any reason why the kernel would start hanging
with the newest release?

Are there any versions where the LCD output works?

Looking at the 3.16-rc5 test results just posted it is supposed to be working
but I have not been able to replicate this.

Any suggestions would be greatly appreciated.
