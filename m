From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated to v2.6.27, some issues remain
Date: Fri, 10 Oct 2008 15:04:29 +0300
Message-ID: <20081010120427.GZ3044@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50162 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757561AbYJJMEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 08:04:32 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1KoGjP-00036n-I8
	for linux-omap@vger.kernel.org; Fri, 10 Oct 2008 12:04:31 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've just updated our git tree to v2.6.27 and pushed some recent fixes.

Let's try to get the pending issues sorted out and then tag -omap1
at the end of next week. So far it looks like we still have the following
issues remaining:

- i2c transfers not working because of i2c-omap.c PM (These also make
  musb init fail at least on 3430sdp)

- 24xx/34xx write posting issue

- 34xx spurious interrupts about 1/20 reboots

Anything else not working right now?

BTW, I'll out of town for the weekend, then flying back to home on
Monday, so I'll be offline for most part until Tuesday.

Tony
