From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] Board specific prm timings
Date: Tue, 10 Feb 2009 18:04:34 +0200
Message-ID: <1234281875-19768-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51683 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbZBJQFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 11:05:08 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1AG4VsR013832
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 18:05:05 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This is an updated version which removes a useless printk.

This patch allows for boardspecific prm timings such as voltage and clock
setup delays. By default it will use the very conservative timings which were
used previously.

Peter 'p2' De Schrijver (1):
  per board prm timings

 arch/arm/mach-omap2/pm.h     |    9 +++++++++
 arch/arm/mach-omap2/pm34xx.c |   31 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

