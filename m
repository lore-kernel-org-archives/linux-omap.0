From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Thu, 10 May 2012 23:36:48 +0200
Message-ID: <2430095.tlzScq1o2g@acer>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57361 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761106Ab2EJVgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 17:36:55 -0400
Received: by weyu7 with SMTP id u7so10538wey.19
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 14:36:54 -0700 (PDT)
In-Reply-To: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Dnia czwartek, 3 maja 2012 13:28:58 Vaibhav Hiremath pisze:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
> 
> This patch series cleans up the existing 32k-sync timer 
implementation,
> movind SoC init code to respective files (mach-omap1/timer32k.c and
> mach-omap2/timer.c) and uses kernel parameter to override the default
> clocksource of "counter_32k", also in order to support some OMAP based
> derivative SoCs like AM33XX which doesn't have 32K sync-timer hardware 
IP,
> adds hwmod lookup for omap2+ devices, and if lookup fails then
> fall back to gp-timer.
> 
> if(use_gptimer_clksrc == true)
> 	gptimer clocksource init;
> else if (counter_32 init == false)
> 	/* Fallback to gptimer */
> 	gptimer clocksource init(;
> 
> With this, we should be able to support multi-omap boot
> including devices with/without 32k-sync timer.
> 
> This patch-series has been boot tested on AM37xEVM platform, it
> would be helpful if somebody help me to validate it on OMAP1/2
> platforms.
> 
> The patches are also available at (based on linux-omap/master) -
> https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup

Tried to test this branch, merged into 3.4-rc6, and with my Amstrad 
Delta fixes applied, using my custom Amstrad Delta config, but initially 
failed because an unrelated issue rised to the surface:

|   LD      .tmp_vmlinux1
| arch/arm/mach-omap1/built-in.o: In function `omap1_usb_init':
| lcd_dma.c:(.init.text+0x1420): undefined reference to `ocpi_enable'
| make: *** [.tmp_vmlinux1] Error 1

Apparently introduced with commit 
d3645d39ad0ed9f09535065676ea0ba114f93cdf, "ARM: OMAP1: OHCI: use 
platform_data fn ptr to enable OCPI bus", looks like one or more symbols 
exported by the not linked in arch/arm/mach-omap1/ocpi.o may be missing 
for non-OMAP16xx configs.

Otherwise, if configured with OMAP16xx selected, builds and seems to work 
correctly for me, to the extent possible to verify without physical 
access to the hardware. However, please note that the Amstrad Delta 
doesn't make use of the 32k timer, only mpu_timer.

Thanks,
Janusz
