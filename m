From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Clean-up for rx51
Date: Fri, 13 Mar 2009 11:03:23 -0700
Message-ID: <20090313180123.1548.1188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61605 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbZCMSDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 14:03:23 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=[127.0.0.1])
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LiBj6-0003yD-SL
	for linux-omap@vger.kernel.org; Fri, 13 Mar 2009 18:03:21 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Here are few patches against the l-o tree to clean-up rx51 board
files. Also catch up with the mmc-twl4030 changes, and make
the smc911x Ethernet work.

Regards,

Tony

---

David Brownell (3):
      Hook up twl4030 regulators to the relevant RX51 MMC slots.
      Bugfix to RX51 flash support:  this board has no NOR flash,
      Clean-up rx51 a bit and set the regulators.

Tony Lindgren (1):
      Set the smc91x timings for rx51


 arch/arm/mach-omap2/board-rx51-flash.c       |   58 -----
 arch/arm/mach-omap2/board-rx51-peripherals.c |  305 ++++++++++++++++++++++----
 2 files changed, 262 insertions(+), 101 deletions(-)

-- 
Signature
