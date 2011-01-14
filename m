From: Tony Lindgren <tony@atomide.com>
Subject: Open issues after 2.6.38 merge window
Date: Fri, 14 Jan 2011 11:47:58 -0800
Message-ID: <20110114194758.GM4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29049 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab1ANTsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 14:48:04 -0500
Received: from c-24-130-172-179.hsd1.ca.comcast.net ([24.130.172.179] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1Pdpcx-0000T3-Dp
	for linux-omap@vger.kernel.org; Fri, 14 Jan 2011 19:48:03 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Before I update out master branch, let's try to summarize the
open issues after the merge window. Here's a list of issues
in omap-fixes-for-linus that I'm aware of:

- NFS root oopses while mounting root

- omap4430 es1.0 hangs if L2X0 cache is enabled

- omap4 panda powers down after boot (watchdog?)

- omap3 ldp board powers down after boot?

Any other issues?

Regards,

Tony
