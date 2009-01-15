From: Tony Lindgren <tony@atomide.com>
Subject: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Thu, 15 Jan 2009 17:43:28 +0200
Message-ID: <20090115154327.GF4128@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58781 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758094AbZAOPn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 10:43:28 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LNUNS-000JfR-If
	for linux-omap@vger.kernel.org; Thu, 15 Jan 2009 15:43:27 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've updated our git tree to v2.6.29-rc1, and will start cleaning up
code in it by resetting what can be reset to be the same as in the
mainline tree.

This means that everybody please resend the stuff you want back as
patches against the mainline tree! Most likely the stuff I'm removing
will require a bit of clean-up work. But cleaning it all up is just
way too much work for one person to do, so we take the distributed
approach :)

I've also added a new branch omap-2.6.28 where we can add few bug
fixes until we can tag v2.6.28-omap2.

Regards,

Tony
