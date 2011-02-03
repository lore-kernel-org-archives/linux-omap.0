From: Adam Wozniak <awozniak@irobot.com>
Subject: spin_lock_irqsave and ISP interrupts on OMAP 3530
Date: Thu, 03 Feb 2011 08:31:51 -0800
Message-ID: <4D4AD877.8070702@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.irobot.com ([206.83.81.187]:24300 "EHLO smtp1.irobot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756002Ab1BCQrL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 11:47:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm hoping I'm just not understanding something and this isn't as broke 
as I fear it is.

I'm using the ISP on an OMAP3530, linux 2.6.32.  I've got some kernel 
code I want to lock in both the process context and the ISP interrupt 
context, so I'm using a spinlock.  As I understand it, locking the 
spinlock should disable all interrupts.  However, I'm still seeing the 
ISP interrupt happen when I've got the spinlock locked in the process 
context.

i.e. somewhere I've got the code below, and my Warning is tripping.  Is 
this broken, or am I not understanding something?

int am_i_locked = 0;
spinlock_t my_spinlock = SPIN_LOCK_UNLOCKED;

void foo(void) {
     /* function could be called from process context, or could be 
called from omap34xx_isp_isr (interrupt context) */
     unsigned long flags;
     spin_lock_irqsave(&my_spinlock, flags);
     WARN_ON(am_i_locked);
     am_i_locked++;

     /* do some stuff */

     am_i_locked--;
     spin_unlock_irqrestore(&my_spinlock, flags);
}
