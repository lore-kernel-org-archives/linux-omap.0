From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/19] ARM: OMAP4: device off support
Date: Mon, 14 May 2012 13:18:31 +0300
Message-ID: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38420 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab2ENKTG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:19:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- generic: dropped a few redundant cpu_is_omapXxxx checks
- generic: changed the ordering of patches a bit to allow new
  code + their users to be added in the same patch
- patch 3: removed dpll/cm/sar calls from this patch
- patch 4: added call to dpll save/restore to idle loop
- patch 5: indentation changes, added call to cm save/restore to idle loop
           merged cm1/cm2 save/restore funcs to single cm save/restores
- patch 6: added call to sar_save to idle loop
- patch 12: added errata flag for the feature instead of runtime cpu type
           check
- patch 15: reads the value of the register to be restored instead of
           using a magic number

Device off requires I2C save/restore context patch to function properly,
otherwise MMC driver sees issues during wakeup from off.

Tested with omap4460 GP panda + omap4430 EMU blaze devices.

Patches also available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-omap4-dev-off-v2

-Tero


