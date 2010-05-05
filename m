From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH 0/3] OMAP4 Ethernet Controller Support
Date: Wed, 5 May 2010 02:09:19 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEB8BF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42447 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab0EEHJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 03:09:27 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>

Enable network chip Micrel KS8851 for OMAP4430 SDP

- Based on mainline version 2.6.34 rc6
- Tested in OMAP4430 SDP

Throughput measurements using nuttcp application:
  11.9375 MB /  10.06 sec =    9.9519 Mbps 92 %TX 0 %RX 0 retrans 7.87 msRTT

Patches

 [PATCH v2 1/3] OMAP4: SPI: Fix Driver Kconfig
 [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
 [PATCH v1 3/3] OMAP4: Networking: Defconfig Support

---

 arch/arm/configs/omap_4430sdp_defconfig |   57 ++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/board-4430sdp.c     |   30 ++++++++++++++++
 drivers/spi/Kconfig                     |    6 +--
 3 files changed, 88 insertions(+), 5 deletions(-)
