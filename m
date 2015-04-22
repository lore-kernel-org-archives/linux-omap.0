From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] thermal: ti-soc-thermal: Implement work around for Errata i813 and i814
Date: Wed, 22 Apr 2015 18:21:40 +0530
Message-ID: <1429707102-20678-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45390 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbbDVMvx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 08:51:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.or, t-kristo@ti.com, j-keerthy@ti.com

The series implements work arounds for couple of Erratas.

Tested the series on OMAP5 and DRA7 Boards.

Keerthy (2):
  thermal: ti-soc-thermal: dra7: Implement Workaround for Errata i814 -
    Bandgap Temperature read Dtemp can be corrupted
  thermal: ti-soc-thermal: OMAP5: Implement Workaround for Errata i813

 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  3 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 78 +++++++++++++++++++++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  6 ++
 4 files changed, 86 insertions(+), 4 deletions(-)

-- 
1.9.1

