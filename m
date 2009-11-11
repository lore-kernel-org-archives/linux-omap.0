From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/4] Regulator: Providing regulator initialization macros/wrappers
Date: Wed, 11 Nov 2009 20:14:27 +0530
Message-ID: <1257950667-32361-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbZKKOod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 09:44:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Based on the discussion at:
  http://marc.info/?l=linux-omap&m=125775124829936&w=2

Header file board-omap35x-pmic.h is created to provide generic macros for
initializing regulator supplies and regulator init data. Wrappers are
also created using these macros which could be used in default scenarios.

Modified board-3430sdp.c and board-omap3evm.c to use the macros/wrappers
instead, to avoid duplication of common code. On the similar lines, other
board-evm files can be modified and new code can be added using these
macros.

Anuj Aggarwal (4):
  Regulator: Adding header file for initializing OMAP35x PMICs
  Regulator: Modifying board-omap3evm.c to use PMIC-init-macros or
    wrappers
  Regulator: Modifying board-3430sdp.c to use PMIC-init-macros or
    wrappers
  Regulator: Modifying Kconfig to choose from the available PMICs

 arch/arm/mach-omap2/Kconfig              |    8 ++
 arch/arm/mach-omap2/board-3430sdp.c      |  196 ++++++++----------------------
 arch/arm/mach-omap2/board-omap35x-pmic.h |  191 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c     |   82 ++++++-------
 4 files changed, 290 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-pmic.h

