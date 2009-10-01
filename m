From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv3 0/1] Runtime detection of Si features
Date: Thu,  1 Oct 2009 22:54:55 +0530
Message-ID: <1254417895-3716-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49352 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZJARY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 13:24:56 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n91HOvw5006027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Oct 2009 12:24:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This version is essentially same patch as [1]; but
refreshed against the tip (2bf0f78). The change in
text corresponding to the closing #endif in cpu.h
required change in the last line of the patch.

  [1] http://patchwork.kernel.org/patch/41989/

Sanjeev Premi (1):
  Runtime detection of Si features

 arch/arm/mach-omap2/id.c                  |   52 +++++++++++++++++++++++++++--
 arch/arm/mach-omap2/mmc-twl4030.c         |    1 +
 arch/arm/plat-omap/include/mach/control.h |   34 +++++++++++++++++++
 arch/arm/plat-omap/include/mach/cpu.h     |   23 +++++++++++++
 4 files changed, 107 insertions(+), 3 deletions(-)

