From: Peter Barada <peterb@logicpd.com>
Subject: No OMAP PM code on the PM branch???
Date: Fri, 01 May 2009 14:39:05 -0400
Message-ID: <1241203145.18100.370.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:59629 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754709AbZEASjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 May 2009 14:39:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I'm looking through Kevin's PM branch, and I've done a quick-port of
2.6.30-rc1 to Logic's OMAP3530 LV SOM starting with the rk21 board code,
and "echo mem > /sys/power/state" does nothing.  Worse,
"cat /sys/power/state" doesn't show anything.

This is due to no code calling suspend_set_ops() which used to be in
arch/arm/mach-omap2/pm34xx.c - this isn't in either Tony or Kevin's
current tree.

1) Am I way off base (i.e. am I missing something obvious here)?

-- 
Peter Barada <peterb@logicpd.com>
