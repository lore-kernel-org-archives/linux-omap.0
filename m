From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 0/1] twl4030-madc: Fix arbitrarily initialized function pointer
Date: Wed,  2 Jul 2008 16:36:35 +0300
Message-ID: <1215005796-10117-1-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43747 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694AbYGBNab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 09:30:31 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m62DTwYw022769
	for <linux-omap@vger.kernel.org>; Wed, 2 Jul 2008 16:30:29 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m62DTT1k006470
	for <linux-omap@vger.kernel.org>; Wed, 2 Jul 2008 16:29:29 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I have seen this bug crash the kernel when the security framework is enabled
in the kernel config. It crashed with a bad syscall from the events/0
workqueue; probably because the security framework is initialized very early
and thus the stack has been used more [or differently] and we end up picking up
a bad [nonzero] arbitrary address from the stack.

best regards,

Viktor
