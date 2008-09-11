From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 00/10] Patches for fixing the lowmem module
Date: Thu, 11 Sep 2008 19:20:32 +0300
Message-ID: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49357 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbYIKQLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:40 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBaj6015404
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:37 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOj012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:19 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello,

Currently the lowmem module doesn't compile. Here are some patches
that will fix a bug, make some improvements and even make it compile.

 security/lowmem.c |  258 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 154 insertions(+), 104 deletions(-)

best regards,

Viktor
