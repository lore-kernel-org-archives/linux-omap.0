From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6 0/9] Refreshed idlestatus patches with minor fixes
Date: Fri, 12 Feb 2010 20:27:36 +0200
Message-ID: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64034 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab0BLQjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:39:36 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdXhO022046
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 10:39:35 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdVLr021112
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:31 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Following changes compared to previous set:

- Fixed a problem with PER domain handling when PER was active
- Removed rwlock usage from pwrdm_can_idle as the lock was removed from
  powerdomain code

Still applies on top of PM branch.


