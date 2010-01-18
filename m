From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCHV2 0/2] OMAP3630: Clock: Workaround for DPLL HS divider
 limitation
Date: Mon, 18 Jan 2010 18:03:24 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC0F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab0ARMds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 07:33:48 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

>From e5dddd99557dc73a581001b39d595cfacdc45ec2 Mon Sep 17 00:00:00 2001
From: Vijaykumar GN <vijaykumar.gn@ti.com>
Date: Tue, 12 Jan 2010 17:15:29 +0530
Subject: [PATCH 0/2] OMAP3630: Clock: Workaround for DPLL HS divider limitation

This series of patch implements a workaround for the DPLL HS divider limitation
in OMAP3630.

Without this workaround the divider value goes to its reset state after the
corresponding PWRDN bit is set from the CM_CLKEN_PLL  register.
The correct divider value can be restored by writing dummy value to the
register than what is in there, and then re-writing the desired value. 
HS Dividers impacted are
1. DPLL3_M3
2. DPLL4_M2
3. DPLL4_M3
4. DPLL4_M4
5. DPLL4_M5
6. DPLL4_M6

This patch series has dependency on Clock framework reorganization available at
http://patchwork.kernel.org/patch/73638/
http://patchwork.kernel.org/patch/73635/
http://patchwork.kernel.org/patch/73637/
http://patchwork.kernel.org/patch/73636/

V1: Initial Patch Series
V2: Incorporated comments

Mike Turquette (2):
  OMAP3630: Clock: add clksel_shift to struct clk
  OMAP3630: Clock: Fixing HSDivider Limitation

 arch/arm/mach-omap2/clock34xx.c         |   36 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h         |    1 +
 arch/arm/mach-omap2/clock34xx_data.c    |   21 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 4 files changed, 62 insertions(+), 0 deletions(-)

