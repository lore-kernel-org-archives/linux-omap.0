From: Tony Lindgren <tony@atomide.com>
Subject: Things to do after 2.6.29 gets released
Date: Fri, 20 Mar 2009 15:12:31 -0700
Message-ID: <20090320221230.GA29546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56907 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbZCTWM1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 18:12:27 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Lkmwz-0004g9-7Z
	for linux-omap@vger.kernel.org; Fri, 20 Mar 2009 22:12:25 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

As there are quite a few omap patches going upstream this coming
merge window, here are some notes on where we should go after
2.6.29 gets released.

The goal of course is still to get all the important omap code
merged into the mainline kernel, and then just keep linux-omap
around to queue up patches for the upcoming merge windows.

After 2.6.29, we'll have to make few changes to rebase more
branches against the mainline. So I suggest following:

- We'll branch 2.6.29-omap to have something stable for next
  few weeks

- We'll merge with mainline to start using the mainline clock code,
  and Paul will maintain omap-clocks branch against the mainline
  where we'll add the further patches needed. The omap-clocks branch
  will get merged to linux-omap master branch on regular basis.

- We'll reset the PM code to mainline, and Kevin will maintain
  the pm branch against the mainline. The pm branch will get merged
  to l-o master branch on regular basis.

This way we will have the remaining clock patches and PM patches
ready to go to mainline without any extra effort needed. And Paul
and Kevin can rebase the omap-clocks and pm branches as needed.

Also, after 2.6.29, mach-omap1 should be completely in sync with
the mainline. For mach-omap2, we still need to get some more
board-*.c files merged after the clock and PM code. And there's
still some code under plat-omap that needs to be cleaned up.
And the drivers should keep getting integrated via the appropriate
driver mailings lists.

Luckily lots of patches patches should already apply against the
mainline kernel. So please everybody, try to make patches against
the mainline where possible. This should cover almost all the
board-*.c files and device drivers. I'll keep adding the core
omap patches to the various omap-upstream* queues so they're
ready to go to mainline kernel too.

Cheers,

Tony
