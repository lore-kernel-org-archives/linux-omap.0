From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: Re: patch: add omap730 / omap850 rtc support
Date: Wed, 14 Oct 2009 16:09:42 +0200
Message-ID: <3ea34a000910140709s42220097n7d08a6a90e7ddd8d@mail.gmail.com>
References: <3ea34a000910130433i36a3ac7esc6b8e7c6588185f4@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF600@dbde02.ent.ti.com>
	 <3ea34a000910140126p3352a5aej50300a39521f1128@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF6EE@dbde02.ent.ti.com>
	 <3ea34a000910140627w53dffe59l977a78b866c50d8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:65118 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbZJNOKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 10:10:18 -0400
Received: by gxk4 with SMTP id 4so11982762gxk.8
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 07:09:42 -0700 (PDT)
In-Reply-To: <3ea34a000910140627w53dffe59l977a78b866c50d8a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I decided on using 31 because

=================================================================
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0587d53..cc25f4f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>

 #include <asm/io.h>
+#include <mach/cpu.h>


 /* The OMAP1 RTC is a year/month/day/hours/minutes/seconds BCD clock
@@ -40,28 +41,28 @@
 #define OMAP_RTC_BASE			0xfffb4800

 /* RTC registers */
-#define OMAP_RTC_SECONDS_REG		0x00
-#define OMAP_RTC_MINUTES_REG		0x04
-#define OMAP_RTC_HOURS_REG		0x08
-#define OMAP_RTC_DAYS_REG		0x0C
-#define OMAP_RTC_MONTHS_REG		0x10
-#define OMAP_RTC_YEARS_REG		0x14
-#define OMAP_RTC_WEEKS_REG		0x18
-
-#define OMAP_RTC_ALARM_SECONDS_REG	0x20
-#define OMAP_RTC_ALARM_MINUTES_REG	0x24
-#define OMAP_RTC_ALARM_HOURS_REG	0x28
-#define OMAP_RTC_ALARM_DAYS_REG		0x2c
-#define OMAP_RTC_ALARM_MONTHS_REG	0x30
-#define OMAP_RTC_ALARM_YEARS_REG	0x34
-
-#define OMAP_RTC_CTRL_REG		0x40
-#define OMAP_RTC_STATUS_REG		0x44
-#define OMAP_RTC_INTERRUPTS_REG		0x48
-
-#define OMAP_RTC_COMP_LSB_REG		0x4c
-#define OMAP_RTC_COMP_MSB_REG		0x50
-#define OMAP_RTC_OSC_REG		0x54
+#define OMAP_RTC_SECONDS_REG			0x00
+#define OMAP_RTC_MINUTES_REG			0x01
+#define OMAP_RTC_HOURS_REG				0x02
+#define OMAP_RTC_DAYS_REG				0x03
+#define OMAP_RTC_MONTHS_REG				0x04
+#define OMAP_RTC_YEARS_REG				0x05
+#define OMAP_RTC_WEEKS_REG				0x06
+
+#define OMAP_RTC_ALARM_SECONDS_REG		0x08
+#define OMAP_RTC_ALARM_MINUTES_REG		0x09
+#define OMAP_RTC_ALARM_HOURS_REG		0x0a
+#define OMAP_RTC_ALARM_DAYS_REG			0x0b
+#define OMAP_RTC_ALARM_MONTHS_REG		0x0c
+#define OMAP_RTC_ALARM_YEARS_REG		0x0d
+
+#define OMAP_RTC_CTRL_REG				0x10
+#define OMAP_RTC_STATUS_REG				0x11
+#define OMAP_RTC_INTERRUPTS_REG			0x12
+
+#define OMAP_RTC_COMP_LSB_REG			0x13
+#define OMAP_RTC_COMP_MSB_REG			0x14
+#define OMAP_RTC_OSC_REG				0x15

 /* OMAP_RTC_CTRL_REG bit fields: */
 #define OMAP_RTC_CTRL_SPLIT		(1<<7)
@@ -87,10 +88,12 @@
 #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
 #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)

+#define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)

-#define rtc_read(addr)		omap_readb(OMAP_RTC_BASE + (addr))
-#define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE + (addr))
-
+#define rtc_read(reg) \
+	omap_readb(       OMAP_RTC_BASE + OMAP_RTC_REGISTER_SIZE * reg )
+#define rtc_write(val,reg) \
+	omap_writeb( val, OMAP_RTC_BASE + OMAP_RTC_REGISTER_SIZE * reg )

 /* we rely on the rtc framework to handle locking (rtc->ops_lock),
  * so the only other requirement is that register accesses which
@@ -102,7 +105,7 @@ static void rtc_wait_not_busy(void)
 	u8	status;

 	/* BUSY may stay active for 1/32768 second (~30 usec) */
-	for (count = 0; count < 50; count++) {
+	for (count = 0; count < 31; count++) {
 		status = rtc_read(OMAP_RTC_STATUS_REG);
 		if ((status & (u8)OMAP_RTC_STATUS_BUSY) == 0)
 			break;
