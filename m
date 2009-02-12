From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 0/3] DSPBRIDGE DVFS and Off mode support for bridgedriver
Date: Thu, 12 Feb 2009 06:40:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C0BEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38083 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbZBLBLV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 20:11:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C1BEF4022416
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2009 19:11:20 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C1BCae003587
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 06:41:13 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,

The patch set provides DVFS and offmode support for bridgedriver.
These patches to be applied on top of the pm branch. Currently 
Some times we have observed issues like MMU fault and DSP Reset on setting VDD1 to OPP1.

Looks like the drop in voltage to DSP core causing the issue. With a slight increase in VDD1 voltage level for OPP1 [patch 3/3] solving the issue, We are investigating further into this. 

[PATCH 1/3]DSPBRIDGE-Offmode-and-DVFS-Support.patch
[PATCH 2/3]DSPBRIDGE-DVFS-and-OFF-mode-support-with-OPP2.patch
[PATCH 3/3]Boosting-OPP1-voltage-level.patch


Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    2 +
 arch/arm/plat-omap/include/dspbridge/drv.h     |    6 +
 drivers/dsp/bridge/Kbuild                      |    3 +-
 drivers/dsp/bridge/rmgr/drv.c                  |   11 +-
 drivers/dsp/bridge/rmgr/drv_interface.c        |    5 +-
 drivers/dsp/bridge/rmgr/node.c                 |   37 ++--
 drivers/dsp/bridge/rmgr/proc.c                 |   48 ++--
 drivers/dsp/bridge/wmd/_tiomap_pwr.h           |    6 +
 drivers/dsp/bridge/wmd/io_sm.c                 |  339 +++++++++++++-----------
 drivers/dsp/bridge/wmd/tiomap3430.c            |  150 +++++++----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |  225 +++++++++++++++--
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   51 ++--
 12 files changed, 590 insertions(+), 293 deletions(-)


Please let me know your comments.

Thanks & regards
Ramesh Gupta G
