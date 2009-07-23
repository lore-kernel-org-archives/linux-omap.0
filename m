From: Peter Barada <peterb@logicpd.com>
Subject: OMAP PM question
Date: Thu, 23 Jul 2009 14:22:57 -0400
Message-ID: <1248373377.891.17.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:31624 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752168AbZGWSTm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jul 2009 14:19:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Kevin,

I'm trying to port over the 2.6.30 OMAP PM branch on Logic's SOM, pulled
from just a few days ago before the rebase to 2.6.31-rc1:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=e0cffc298098263630b83c458b8fce754badb9a3

Unfortunately It doesn't go into retention due to MPU_CLK being defined
as "virt_pcrm_set" where no virt_pcrm_set exists for OMAP3.  Once I
changed MPU_CLK to "arm_fck" for OMAP3 as suggested by Rajendra in
http://patchwork.kernel.org/patch/18626/  the board goes  into
retention, but it won't resume on a serial RX event.  I wonder if
Rajendra's change is correct.

1) Which config did you use on the PM tree in the 2.6.30 timeframe so
can start over from a known config/board description (that goes into
retention and comes back out) instead of what I rolled from the rx51 for
Logic's OMAP35x SOM.  Looking in arch/arm/configs, the only omap3 config
that has CONFIG_PM=y is for the evm.  Is this the one?

2) Is there anything special necessary to have a serial RX event force a
wakeup?

3) Do you have a wake-on-timer patch that works in this tree?

4) I've noticed the board hangs after a while of inactivity on the
serial power - I've tried cranking up the DEFAULT_TIMEOUT in
arch/arm/mach-omap2/serial.c to (50 * HZ), and then disabling the
timeout by "echo 0 > /sys/devices/platform/serial/8250.0/sleep_timeout",
but the hang still happens after a period of inactivity - characters
typed at ttyS0 don't get echoed back.  How do I enable wake on serial,
or is it on by default?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
