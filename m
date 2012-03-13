From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] Fixes in hwmod reset code
Date: Tue, 13 Mar 2012 19:25:26 +0530
Message-ID: <1331646928-31119-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48773 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab2CMNzk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 09:55:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

This fixes a couple of issues around hwmod reset
APIs'.
Patches are based on 3.3.-rc7.

Rajendra Nayak (2):
  ARM: omap: hwmod: Restore sysc after a reset
  ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status

 arch/arm/mach-omap2/omap_hwmod.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

