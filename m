From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [dspbridge] news: omap  mailbox implementation
Date: Tue, 23 Mar 2010 12:08:22 -0600
Message-ID: <1269367702-2589-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0CWRxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 13:53:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Shivananda Hebbar <x0hebbar@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Ernesto Ramos <ernesto@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ramesh Gupta G <grgupta@ti.com>, Mika Kukkonen <mika.kukkonen@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Nishanth Menon <nm@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, Rebecca Schultz Zavin <rebecca@android.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Hi All,

When updating the custom dspbridge mailbox functions with the ones
avaliable through omap mailbox (by pulling latest dspbridge),
PLEASE remember to enable omap mailbox through menuconfig:

make menuconfig

System Type  --->
    TI OMAP Implementations  --->
        <*> Mailbox framework support

otherwise, compilation will break like:

  Building modules, stage 2.
  MODPOST 7 modules
ERROR: "omap_mbox_msg_send" [drivers/dsp/bridge/bridgedriver.ko] undefined!
ERROR: "omap_mbox_put" [drivers/dsp/bridge/bridgedriver.ko] undefined!
ERROR: "omap_mbox_get" [drivers/dsp/bridge/bridgedriver.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [modules] Error 2

Regards,

Omar
