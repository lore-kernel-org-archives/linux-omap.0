From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCH 0/4] OMAP: Clean up series for generic opp layer.
Date: Tue, 13 Jul 2010 11:17:02 +0530
Message-ID: <1279000026-24042-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab0GMFrV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 01:47:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, b-cousson@ti.com, sawant@ti.com, vishwanath.bs@ti.com, premi@ti.com, Thara Gopinath <thara@ti.com>

This patch series does some clean up of the opp layer
including removal of compilation warnings, avoiding wrong inclusioin
of header files, correcting some srror checks and removing the dependency
of opp layer on cpu freq layer.

Apart from all these there is still one more concern i have in this generic
opp layer. This is regarding the separate PMIC opp file opp_twl_tps.c which
today caters to only twl4030 and twl5030 pmic. What is the approach to be
taken if the PMIC changes? I am already facing this issue with OMAP4 where
the PMIC is twl6030 and the formulas for converting vsel into voltage and
vice versa are different. I am against adding another file for twl6030. The
approach is not scalable. We need to keep these vsel to uV and vice versa
convertion in one place or make them functions pointers.

Thara Gopinath (4):
  OMAP: Fix the compilation warning in the opp layer
  OMAP: Correct the return value check after call into find_device_opp
  OMAP: Remove inclusion of PMIC specific header file in generic opp
    layer.
  OMAP: Remove dependency of generic opp layer on cpufreq.

 arch/arm/plat-omap/Makefile           |    4 ++--
 arch/arm/plat-omap/include/plat/opp.h |    4 ++--
 arch/arm/plat-omap/opp.c              |    7 +++----
 3 files changed, 7 insertions(+), 8 deletions(-)

