From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: TWL-rtc on 4430sdp doesn't work?
Date: Sat, 8 Jan 2011 23:59:58 +0000
Message-ID: <20110108235958.GY1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40764 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab1AIAAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jan 2011 19:00:06 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PbihU-0002gs-U6
	for linux-omap@vger.kernel.org; Sun, 09 Jan 2011 00:00:01 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PbihT-0006Jp-Ej
	for linux-omap@vger.kernel.org; Sat, 08 Jan 2011 23:59:59 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP4.  This is with a kernel built pre-OMAP merge.  On boot:

i2c_omap i2c_omap.1: bus 1 rev4.0 at 400 kHz
Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl6030: PIH (irq 39) chaining IRQs 368..387
...
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
twl_rtc twl_rtc: hctosys: invalid date/time
...
lm75 3-0048: hwmon0: sensor 'tmp105'
i2c_omap i2c_omap.1: controller timed out
i2c_omap i2c_omap.1: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.2: controller timed out
i2c_omap i2c_omap.3: controller timed out
i2c_omap i2c_omap.3: controller timed out
i2c_omap i2c_omap.3: controller timed out
i2c_omap i2c_omap.4: controller timed out
i2c_omap i2c_omap.4: controller timed out
i2c_omap i2c_omap.4: controller timed out
i2c_omap i2c_omap.4: controller timed out


# date
Sat Jan  8 23:38:55 GMT 2011
# strace -e ioctl,open,close hwclock -uw
...
open("/dev/rtc", O_WRONLY|O_LARGEFILE)  = 3
ioctl(3, RTC_SET_TIME, {tm_sec=16, tm_min=39, tm_hour=23, tm_mday=8, tm_mon=0, tm_year=111, ...}) = 0
close(3)                                = 0
# strace -e ioctl,open,close hwclock
...
open("/dev/rtc", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, RTC_RD_TIME, {tm_sec=51, tm_min=165, tm_hour=165, tm_mday=165, tm_mon=164, tm_year=265, ...}) = 0

Thu Jan  1 00:59:59 1970  0.000000 seconds

So, the TWL-rtc isn't updating as a result of RTC_SET_TIME, neither is it
saying that it didn't update nor why it didn't update.  Nothing in the
kernel log either to suggest what's going on.

I've also seen cases where tm_sec has gone 04 01 00 over subsequent reads
within 10 seconds - seconds going backwards doesn't look right.

Any ideas what's going on?
