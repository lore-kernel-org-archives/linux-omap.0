From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 0/2] OMAP3: GPIO off-mode fixes
Date: Fri,  6 Mar 2009 13:46:24 +0200
Message-ID: <1236339986-29506-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53786 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZCFMDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 07:03:52 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n26C3ZWI021659
	for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2009 14:03:46 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n26C3fE2012362
	for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2009 14:03:41 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

These two patches add fixes to GPIO off-mode handling. First patch is more
important as it fixes a HW bug, second one just optimizes off-mode code
a bit by removing a couple of unnecessary registers from the context save.

--Tero


