From: John Faith <jfaith7@gmail.com>
Subject: TWL4030 backup battery charging in 2.6.32
Date: Thu, 24 Feb 2011 10:10:31 -0800
Message-ID: <AANLkTikaZTM1X=K=7RoArbiufG3Wu6SANPZD_oXn23sO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44650 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab1BXSKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 13:10:34 -0500
Received: by wyg36 with SMTP id 36so791783wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 10:10:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I have a TPS65920 (twl4030) power chip on an omap3530 board I would
like to use to charge a small backup battery to keep the RTC happy.
I've run across patches adding drivers/power/twl4030_bci_battery.c
which seems to do what I want (sets the twl4030 BB_CFG register's
BBCHEN bit), but the driver probe() complains after platform_get_irq()
returns -6 (ENXIO).  I assume that platform interrupt resources need
to be added in my board code.

I know this file has been removed, but is there an example of setting
up interrupts for this driver or a description of how twl4030
interrupts should be set up in board code?  It seems that newer code
like board-omap3pandora.c just sets ".bci = &pandora_bci_data" instead
of explicit charger interrupts.

Thanks,
John
