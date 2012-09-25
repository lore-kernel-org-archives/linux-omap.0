From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 00/21] ARM: OMAP3+: auto retention support
Date: Tue, 25 Sep 2012 19:33:32 +0300
Message-ID: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59732 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454Ab2IYQeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 12:34:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set applies on top of linux-3.6-rc5 + func-pwrst code (from Jean) +
omap4 core retention set (from me) + PM usecounting changes set (from me).

Changes compared to previous version:
- Added proper OMAP4 auto-retention support (now that the PM usecount set
  below supports OMAP4 also properly)
- Merged TPS6236x support to this set (patches 16,18-20), without this
  there will be an issue with patch #21, as panda board will misbehave
  without TPS support and auto-ret enabled
- Patch #15 fixes the addressing of voltage channels for OMAP4, without this
  the voltage channels either end up changing wrong voltage channel or not
  changing anything at all
- Patch #16 is new based on the discussion earlier on the separate TPS set
  * uses proper I2C parameters based on board data, this is still in a data
    table though, as calculating these runtime would be rather complicated
    (if even possible, as it requires some higher order mathematics according
     to my understanding)
- Patch #17 enables high speed I2C communication for voltage channel on OMAP4
  (this now works thanks to patch #16)
- Patch #18 is needed for 4460 boards, otherwise the boot-up OPP detection
  fails and voltage control doesn't work at all on 4460 boards
- Patch #19 was pulled from the TPS support set
- Patch #20 was pulled from the TPS support set, with following changes:
  * board setup for the GPIOs was sanitized a bit
  * dropped a number of unused defines from the code

Working branch available:
git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.6-rc5-omap-auto-ret-v7

Testing done:
- hw used: omap3 beagle rev c4, omap4460 gp panda, omap4430 emu blaze
- suspend + cpuidle
- measured core + mpu voltage rails on all setups to verify that the
  voltage transitions work properly during idle

-Tero

