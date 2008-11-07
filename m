From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 0/3] OMAP: Make OMAP LDP boot succussfuly
Date: Fri,  7 Nov 2008 21:41:24 +0800
Message-ID: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50856 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYKGNfu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2008 08:35:50 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA7DZn9l021545
	for <linux-omap@vger.kernel.org>; Fri, 7 Nov 2008 05:35:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Now there is only basic support for OMAP LDP in linux-omap-2.6, LDP can't boot
up, even crash at boot time(because of omap_hdq problem).

Add the following patches to fix the boot crash and let LDP boot succussfuly.


