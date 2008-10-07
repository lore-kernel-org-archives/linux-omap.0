From: David Brownell <david-b@pacbell.net>
Subject: Re: kernel oops for 3430sdp
Date: Tue, 7 Oct 2008 11:28:52 -0700
Message-ID: <200810071128.52889.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:47813 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753163AbYJGS2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 14:28:54 -0400
In-Reply-To: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 07 October 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000

Did you try with the hack I've sent, to work around one problematic
(and surprisingly reproducible!) i2c-omap timeout?  Appended.

Given I2C faults, many things blow up rudely ... hardly any I2C
drivers are written to tolerate transfer errors.  Not entirely
unreasonably, since such errors are otherwise quite rare.


I currently suspect there's an issue where the i2c-omap code can
handle a bunch of requests that group closely together ... or are
separated by a lot of time ... but there's some middle ground
where if you wait the "right" amount of time before making the
next request, it times out instead of working correctly.

I have no proof behind that theory, but it does seem to match up
to a few of the observed facts.  Notably that the i2c timeouts
appear when the only device on that bus is the TWL4030, and the
drivers make known-to-be-valid requets ... the timeouts started
to appear only after some trivial changes in init timings, which
were caused by moving code out of drivers/i2c into directories
that are more appropriate.

- Dave


---
 drivers/i2c/chips/twl4030-pwrirq.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/i2c/chips/twl4030-pwrirq.c
+++ b/drivers/i2c/chips/twl4030-pwrirq.c
@@ -161,6 +161,8 @@ static int twl4030_pwrirq_thread(void *d
 	return 0;
 }
 
+#include <linux/delay.h>
+
 static int __init twl4030_pwrirq_init(void)
 {
 	int i, err;
@@ -168,8 +170,16 @@ static int __init twl4030_pwrirq_init(vo
 	twl4030_pwrirq_mask = 0xff;
 	twl4030_pwrirq_pending_unmask = 0;
 
+/* HEY:  core already did this.
+ * But that's surely not why we
+ * sometimes see timeouts here ...
+ */
+for (i = 0; i < 5; i++) {
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
 					TWL4030_INT_PWR_IMR1);
+if (!err) break;
+msleep(10);
+}
 	if (err)
 		return err;
 

