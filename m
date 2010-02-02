From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv5 0/9] Idlestatus patches
Date: Tue,  2 Feb 2010 16:52:18 +0200
Message-ID: <1265122347-2233-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56613 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab0BBNDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:03:09 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D2oER002953
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:03:04 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D2wJb029178
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:02:58 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Improvements compared to previous version:

- Removed hacks from generic powerdomain code, instead added support
  routines for OMAP3, which are used by pm34xx.c and cpuidle34xx.c, these
  support routines only touch mpu, core and neon powerdomains
- Bug fix: comparison in cpuidle fallback loop was incorrect
- Changed peripheral can_idle checks into direct checks for the current
  power state
- Fixed support for off-mode enabling as part of this set, cpuidle now
  selects proper state when off-mode is disabled
- Added support for INACTIVE states for suspend code (mpu, core, neon only)


