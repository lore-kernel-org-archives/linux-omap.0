From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: debug needed: twl4030 RTC wakeups: repeated attempts fail on Beagle
Date: Wed, 22 Aug 2012 20:36:31 +0530
Message-ID: <CANQgH-a9uiaUnR+G2Y_zzvvS3+Yh-O3b-afkZDsNkQFBWNN+9g@mail.gmail.com>
References: <87d32yd1l4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:34717 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932736Ab2HVPGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 11:06:38 -0400
Received: by vcbfl13 with SMTP id fl13so1208589vcb.36
        for <linux-omap@vger.kernel.org>; Wed, 22 Aug 2012 08:06:31 -0700 (PDT)
In-Reply-To: <87d32yd1l4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Russ Dill <russ.dill@gmail.com>

On Sat, Aug 11, 2012 at 12:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hello,
>
> In doing some automated testing of suspend/resume I noticed that
> repeated attempts to suspend and resume via RTC wakeup fail on
> 3530/Beagle and 3730/Beagle-xM, but work fine on 3430/n900, 3530/Overo,
> 3730/OveroSTORM and 4430/Panda.
>
> When RTC wakeup fails, a UART wakeup will work, and in the logs, you'll
> see this:
>
> [  316.036132] twl: i2c_read failed to transfer all messages
> [  316.036163] twl4030: I2C error -13 reading PIH ISR

The  error value is is propagated from the i2c get_sync failure.

>
> My guess about what might be happening is that very late in the suspend
> process (during the noirq hooks), a PMIC interrupt fires, but by this
> time the I2C driver is runtime suspended (and clock gated.)  Since
> runtime PM is disabled at this point, I2C reads fail, so the twl4030 IRQ
> driver cannot talk over I2C to the PMIC to determine the interrupt
> source.

Agreed.

>
> The real mystery is why this happens on Beagle and Beagle-xM, but none
> of the other OMAP3 boards (at least the ones I have.)

Looks like some  race/ timing issue.
However I am not sure what is a good way to synchronise the i2c
requests from a client from an isr and
the device disable / runtime resumed.

However on merging the clean up series

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg73870.html

Didn't see the above mentioned issue.

but there were some error's like timeout.

This may be because the controller was not fully enabled.

SYSC in case of I2C not only reflects the reset status from sysc
reset( register is reset)
but also controller enable ( controller reset ).

On checking the reset after controller didnt see the time out issue.

patch below.



diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9aefd36..b35afa4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1254,6 +1254,7 @@ static int omap_i2c_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	unsigned long timeout = 10000;

 	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
@@ -1266,6 +1267,15 @@ static int omap_i2c_runtime_resume(struct device *dev)
 		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}

+	while (!(omap_i2c_read_reg(_dev, OMAP_I2C_SYSS_REG) &
+			SYSS_RESETDONE_MASK)) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(dev, "timeout waiting for controller reset\n");
+				return -ETIMEDOUT;
+		}
+		msleep(1);
+	}
+
 	/*
 	 * Don't write to this register if the IE state is 0 as it can
 	 * cause deadlock.

>
> Reproducing is easy.  Simply run rtcwake in a loop:
>
>   # while true; do rtcwake -m mem -s 1; done
>
> In my tests, this happens using omap2plus_defconfig (+ initramfs) on
> v3.6-rc1, v3.5, v3.4, v3.3 but seems to work fine on v3.2.
>
> I'm going on vacation for a few weeks, so any help debugging this would
> be greatly appreciated.
>
> Thanks,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
