From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 0/2] arm: omap2+: hwmod: Allow hwmods to share same modulemode register filed
Date: Tue, 17 Jun 2014 15:24:32 +0530
Message-ID: <1402998874-1024-1-git-send-email-archit@ti.com>
References: <1401101095-27181-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41658 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbaFQJ4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 05:56:03 -0400
In-Reply-To: <1401101095-27181-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

IP blocks within a clock domain generally come with their own CM_X_CLKCTRL
registers, each having it's own MODULEMODE field to manage the module. This is
not the case for DSS, though. DSS contains contains sub modules, each of which
are represented by hwmods, but DSS itself has only one register
CM_DSS_DSS_CLKCTRL.

Add a way to allow multiple hwmods to share the same MODULEMODE fiels. This
means that MODULEMODE operation should be disabled only when the last hwmod
using it is disabled.

Changes in v2:

- The OMAP4 PRCM hwmod flag to show that this hwmod is shared was found
  redundant, and therefore, removed.
- Some of the struct names are shortened, and members are named more
  appropriately.

Archit Taneja (2):
  arm: omap2+: hwmod: Add refcounting for modulemode shared by multiple
    hwmods
  arm: omap5 hwmod data: Example: Make DSS hwmods share MODULEMODE
    fields

 arch/arm/mach-omap2/omap_hwmod.c           | 145 +++++++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod.h           |  35 +++++--
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  40 +++++---
 3 files changed, 180 insertions(+), 40 deletions(-)

-- 
1.9.1

