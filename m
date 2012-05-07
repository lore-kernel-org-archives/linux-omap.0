From: Ashwin Bihari <ashwin.bihari@logicpd.com>
Subject: [PATCH 0/2] Add MUSB and LCD support to LogicPD OMAP3530 DevKits
Date: Mon, 7 May 2012 15:21:18 -0400
Message-ID: <1336418480-32635-1-git-send-email-ashwin.bihari@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.logicpd.com ([174.46.170.145]:45100 "HELO
	barracuda.logicpd.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757676Ab2EGThm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 15:37:42 -0400
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by barracuda.logicpd.com with ESMTP id XZpm5sM5eiEaDasq (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 14:21:30 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ashwin Bihari <ashwin.bihari@logicpd.com>

The following patch add MUSB (OTG) and LCD (Sharp 4.3" LQ043T1DG01) support
to the LogicPD OMAP3530 DevKits.

Ashwin Bihari (2):
  Add MSUB support for the LogicPD OMAP3530 DevKits
  Add LCD support for the LogicPD OMAP3530 DevKits

 arch/arm/mach-omap2/board-omap3logic.c |  173 +++++++++++++++++++++++++++++++-
 1 files changed, 172 insertions(+), 1 deletions(-)

