From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 0/1] DSPBRIDGE DVFS and offmode support updated
Date: Fri, 13 Feb 2009 17:22:18 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A4177876@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54833 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZBMLw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 06:52:56 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1DBqn5j030818
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 05:52:55 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1DBqm4L016587
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 17:22:48 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>

All,
This is the upated patchset provides DVFS and offmode support for bridgedriver.
This patch can be applied on pm branch along with oter DSPBRIDGE patches and is validated
On OMAP3430 SDP.

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
 drivers/dsp/bridge/wmd/tiomap3430.c            |  147 +++++++----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |  225 +++++++++++++++--
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   51 ++--
 12 files changed, 589 insertions(+), 291 deletions(-)

Regards
Ramesh Gupta G