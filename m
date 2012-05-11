From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
Date: Fri, 11 May 2012 06:57:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA221E8@DBDE01.ent.ti.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
 <2430095.tlzScq1o2g@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114Ab2EKG5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 02:57:38 -0400
In-Reply-To: <2430095.tlzScq1o2g@acer>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 11, 2012 at 03:06:48, Janusz Krzysztofik wrote:
> Dnia czwartek, 3 maja 2012 13:28:58 Vaibhav Hiremath pisze:
> > Current OMAP code supports couple of clocksource options based
> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
> > 
> > This patch series cleans up the existing 32k-sync timer 
> implementation,
> > movind SoC init code to respective files (mach-omap1/timer32k.c and
> > mach-omap2/timer.c) and uses kernel parameter to override the default
> > clocksource of "counter_32k", also in order to support some OMAP based
> > derivative SoCs like AM33XX which doesn't have 32K sync-timer hardware 
> IP,
> > adds hwmod lookup for omap2+ devices, and if lookup fails then
> > fall back to gp-timer.
> > 
> > if(use_gptimer_clksrc == true)
> > 	gptimer clocksource init;
> > else if (counter_32 init == false)
> > 	/* Fallback to gptimer */
> > 	gptimer clocksource init(;
> > 
> > With this, we should be able to support multi-omap boot
> > including devices with/without 32k-sync timer.
> > 
> > This patch-series has been boot tested on AM37xEVM platform, it
> > would be helpful if somebody help me to validate it on OMAP1/2
> > platforms.
> > 
> > The patches are also available at (based on linux-omap/master) -
> > https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup
> 
> Tried to test this branch, merged into 3.4-rc6, and with my Amstrad 
> Delta fixes applied, using my custom Amstrad Delta config, but initially 
> failed because an unrelated issue rised to the surface:
> 
> |   LD      .tmp_vmlinux1
> | arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
> | lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
> | make: *** [.tmp_vmlinux1] Error 1
> 
> Apparently introduced with commit 
> d3645d39ad0ed9f09535065676ea0ba114f93cdf, "ARM: OMAP1: OHCI: use 
> platform_data fn ptr to enable OCPI bus", looks like one or more symbols 
> exported by the not linked in arch/arm/mach-omap1/ocpi.o may be missing 
> for non-OMAP16xx configs.
> 
> Otherwise, if configured with OMAP16xx selected, builds and seems to work 
> correctly for me, to the extent possible to verify without physical 
> access to the hardware. However, please note that the Amstrad Delta 
> doesn't make use of the 32k timer, only mpu_timer.
> 

Thanks Janusz for validating this, really appreciate your help here.

Thanks,
Vaibhav

