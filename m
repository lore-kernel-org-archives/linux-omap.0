From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/2] Fixes in hwmod reset code
Date: Tue, 13 Mar 2012 22:55:22 +0530
Message-ID: <1331659524-7635-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50267 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758764Ab2CMR1L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 13:27:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

This fixes a couple of issues around hwmod reset
APIs'.
Patches are based on 'hwmod_enable_remaining_hwmods_devel_3.4'
of git://git.pwsan.com/linux-2.6

Rajendra Nayak (2):
  ARM: omap: hwmod: Restore sysc after a reset
  ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status

 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

