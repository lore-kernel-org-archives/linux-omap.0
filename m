From: David Brownell <david-b@pacbell.net>
Subject: does twl3040-pwrirq.c "need" to be a separate file?
Date: Mon, 29 Sep 2008 14:17:12 -0700
Message-ID: <200809291417.12437.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:26546 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753481AbYI2VRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 17:17:15 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Peter,

I see your patch 68d7477caca19c0b52b5d4e85700cd3e6115577f created
pwrirq.c as a separate file and thread.

I'm wondering if there's any particular reason that "bank" of
interrupts shouldn't be handled directly by twl4030-core, and
even by the same IRQ handling thread.

As it stands now the TWL "core" is not especially core-ish in
this respect, and I'd like to see that be resolved (e.g. by a
patch I'll probably write this afternoon) before this code
goes to mainline ...

- Dave
