From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/2] Introduce support for AM35xx
Date: Tue, 27 Oct 2009 19:32:18 +0530
Message-ID: <1256652138-5669-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55740 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbZJ0OCS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Oct 2009 10:02:18 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9RE2KKj007886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 09:02:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds support for the recently announced
AM3505 and AM3517 devices from Texas Instruments.

It also defines the AM3517 EVM board. Detailed
support will follow in subsequent patches.

  [1] http://www.ti.com/sitara 
  [2] http://www.ti.com/arm 
  [3] http://tiexpressdsp.com/index.php?title=Applications_Processors_Crossreference 
  [4] http://marc.info/?l=linux-omap&m=125615009412281&w=2
  
The patches have been created against omap-next branch.

Sanjeev Premi (2):
  AM35xx: Runtime detection of the device
  AM35xx: Define the AM3517EVM board

 arch/arm/mach-omap2/Kconfig           |    4 +++
 arch/arm/mach-omap2/id.c              |   43 ++++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

