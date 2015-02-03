From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: device tree entry for PRM_RTSTIME
Date: Tue, 3 Feb 2015 10:07:45 +0100
Message-ID: <CAGm1_kuxiM7TCOEj_Crv-U49+GwtF=3==VokPnW_6xBDjuCNog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42635 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbBCJIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 04:08:06 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so93755688pab.12
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2015 01:08:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I need to change the reset length. This is not a problem via "devmem
0x44e00f04 32 0x000010ff", but I would like to specify this in DTS
file.

So far I could find these macros, but they seem not be used anywhere:

arch/arm/mach-omap2/prm33xx.h:#define AM33XX_PRM_RSTTIME_OFFSET         0x0004
arch/arm/mach-omap2/prm33xx.h:#define AM33XX_PRM_RSTTIME
         AM33XX_PRM_REGADDR(AM33XX_PRM_DEVICE_MOD, 0x0004)

What be an appropriate place to handle this register?

Yegor
