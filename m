From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 0/2] VFP context save/restore support for OMAP3
Date: Thu, 19 Nov 2009 19:06:13 +0200
Message-ID: <1258650375-9793-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46285 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbZKSPMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 10:12:41 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nAJFCajV008194
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 09:12:47 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nAJFCd3P010273
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 17:12:40 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

These two patches add support for VFP context save and restore. These patches
are a collaboration from several people (listed in CC), I have mainly
split the original patch in two parts (one generic ARM, one for OMAP3 PM),
and optimized the code a bit. No sign-offs added from anybody except myself
at the moment because I have modified the patches quite heavily.

I think patch #1 should actually go to linux-arm list, however I thought to
get some comments about the patches on omap list first.

These will apply on top of PM branch.

-Tero


