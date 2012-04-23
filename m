From: Ashwin Bihari <abihari@gmail.com>
Subject: DM3730 BSP issue with msleep()
Date: Mon, 23 Apr 2012 13:13:57 -0400
Message-ID: <CANLagX-mf7wsG+AR3mMb2TX=ZmJFkwi66Q2G9D-VqnbBAbFUdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56960 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab2DWRN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 13:13:57 -0400
Received: by vbbff1 with SMTP id ff1so8300104vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 10:13:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Greetings,

I'm trying to add support for our DM3730-based SOMs to the latest
Kernel and am basing my work on the latest and greatest Linux-next
(3.4.0-rc4-next-20120423-dirty currently) and am finding an
interesting issue with the use of msleep.

I'm trying to bring up a basic system with SD and Ethernet support for
starters, and am finding that the MMC detection code just hangs, after
some digging around I found the issue to be related to the use of
mmc_delay() calls which depending on the timeout required either uses
mdelay() or msleep(). All of the calls to mdelay() succeed, while the
msleep() call hangs.

Interestingly, msleep() is used in earlier
(arch/arm/mach-omap2)/board-* level files and that seems to function
properly.

I got around the mmc_delay() properly by using the change below (this
is only temporary), but I end up hanging somewhere farther along and
the last few lines are:

[    2.047088] twl_rtc twl_rtc: Power up reset detected.
[    2.052673] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.064331] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.073028] i2c /dev entries driver
[    2.080505] Driver for 1-wire Dallas network protocol.
[    2.091522] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    2.101043] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.107940] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.122222] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    2.382659] usbcore: registered new interface driver usbhid
[    2.388549] usbhid: USB HID core driver
[    2.392822] oprofile: hardware counters not available
[    2.398284] oprofile: using timer interrupt.
[    2.403961] TCP: cubic registered
[    2.407623] Initializing XFRM netlink socket
[    2.412506] NET: Registered protocol family 17
[    2.417388] NET: Registered protocol family 15
[    2.422821] Registering the dns_resolver key type
[    2.428222] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    2.436676] ThumbEE CPU extension supported.
[    2.493072] clock: disabling unused clocks to save power
[    2.545989] twl_rtc twl_rtc: setting system clock to 2000-01-01
00:00:00 UTC (946684800)
[    2.560760] Waiting for root device /dev/mmcblk0p2...
[    2.783111] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    2.794372] mmc0: new high speed SDHC card at address b368
[    2.814636] mmcblk0: mmc0:b368 00000 3.74 GiB
[    2.828704]  mmcblk0: p1 p2

Does anyone have any pointers for me to try out to see what's going on?

------------
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..7062f15 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -48,12 +48,16 @@ void mmc_power_off(struct mmc_host *host);

 static inline void mmc_delay(unsigned int ms)
 {
+       cond_resched();
+       mdelay(ms);
+#if 0
        if (ms < 1000 / HZ) {
                cond_resched();
                mdelay(ms);
        } else {
                msleep(ms);
        }
+#endif
 }

 void mmc_rescan(struct work_struct *work);


-- Ashwin
