From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 0/2] arm:omap:cleanup & split omap2/3/4_check_revision function
Date: Mon, 19 Dec 2011 15:50:13 +0530
Message-ID: <1324290015-12679-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57663 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab1LSKUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 05:20:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

Change log:
==========
Changes from V2:
	- Split the patch to make it more readable.
	- Make omap3_cpuinfo void funtion, since cpu_rev is global now.

Changes from V1:
	- Incorporated suggessions from Tony to split the function

Vaibhav Hiremath (2):
  arm:omap: Make cpu_rev static global variable
  arm:omap: cleanup & split omap2/3/4_check_revision function

 arch/arm/mach-omap2/id.c              |  186 ++++++++++++++-------------------
 arch/arm/mach-omap2/io.c              |    9 ++-
 arch/arm/plat-omap/include/plat/cpu.h |    7 +-
 3 files changed, 92 insertions(+), 110 deletions(-)

