From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH v5, 0/3] DT support for NAND on OMAP2
Date: Fri, 31 May 2013 13:19:02 +0530
Message-ID: <1369986545-29204-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49813 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab3EaHtX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 03:49:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, "Philip, Avinash" <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, jacmet@sunsite.dk, zonque@gmail.com, Jon Hunter <jgchunter@gmail.com>

From: "Gupta, Pekon" <pekon@ti.com>

Changes v4->v5
	- updated commit descriptions.
	- included patch by "Lars Poeschel" instead of [Patch 2/3]

Changes v3->v4
	- rebased to linux-3.10-rc3
	- updated newly supported DT properties based on following commits
	[d36b4cd] jon-hunter@ti.com ARM: OMAP2+: Add additional GPMC timing ...
	[8c8a777] jon-hunter@ti.com ARM: OMAP2+: Add function to read GPMC ...
	[9f83315] jon-hunter@ti.com ARM: OMAP2+: Add variable to store number

Changes v2->v3
	- rebased to linux-3.9-rc8
	- AM335x-evm.dts: moved GPMC pin-mux config to nand node

Changes v1->v2
	- Change number of chip select to 7
	- Replace <xx> literals to 52
	- remove tab

Lars Poeschel (1):
  dts: am33xx: Correct properties on gpmc node

Philip Avinash (1):
  ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm

Philip, Avinash (1):
  ARM: dts: AM33XX: Add ELM node

 arch/arm/boot/dts/am335x-evm.dts | 105 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |  12 ++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

-- 
1.8.1

