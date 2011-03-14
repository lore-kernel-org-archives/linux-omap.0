From: Tony Lindgren <tony@atomide.com>
Subject: Code for v2.6.39 merge window frozen, patches archived
Date: Mon, 14 Mar 2011 12:25:38 -0700
Message-ID: <20110314192538.GH7258@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23956 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581Ab1CNTZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 15:25:46 -0400
Received: from c-98-234-237-12.hsd1.ca.comcast.net ([98.234.237.12] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1PzDOj-0006Zm-Vc
	for linux-omap@vger.kernel.org; Mon, 14 Mar 2011 19:25:46 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've applied few random fix like patches today into omap-for-linus
but that's it for this merge window.

So let's do some testing with with Stephen's for-next and
omap-for-linus and start queueing up fixes for the -rc cycle.

I've also moved all the patchwork.kernel.org patches into
archived-v2.6.39 bundle and marked them as archived:

https://patchwork.kernel.org/user/bundle/1381/

You can still find the patches there if you click on Filters
and changed Archived from No to Both.

Looks like there's one smartreflex patch that does not seem
to exist in patchwork though.. So that one is still lurking
around on the patchwork list of patches until the issue has
been fixed in patchwork.kernel.org.

Cheers,

Tony
