From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated, clocks and PM code reset to mainline
Date: Thu, 2 Apr 2009 17:13:33 -0700
Message-ID: <20090403001333.GR32530@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52628 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757821AbZDCANi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 20:13:38 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LpX2N-0006kw-LJ
	for linux-omap@vger.kernel.org; Fri, 03 Apr 2009 00:13:36 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

So after playing with merging the current mainline code into linux-omap,
I ended up resetting all the clock and PM code to be the same as in
the mainline kernel. This allows Paul and Kevin do their branches
directly against the mainline, and we'll have those patches ready to
go to mainline for the next merge window.

This means that the PM and some clock features will be broken until
we can merge in Paul's clock branch and Kevin's pm branch.

Please everybody take a look at the big commit that resets the code,
it's commit eba05254cb561dc27d5664503f91f7c21954e648. I've made sure
things build for all omap configs, and booted several boards. But I
may have accidentally left out something critical too..

Anyways, anything that we need to merge back should be posted to this
list as patches against the mainline tree. From now on, let's try
to make all the patches against the mainline tree in a way where
there are no cross-patch dependencies.

For the other stuff that I've reset to mainline, please grep for
"REMOVE OMAP LEGACY CODE" in git log of the commits.

I've also branched omap-2.6.29 to have something stable until we have
things working properly again.

Cheers,

Tony
