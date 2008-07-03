From: Tero Kristo <tero.kristo@nokia.com>
Subject: 34xx off-mode support fixes
Date: Thu,  3 Jul 2008 18:59:13 +0300
Message-ID: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41740 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbYGCN7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 09:59:48 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m63DxjJ2015732
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 08:59:46 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m63Dxh3d018829
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 16:59:43 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch set contains some experimental fixes for the cpu-idle support from
Rajendra Nayak. With this patch set, all power domains enter OFF mode and
recover from it, at least while using suspend and/or dynamic idle. If you
are using these patches, you should disable CPU_IDLE support from kernel
config as I am not certain it works with this patch set yet. The last patch
contains some trial fix to cpuidle code, so it might work also if you are
lucky enough.

-Tero


