From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH v4,0/3] DT support for NAND on OMAP2
Date: Tue, 28 May 2013 17:11:22 +0530
Message-ID: <1369741285-1967-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54363 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933051Ab3E1Ll5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 May 2013 07:41:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, "Gupta, Pekon" <pekon@ti.com>, "Philip, Avinash" <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, hvaibhav@ti.com

From: "Gupta, Pekon" <pekon@ti.com>


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

Gupta, Pekon (1):
  ARM: dts: AM33XX: update GPMC node

Philip Avinash (1):
  ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm

Philip, Avinash (1):
  ARM: dts: AM33XX: Add ELM node

 arch/arm/boot/dts/am335x-evm.dts | 105 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |  10 +++-
 2 files changed, 114 insertions(+), 1 deletion(-)

-- 
1.8.1

