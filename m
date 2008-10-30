From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [RFC] Change from system_rev to omap_rev()
Date: Fri, 31 Oct 2008 01:28:24 +0200
Message-ID: <1225409305-3465-1-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58200 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbYJ3X1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 19:27:42 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9UNRdH4017204
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 01:27:40 +0200
Received: from localhost.localdomain (pure.research.nokia.com [172.21.42.21])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9UNRb8c008275
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 01:27:37 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The following patch changes all instances where system_rev
is used to identify the omap chip to use omap_rev() instead.
This frees system_rev to be used in its original purpose
with ATAG_REVISION to communicate the board revision instead.

The patch has been compile tested for OMAP3, any feedback
would be nice.

regards, Lauri


