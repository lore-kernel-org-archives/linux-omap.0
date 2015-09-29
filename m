From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/2] thermal: omap3 support
Date: Tue, 29 Sep 2015 14:19:10 -0700
Message-ID: <1443561552-23254-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: linux-omap@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-omap@vger.kernel.org

Folks,

I am add these two patches for next merge window. Pavels patch
was idling for some time in the mailing list and I found it
and gave it a try. In the process, added 36xx support too.

DTS part is not done though.

Anyways, they are in linux-next now. Have fun.

BR,

Eduardo Valentin (1):
  thermal: ti-soc-thermal: add OMAP36xx support

Pavel Machek (1):
  ti-soc-thermal: implement omap3 support

 .../devicetree/bindings/thermal/ti_soc_thermal.txt |  14 ++
 drivers/thermal/ti-soc-thermal/Kconfig             |  15 ++
 drivers/thermal/ti-soc-thermal/Makefile            |   1 +
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 176 +++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  14 ++
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  11 ++
 6 files changed, 231 insertions(+)
 create mode 100644 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c

-- 
2.5.0
