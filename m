From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RESEND] [PATCH 3.6.0- 0/6] ARM: use module_platform_driver macro
Date: Fri, 12 Oct 2012 08:09:36 +0100
Message-ID: <1350025776-30037-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:33219 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756232Ab2JLHNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Oct 2012 03:13:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, rnayak@ti.com
Cc: srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Running Coccinelle lookup pattern like below on the 
latest kernel showed about 52 hits. This patch series is a subset 
of those 52 patches, so that it will be easy for maintainers to review.

@  @
- initfunc(void)
- { return platform_driver_register(&dr); }

...

- module_init(initfunc);
...

- exitfunc(void)
- { platform_driver_unregister(&dr); }

...

- module_exit(exitfunc);
+ module_platform_driver(dr); 

Srinivas Kandagatla (6):
  ARM/omap1: use module_platform_driver macro
  ARM/omap2: use module_platform_driver macro
  ARM/pxa: use module_platform_driver macro
  ARM/pxa: use module_platform_driver macro
  ARM/omap: use module_platform_driver macro
  omap_rng: use module_platform_driver macro

 arch/arm/mach-omap1/mailbox.c     |   14 +-------------
 arch/arm/mach-omap2/mailbox.c     |   14 +-------------
 arch/arm/mach-pxa/pxa3xx-ulpi.c   |   13 +------------
 arch/arm/mach-pxa/tosa-bt.c       |   15 +--------------
 arch/arm/plat-omap/dmtimer.c      |   13 +------------
 drivers/char/hw_random/omap-rng.c |   14 +-------------
 6 files changed, 6 insertions(+), 77 deletions(-)

