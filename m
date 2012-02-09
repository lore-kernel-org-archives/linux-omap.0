From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 13:44:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202091326500.6698@utopia.booyaka.com>
References: <20120208231551.GA9009@kroah.com> <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com> <20120209004731.GA11343@kroah.com> <4F3374F0.3080002@bitmer.com> <20120209133739.GB2590@sirena.org.uk> <20120209183624.GJ1426@atomide.com>
 <20120209192643.GL1426@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36706 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893Ab2BIUoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 15:44:32 -0500
In-Reply-To: <20120209192643.GL1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, 9 Feb 2012, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [120209 10:05]:
> > 
> > This fixes the various build and boot issues with custom .configs
> > that don't select CONFIG_MACH_OMAP_GENERIC. It should fix slow serial
> > console issues. And it fixes booting with DT to minimal enviroment.
> 
> Looks like the serial console is still insanely slow on 2420 both
> for dmesg.
> 
> On 2430, 3430, 3630 and 4430 it seems the problem with slow
> console is now fixed.
> 
> So at least one more patch is needed for the 2420 PM/serial regression.

Yeah, that one is PM related.  If mach-omap2/pm24xx.c is hacked to only 
enter MPU retention, rather than full chip retention, it works (quick hack 
below).  I suspect it is due to the lack of wakeup support in OMAP2 PM, 
but of course it could be something else.


- Paul

>From 98796ac6423302fdb56afa8a0a262fb09e27a1f6 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 9 Feb 2012 13:07:49 -0700
Subject: [PATCH] fix 2420 serial

---
 arch/arm/mach-omap2/pm24xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b8822f8..1f959e3 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -245,7 +245,7 @@ static void omap2_pm_idle(void)
 	if (omap_irq_pending())
 		goto out;
 
-	omap2_enter_full_retention();
+	omap2_enter_mpu_retention();
 
 out:
 	local_fiq_enable();
-- 
1.7.9

