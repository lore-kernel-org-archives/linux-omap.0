From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 00/45] OMAP CCF DT conversion
Date: Thu, 29 Aug 2013 16:15:52 +0300
Message-ID: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55498 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3H2NRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:17:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

Rather large diff from previous version, main changes:

- Rebased on top of v3.11-rc5 (+ DRA7 data + Mike's clock bindings v4)
- Clkdev code hacks replaced with a static array of clkdev entries which
  get initialized during boot based on SoC type. These arrays can be
  eventually removed once DT support for device drivers is fixed
- Devicetree documentation changes
- Split compatible + flag clock types to different clock types (e.g.
  ti,gate-clock + ti,dss-clock => ti,dss-gate-clock), flags are no longer
  needed
- Removed some unnecessary DT properties for some of the clocks (like
  DPLL has no longer clk-ref/clk-bypass / recal bit info)
- Added a couple of patch sets from Rajendra (31-33) + Nishanth (38-40) to
  the end; these are dealing with DT clock data and help to reduce code
  from mach-omap2, added also a number of patches that tweak the DT data
  based on these sets

NOTES:
 - Patches 31+ are only needed for cleanup purposes
 - Patches 43+ require Tony's DRA7 data pull-req to apply cleanly / work
 - Patch 37 should only be applied once legacy boot for OMAP3 can be omitted

Test branch available here:

https://github.com/t-kristo/linux-pm.git
branch: v3.11-rc5-clk-dt-v6

This branch contains:
- Tony's DRA7 data pull-request
- Mike's basic clock binding patches v4
- Couple of hacks for testing purposes
- This set

Testing done:
- AM335x-bone - boot test
- OMAP3-beagle - boot test, suspend test
- OMAP4-panda-es - boot test, suspend test
- OMAP5-sevm - boot test
- DRA7-evm - boot test

-Tero

