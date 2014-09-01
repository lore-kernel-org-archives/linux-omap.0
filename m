From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Mon, 1 Sep 2014 21:08:49 +0300
Message-ID: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37227 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbaIASJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set contains PRCM related cleanups meant for 3.18 merge window.
These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
(http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nishanth's
set is used as basis to avoid merge issues.

Purpose of this work is to eventually convert the PRCM code into a
separate driver, but this is done in incremental parts as the amount
of changes is substantial. Expected conclusion of this work is 3.19
if everything goes fine.

This part of the work mostly moves some of the SoC specific PRCM driver
calls under generic version of the same, and adds SoC-ops to support
these on the driver level.

Working branch posted here:

tree: https://github.com/t-kristo/linux-pm.git
branch: for-v3.18/prcm-cleanup

Testing done:
am335x-evm: boot
am335x-bone: boot
am335x-boneblack: boot
am3517-evm: boot
am437x-gp-evm: boot
omap3-beagle-xm: boot
omap3-beagle: boot suspend/resume (ret/off)
dra7-evm: boot (with additional clock patches to fix boot issues)
omap3-n900: boot
omap5-uevm: boot
omap4-panda-es: boot suspend/resume (ret)
omap2430-sdp: boot

-Tero

