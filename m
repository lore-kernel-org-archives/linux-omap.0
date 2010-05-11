From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH v3 0/3] OMAP4 Ethernet Controller Support
Date: Mon, 10 May 2010 20:41:31 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD52D4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38862 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab0EKBlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 21:41:42 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>


Enable network chip Micrel KS8851 for OMAP4430 SDP

- Based on mainline version 2.6.34 rc7
- Tested in OMAP4430 SDP

Throughput measurements using nuttcp application:
  11.9375 MB /  10.06 sec =    9.9519 Mbps 92 %TX 0 %RX 0 retrans 7.87 msRTT

--

All patches have been tagged as version 3

[PATCH v3 1/3] OMAP4: SPI: Fix Driver Kconfig 
[PATCH v3 2/3] OMAP4: Ethernet: KS8851 Board Support
[PATCH v3 3/3] OMAP4: Networking: Defconfig Support

--

 arch/arm/configs/omap_4430sdp_defconfig |   57 +++++++++++++++++++++-
 arch/arm/mach-omap2/board-4430sdp.c     |   82 ++++++++++++++++++++++++++++++++
 drivers/spi/Kconfig                     |    6 +-
 3 files changed, 140 insertions(+), 5 deletions(-)

