From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP1: unnecessary timer interrupt handler code?
Date: Sun, 8 May 2011 17:28:00 +0100
Message-ID: <20110508162800.GM27807@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34885 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab1EHQ2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 May 2011 12:28:06 -0400
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1QJ6pu-00040X-Cb
	for linux-omap@vger.kernel.org; Sun, 08 May 2011 17:28:02 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1QJ6pt-0000gb-69
	for linux-omap@vger.kernel.org; Sun, 08 May 2011 17:28:01 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

MPU timer 2 is used on OMAP1 for the clock source and scheduler clock.
It registers an interrupt, which counts the number of overflows of
this timer.  However, this counter is only referenced by the interrupt
handler.

So, it seems that the following code serves very little purpose.  Can
it be simply deleted?

static unsigned long omap_mpu_timer2_overflows;

static irqreturn_t omap_mpu_timer2_interrupt(int irq, void *dev_id)
{
        omap_mpu_timer2_overflows++;
        return IRQ_HANDLED;
}

static struct irqaction omap_mpu_timer2_irq = {
        .name           = "mpu_timer2",
        .flags          = IRQF_DISABLED,
        .handler        = omap_mpu_timer2_interrupt,
};

...
static void __init omap_init_clocksource(unsigned long rate)
{
...
        setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
...
}
