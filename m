From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated to v2.6.28-rc2, old sound and v4l drivers removed
Date: Mon, 27 Oct 2008 13:43:24 -0700
Message-ID: <20081027204323.GA7539@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61673 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYJ0Un1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2008 16:43:27 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1KuYvt-00087u-Gx
	for linux-omap@vger.kernel.org; Mon, 27 Oct 2008 20:43:26 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've updated our git tree to 2.6.28-rc2, so please check that I did
not mis-merge any of your code that's not yet in the mainline tree.

I've also removed the old omap audio and v4l drivers as we've discussed
earlier. The development for these drivers should be happening in
the alsa and v4l lists.

I'll be removing more old drivers, such as drivers/mtd and
drivers/video.. But let's first figure out what we want to get merged
upstream from there.

Cheers,

Tony
