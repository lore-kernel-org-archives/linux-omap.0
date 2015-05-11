From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/27] ARM: OMAP2+: clock code migration to drivers/clk/ti
Date: Mon, 11 May 2015 11:54:26 +0300
Message-ID: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbEKIyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 04:54:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set moves most of the OMAP2+ clock driver code under drivers/clk.
There are still a couple of files under mach-omap2 folder after this
set which have either unmet dependencies still (towards PRCM driver)
or is currently slightly broken (some of the DVFS code for OMAP2/OMAP3.)
Earlier version of this set has been posted back in March (see
http://www.spinics.net/lists/linux-omap/msg116418.html), mostly
the code is the same except patches 25+ which are new.

Overall diffstat for this set:
 42 files changed, 2644 insertions(+), 3707 deletions(-)

Testing done:
am335x-evm      : boot
am335x-evmsk    : boot
am3517-evm      : boot
am37x-evm       : boot
am43x-epos-evm  : boot
am437x-gp-evm   : boot
omap3-beagle-xm : boot
omap3-beagle    : boot, suspend-resume (ret/off), cpuidle (ret/off)
am335x-boneblack: boot
am335x-bone     : boot
craneboard      : boot
dra7xx-evm      : boot
omap3430-ldp    : boot
omap3-n900      : boot
omap5-uevm      : boot
omap4-panda-es  : boot, suspend-resume (ret), cpuidle (ret)
omap4-panda     : boot
omap2430-sdp    : boot
omap3430-sdp    : boot 
omap4-sdp-es23plus: boot

Branch info:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: for-4.2/ti-clk-move

-Tero

