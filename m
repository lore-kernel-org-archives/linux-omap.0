From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
Date: Wed, 21 May 2014 15:50:19 +0300
Message-ID: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40156 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313AbaEUMu7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:50:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here are the AM43xx and OMAP5 display DT changes again. I've sent the clock
related changes separately, and I removed OMAP5's RFBI node, which depends on
more clock changes. The RFBI driver doesn't work at the moment anyway, so
removing the RFBI node should not be an issue.

Tony, if these look fine (the rfbi change is the only one compared to the
previous versions), can you queue them for 3.16?

 Tomi

Sathya Prakash M R (2):
  ARM: dts: am4372.dtsi: add DSS information
  ARM: dts: am437x-gp-evm: add LCD data

Tomi Valkeinen (4):
  ARM: dts: am43x-epos-evm: add LCD data
  ARM: dts: omap5.dtsi: add DSS nodes
  ARM: dts: omap5-uevm.dts: add tca6424a
  ARM: dts: omap5-uevm.dts: add display nodes

 arch/arm/boot/dts/am4372.dtsi        |  30 +++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts  |  97 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 101 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts     |  89 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi         |  61 +++++++++++++++++++++
 5 files changed, 378 insertions(+)

-- 
1.9.1

