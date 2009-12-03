From: Tony Lindgren <tony@atomide.com>
Subject: Merge plans for 2.6.33 merge window
Date: Thu, 3 Dec 2009 09:36:00 -0800
Message-ID: <20091203173559.GR4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51304 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZLCRfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 12:35:54 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1NGFay-000Mi0-Kr
	for linux-omap@vger.kernel.org; Thu, 03 Dec 2009 17:36:00 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

As 2.6.32 is out, I'm planning to send Linus a pull request
for the code we have currently in for-next. That's already
a huge pile of code with the 7xx merge, header move, and
ioremap changes, pm etc:

Then I'll pile up another set of changes for next week
for a second round.

We should try to get in the clock framework changes,
especially clock framework for omap4. And the new mux
framework. Then there are some new board files, like
touchbook and various fixes.

Just FYI in case you're wondering why I'm not merging
recently posted code right now.

Regards,

Tony
