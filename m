From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 0/8] ARM: OMAP4: core retention support
Date: Mon, 14 May 2012 13:03:08 +0300
Message-ID: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37716 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab2ENKDa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:03:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- Patch 6 now adds support for reading prev logic and mem states
  instead of tweaking the _update_logic_membank_counters function
  directly.

- Some version of "[PATCH] OMAP2+: UART: Add mechanism to probe uart
  pins and configure rx wakeup" from Govindraj is needed, otherwise
  UART can't wake up the device from suspend.

Tested with omap4460 GP panda + omap4430 EMU blaze devices.

Patches also available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-omap4-ret-v5

-Tero

