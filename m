From: Ameya Palande <ameya.palande@nokia.com>
Subject: DSPBRIDGE: Tie Resource accounting to Process Context
Date: Tue, 11 Aug 2009 04:21:41 +0300
Message-ID: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49872 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbZHKBWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 21:22:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, suyog@ti.com, roman.tereshonkov@nokia.com, ernesto@ti.com

This patch series uses filp->private data to get access to a PROCESS_CONTEXT
pointer which in turn tracks all the resources tied to an open file handle.

This will help in:
1. Implementation of clean resource accounting.
2. Proper resource cleanup irrespective of multithreading or multitasking in
   user space applications.

