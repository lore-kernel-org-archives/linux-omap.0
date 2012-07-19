From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 00/12] ARM: OMAP4: core retention support
Date: Thu, 19 Jul 2012 16:26:20 +0300
Message-ID: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58857 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab2GSN0w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:26:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- ported on top of 3.5-rc7
- patch 3: added a few modules here not having context_offs
- patch 8: NEW:
  * ROM code on EMU / HS devices seem to wipe the contents of
    L4PER_PWRSTCTRL register, thus this patch adds an errata +
    save and restore for this register, this was noticed while
    testing cpu_idle on EMU device
- patch 9: NEW:
  * sl2if hwmod is still blocking core retention on omap4, this
    patch comments it out similarly to aess / usb_host_fs
- patch 10: NEW:
  * adds support for lostcontext_mask, this is needed by l4_abe / aess
    hwmods as they will share context register, but use different bits
    within it
- patch 11: NEW:
  * adds the hwmod data for sharing context register for l4_abe / aess
- patch 12: NEW:
  * context lost counter logic update for modules that don't have
    context register

Some of the NEW patches (10..12) are result of comments received on
l-o list, and can be merged with other patches in the set if they are seen
acceptable. Core retention works without these patches fine, but they
address some corner cases.

Tested with omap4460 GP panda + omap4430 EMU blaze, with both suspend +
cpu_idle. cpu_idle + uart autosuspend seems to have an issue with
omap4 currently that it loses some of the characters at the end of
a print, should be fixed on uart driver level. Made a quick hack myself
for this by modifying the serial_omap_tx_empty() to not use pm_runtime_put
but pm_runtime_put_autosuspend at end, but this might not be the right
way to fix this.

Working test tree available also:
git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.5-rc7-omap4-ret-v7

Branch contains also func pwrst code from Jean + io_chain set + one
timekeeping patch from mainline tip to make suspend work properly.

-Tero

