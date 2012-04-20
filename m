From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 0/8] ARM: OMAP4: core retention support
Date: Fri, 20 Apr 2012 12:19:43 +0300
Message-ID: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52296 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab2DTJUH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Changes compared to previous version:

- rebased on top of 3.4
- added back TEMP patch for preventing DSP wakeup as Paul's powerdomain
  fixes are not yet in (patch #2)
- added open switch retention support (OSWR), can be enabled by
  echo 1 > /debug/pm_debug/enable_oswr_mode
- fixed support for 4460 (added patch #3)

Applies on top of mainline 3.4 + iochain set. May kind of work without
the iochain set but waking up from retention might be impossible.

Tested both CSWR + OSWR modes on omap4430 EMU blaze + omap4460 GP panda.

Working branch available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-omap4-ret

-Tero

