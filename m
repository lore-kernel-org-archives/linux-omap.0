From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH v2 0/6] OMAP: Make OMAP LDP boot succussfuly
Date: Tue, 11 Nov 2008 19:50:52 +0800
Message-ID: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63623 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbYKKLrF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 06:47:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnpol@2ka.mipt.ru

Changes since v1:

1, fix all the patch format problem.

2, split the defconfig patch from code patches.

3, put a twl4030keypad bug fix into a single patch.

4, Add a "persistent" bit in the keypad map, and prune off "#ifdef(OMAP_LDP)"
from the keypad driver.


Now there is only basic support for OMAP LDP in linux-omap-2.6, LDP can't boot
up, even crash at boot time(because of omap_hdq problem).

Add the following patches to fix the boot crash and let LDP boot succussfuly.


