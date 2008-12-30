From: Peter Barada <peterb@logicpd.com>
Subject: Power Management question...
Date: Mon, 29 Dec 2008 21:31:47 -0500
Message-ID: <1230604308.7951.4.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:54103 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752066AbYL3Cbt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Dec 2008 21:31:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I'm trying to put together a 2.6.27 (from the 2.6.27 tag) kernel with
power management, and what I'm seeing is a bit weird...

When I put it into "mem" state (i.e. save to DRAM and sleep the world,
leaving DRAM alive), I see current consumption actually *increase*.
Also, any interrupt (touch, serial, mmc insert/removal) automagicaly
wakes it up.

Any pointers on how to make sense of this?  I would have thought that
drivers have to specify which interrupts are capable of waking the
core...

-- 
Peter Barada <peterb@logicpd.com>
