From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 0/6] the last planned twl4030 core IRQ updates
Date: Fri, 10 Oct 2008 14:19:11 -0700
Message-ID: <200810101419.12192.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44577 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759624AbYJJV3r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Following this are six patches:

 - Split PIH irq support into a separate file
 - Change SIH initialization scheme, enabling data re-use
 - Add sharable SIH irq_chip support
 - Replace unshared pwrirq irq_chip (gains IRQ trigger controls)
 - Replace unshared gpio irq_chip (no functional changes)
 - Remove more CPP symbols

The high level summary:  shrink the code, remove a task, and
have the SIH support code ready for mainline merge.

With SIH support merged, the RTC driver will also become
mergeable.  I think most of the other child drivers aren't
quite ready yet though.

- Dave


