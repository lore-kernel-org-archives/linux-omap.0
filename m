From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 0/8] ARM: OMAP4: core retention support
Date: Thu, 18 Oct 2012 12:20:02 +0300
Message-ID: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43205 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2JRJUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 05:20:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:
- rebased on top of 3.7-rc1
- applies on top of latest func pwrst code (v6)
- added back patch #1 to this set (it wasn't queued yet after all)
- added patch #7 for fixing a bug in the functional pwrst code
- added patch #8 for fixing a regression with MUSB PHY power handling
  (not quite sure if this is the correct way to fix this or not)

Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
suspend.

Branch also available here:
git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.7-rc1-omap4-ret-v9

Branch contains also the local timer fix patch from Tony, otherwise
cpuidle does not work properly.

-Tero

