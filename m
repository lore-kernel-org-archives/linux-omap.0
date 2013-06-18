From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 0/2] ARM: AM33XX: clock: Add debugSS data to clk and hwmod database
Date: Tue, 18 Jun 2013 10:37:58 +0530
Message-ID: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37381 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab3FRFIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 01:08:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch adds DebugSS data to clock-tree and hwmod data files.

Changes from RFC/V1 (No code change):
	- Based on comments, we have to follow DT and loadable module
	  approach for debugSS module as well, so separated out 2 patches
	  of clock-tree and hwmod data addition from the RFC patch-series.
	- Added Paul's Ack on clock-tree patch.
	- Rebased on top of Benoit's for-3.11/dts branch.

Link to original RFC -
http://archive.arm.linux.org.uk/lurker/message/20130304.113554.53c9ec25.en.html

Vaibhav Hiremath (2):
  ARM: AM33XX: clock: Add debugSS clock nodes
  ARM: AM33XX: hwmod: Add hwmod data for debugSS

 arch/arm/mach-omap2/cclock33xx_data.c      |   47 +++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   69 +++++++++++++++++++---------
 2 files changed, 89 insertions(+), 27 deletions(-)

