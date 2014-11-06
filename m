From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/3] ARM: dts: AM43x: Fix DCDC3 regulator voltage
Date: Thu, 6 Nov 2014 16:20:01 +0530
Message-ID: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59827 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaKFKxm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 05:53:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, galak@codeaurora.org, mark.rutland@arm.com, pawel.moll@arm.com

Fix DCDC3 volatge to 1.5V which is the right value to be supplied by
DCDC3 for all the boards.

Keerthy (3):
  ARM: dts: AM43x-EPOS-EVM: Fix DCDC3 voltage
  ARM: dts: AM437x-GP-EVM: Fix DCDC3 voltage
  ARM: dts: AM437x-SK-EVM: Fix DCDC3 voltage

 arch/arm/boot/dts/am437x-gp-evm.dts  |    4 ++--
 arch/arm/boot/dts/am437x-sk-evm.dts  |    4 ++--
 arch/arm/boot/dts/am43x-epos-evm.dts |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.9.5

