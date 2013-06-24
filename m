From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: MMC breakage on 3.11/cleanup
Date: Mon, 24 Jun 2013 17:27:43 -0500
Message-ID: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:44239 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3FXW1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 18:27:43 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so11245946obc.24
        for <linux-omap@vger.kernel.org>; Mon, 24 Jun 2013 15:27:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Tony,

Following branch breaks MMC for me on am33xx (beaglebone):
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.11/cleanup

I tried to work around it by specifying interrupt and reg property in DT:
      mmc1: mmc@48060000 {
         compatible = "ti,omap3-hsmmc";
         ti,hwmods = "mmc1";
         ti,dual-volt;
         ti,needs-special-reset;
         dmas = <&edma 24
            &edma 25>;
         dma-names = "tx", "rx";
         interrupts = <64>;
         interrupt-parent = <&intc>;
         reg = <0x48060000 0x1000>;
         status = "disabled";
      };

The probe succeeds but I still get a "Waiting for root device
/dev/mmcblk0p2" when booting over MMC.

If you're planning to push the cleanup branch, can we temporarily add
the hwmod data back while we work on this issue so that upstream MMC
is kept working.

Thanks,

-Joel
