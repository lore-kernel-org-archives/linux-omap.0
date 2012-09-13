From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 0/5] ARM: OMAP4: core retention support
Date: Thu, 13 Sep 2012 19:36:44 +0300
Message-ID: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124Ab2IMQhA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 12:37:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- Dropped following patches from the set as these were queued by Paul:
0003-ARM-OMAP4-hwmod-flag-hwmods-modules-not-supporting-m.patch
0004-ARM-OMAP-hwmod-Add-support-for-per-hwmod-module-cont.patch
0005-ARM-OMAP4-pwrdm-add-support-for-reading-prev-logic-a.patch
0009-ARM-OMAP4-hwmod-data-temporarily-comment-out-data-fo.patch
0010-ARM-OMAP4-HWMOD-add-support-for-lostcontext_mask.patch

- Dropped following patches for now as their need is not that clear at
  the moment:
0011-ARM-OMAP4-hwmod_data-add-context-lose-information-fo.patch
0012-ARM-OMAP4-hwmod-update-context-lost-counter-logic-fo.patch

- Rebased on top of func-pwrst-v6 from Jean and 3.6-rc5.

- Added patch #5 for yet another bug fix: the fix for the omap4460
  (patch #2) is incomplete, and can cause rare TWD timer bugs. This
  patch fixes those.

- Tested with omap4460 GP panda + omap4430 EMU blaze, with suspend +
  cpuidle.

Branch also available here (it also has the func pwrst code + the queued
hwmod patches as the code doesn't apply cleanly / work without these.)

Tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
Branch: mainline-3.6-rc5-omap4-ret-v8

-Tero

