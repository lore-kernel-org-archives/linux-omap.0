From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: mmc generalization
Date: Fri, 25 Apr 2008 01:17:41 +0300
Message-ID: <1209075462-14296-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47454 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbYDXWcM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 18:32:12 -0400
Received: from a91-154-120-12.elisa-laajakaista.fi ([91.154.120.12]:25999 helo=localhost.localdomain)
	by serv01.siteground211.com with esmtpa (Exim 4.68)
	(envelope-from <felipe.balbi@nokia.com>)
	id 1Jp9jc-0005vv-OQ
	for linux-omap@vger.kernel.org; Thu, 24 Apr 2008 17:16:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

The following patch, similarly to usb patch, makes mmc_init
more generic by moving files around and changing function names.

*** COMPILE TESTED ONLY ***

Please give it a review, I might let something out.

BR,

	- Balbi

