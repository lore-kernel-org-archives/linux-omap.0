From: John Faith <jfaith7@gmail.com>
Subject: Timeout after setting SD/MMC clock, bus width on 3530
Date: Tue, 6 Oct 2009 14:18:42 -0700
Message-ID: <e0727e900910061418g565c17d9te1277811e1be17e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:39096 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933204AbZJFVTT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 17:19:19 -0400
Received: by iwn8 with SMTP id 8so2491754iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 14:18:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I have a prototype board based on the 3530EVM which cannot read its
microSD card.  I enabled CONFIG_MMC_DEBUG and other printks to the
2.6.29rc3 kernel and can see that info like the transfer rate is
coming back but after I reach mmc_set_clock() and setting the bus
width, I just get timeouts (output below).

Looking at DAT0-3 on a scope, I see activity on DAT0, but the other
lines just follow the MMC power, up for ~800ms then off.

As an experiment, I tried commenting-out these 2 lines in
drivers/mmc/host/omap_hsmmc.c:
 mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
...
 mmc->caps |= MMC_CAP_4_BIT_DATA;

in an attempt to use slow, 1-wire transfers, but that got me a panic
in mmc_omap_irq().

Assuming the hardware is functioning, is there a way to force the SD
controller into its simplest/slowest mode to improve my chances of
reading the card?

Thanks!
,
John

...
mmc0: starting CMD9 arg 8fe40000 flags 00000007
MMC: IRQ Status is 1
drivers/mmc/core/sd.c 102 mmc_decode_csd() csd_struct=0
 tacc_ns=0
 tacc_clks=0
 max_dtr=25000000
 cmdclass=1461
 capacity=7744512
drivers/mmc/core/sd.c 67 mmc_decode_cid() manfid=3
 prod_name=SU04G
 card type=1
 card state=8
mmc0: starting CMD7 arg 8fe40000 flags 00000015
MMC: IRQ Status is 1
mmc0: starting CMD55 arg 8fe40000 flags 00000095
MMC: IRQ Status is 1
mmc0: starting CMD51 arg 00000000 flags 000000b5
MMC: IRQ Status is 3
drivers/mmc/core/sd.c 183 mmc_decode_scr()
mmc0: starting CMD6 arg 00fffff1 flags 000000b5
MMC: IRQ Status is 3
drivers/mmc/core/sd.c 261 mmc_switch_hs()
mmc0: starting CMD6 arg 80fffff1 flags 000000b5
MMC: IRQ Status is 3
card->csd.max_dtr=25000000
mmc_card_highspeed true
max_dtr=50000000
drivers/mmc/core/core.c:443 mmc_set_clock()
mmc_app_set_bus_width()
mmc_app_set_bus_width MMC_BUS_WIDTH_4
mmc0: starting CMD55 arg 8fe40000 flags 00000095
MMC: IRQ Status is 18000
mmc0: starting CMD55 arg 8fe40000 flags 00000095
drivers/mmc/host/omap_hsmmc.c 535
MMC: IRQ Status is 18000
mmc0: starting CMD55 arg 8fe40000 flags 00000095
MMC: IRQ Status is 18000
mmc0: starting CMD55 arg 8fe40000 flags 00000095
MMC: IRQ Status is 18000
drivers/mmc/core/sd.c 559 mmc_app_set_bus_width failed
mmc0: error -110 whilst initialising SD card
