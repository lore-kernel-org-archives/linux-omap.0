From: Tony Lindgren <tony@atomide.com>
Subject: Alternative git mirror for linux-omap
Date: Tue, 6 Sep 2011 14:32:49 +0300
Message-ID: <20110906113248.GD3548@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20830 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753795Ab1IFLcv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 07:32:51 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1R0tta-000AhJ-Gc
	for linux-omap@vger.kernel.org; Tue, 06 Sep 2011 11:32:51 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

As kernel.org git servers still cannot be updated, I've set up
a git branch at:

http://github.com/tmlind/linux

You can pull from that to your existing tree with:

$ git pull http://github.com/tmlind/linux master

Regards,

Tony
