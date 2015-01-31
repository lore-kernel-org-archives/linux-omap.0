From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 0/2] ARM: DRA7x/OMAP5: Clock: DPLL Clock fixes
Date: Sat, 31 Jan 2015 22:36:43 +0530
Message-ID: <1422724005-9415-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52440 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbbAaRIN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Jan 2015 12:08:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>

Fix bypass clock source for a few DPLLs.

On DRA7x/OMAP5, for a few DPLLs, both CLKINP and CLKINPULOW are connected
to a mux and the output from mux is routed to the bypass clkout.
Add a mux-clock as bypass clock with CLKINP and CLKINPULOW as parents.

Tested against: 
	tree: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
	branch: master
On:
CPU  : OMAP5432 ES2.0
Board: OMAP5432 uEVM
and
CPU  : DRA752 ES1.0
Board: DRA7xx


Ravikumar Kattekola (2):
  ARM: DRA7x: dts: Fix the bypass clock source for dpll_iva and others
  ARM: OMAP5: dts: Fix the bypass clock source for dpll_iva and others

 arch/arm/boot/dts/dra7xx-clocks.dtsi   |   90 ++++++++++++++++++++++++++++----
 arch/arm/boot/dts/omap54xx-clocks.dtsi |   41 +++++++++++++--
 2 files changed, 118 insertions(+), 13 deletions(-)

-- 
1.7.9.5

