From: "S, Venkatraman" <svenkatr@ti.com>
Subject: build error: omap_ctrl_readl and omap_ctrl_writel undefined
Date: Thu, 30 Sep 2010 08:24:25 +0530
Message-ID: <AANLkTi=CpxF4S1SdbF6rcGgWPZczFEcuHQrLgbMyskGh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40483 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753077Ab0I3DAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Sep 2010 23:00:51 -0400
Received: by mail-yx0-f179.google.com with SMTP id 4so936888yxj.10
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 20:00:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com

I am trying to build the master branch on linux-omap and I am getting
the following error on 'make modules'

Git log:

2365f1f | Wed, 29 Sep 2010 11:19:10 -0700 | Tony Lindgren | Linux-omap
rebuilt: Updated to v2.6.36-rc6, merged in few more patches
acc012f | Wed, 29 Sep 2010 11:19:00 -0700 | Tony Lindgren | Merge for-next
11f4559 | Wed, 29 Sep 2010 11:18:58 -0700 | Tony Lindgren | Merge omap-testing
03d0fcb | Wed, 29 Sep 2010 11:18:56 -0700 | Tony Lindgren | Merge omap-fixes
cddb52c | Wed, 29 Sep 2010 11:18:54 -0700 | Tony Lindgren | Merge cbu

Build error:
  LD [M]  net/wireless/cfg80211.o
  CC [M]  net/wireless/lib80211.o
ERROR: "omap_ctrl_writel" [sound/soc/omap/snd-soc-omap-mcbsp.ko] undefined!
ERROR: "omap_ctrl_readl" [sound/soc/omap/snd-soc-omap-mcbsp.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Regards,
Venkat.
