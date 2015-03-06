From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/24] ARM: OMAP2+: move clock implementations under clock driver
Date: Fri, 6 Mar 2015 14:28:35 +0200
Message-ID: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58155 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbbCFM3Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 07:29:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set moves almost all the legacy OMAP2+ clock driver implementations
under TI clock driver itself. Some non-used code is deleted at the same time.

This set touches both mach-omap2 folder + drivers/clk/ti, and should be
merged either through the clock tree or omap tree. Separating the set
for two pull-requests is not possible due to inter-dependencies (move
of code from one location to another.)

Please note that patches 12+13 will cause merge conflicts with the PRCM +
SCM set I posted earlier, as both are touching ti_clk_ll_ops. I have
pushed a separate sample branch that has the merge conflicts resolved also
(see info below; same test set has also been executed with the merged
branch.)

Testing done:
- am335x-evm:  boot
- am335x-sk:  boot
- am3517-evm:  boot
- am43xx-gpevm:  boot
- omap3-beagle-xm:  boot
- omap3-beagle:  boot, suspend-resume (ret/off), cpuidle (ret/off)
- beaglebone-black:  boot
- beaglebone:  boot
- dra7xx-evm:  boot
- n900:  boot
- omap5-uevm:  boot
- omap4-panda-es:  boot, suspend-resume (ret), cpuidle (ret)
- omap4-panda:  boot
- omap2430-sdp:  boot
- omap3430-sdp:  boot
- omap4430-sdp:  boot

Branch info:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: 4.0-rc1-clock-move
- merged PRCM branch: 4.0-rc1-clock-move-prcm-cleanup

Bloat-o-meter:
add/remove: 2/33 grow/shrink: 32/6 up/down: 935/-3201 (-2266)

Overall diffstat:
 43 files changed, 2531 insertions(+), 3599 deletions(-)

-Tero

