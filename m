From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Fri, 3 Oct 2008 08:57:37 -0700
Message-ID: <200810030857.37888.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32595 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752602AbYJCQbe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:34 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This flushes my queue of TWL (and related) patches that
seem ready to merge:

 - remove extra headers from RTC driver
 - remove RTC header
 - remove pwrirq header
 - core cleanups
 - gpiolib to_irq() feature
 - implement to_irq() for OMAP gpios
 - ... and for TWL gpios

At that point the twl4030-core code will be ready to
enter the MFD queue IMO ... there've not been many
review comments other than mine (which were mostly
addressed in the "core cleanups" patch above).

The main open issues with respect to the TWL core
seem to relate to IRQ handling.  I've had a bright
idea that I think will solve a bunch of issues at
once, but that can/should go separately.  And then
there will still be the issue of genirq support for
threaded IRQs -- which isn't quite available yet.

(One observation is that we should prefer to get
drivers in mainline even if they're not yet fully
cooked ... and mainline is happy with that model.
In this case we'll have cleaned up lots of ragged
edges, but not yet many of the IRQ bits.)

- Dave
