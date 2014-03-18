From: Sathya Prakash M R <sathyap@ti.com>
Subject: [RFC PATCH 0/2] Sil9022 DPI to HDMI Encoder
Date: Tue, 18 Mar 2014 15:37:55 +0530
Message-ID: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56824 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbaCRKIT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 06:08:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

This patch series adds the Silicon Image Sil9022 driver.

Sil9022 is HDMI Transmitter compliant to HDMI 1.2a and DVI 1.0.
It supports 1080p and UXGA. It has single slave I2C from Host,
passing through to master I2C interface for DDC Connection.
It provides Transmitter Programming Interface (TPI) for simplified API programming.
Product brief:
http://www.semiconductorstore.com/pdf/newsite/siliconimage/SiI9022a_pb.pdf

Current driver is tested on AM43x SOC.

This series is on top of series posted to add DSS support on AM43x [2]
[2] https://patchwork.kernel.org/patch/3822691/

This is initial driver supporting limited features.

TODO ->
Audio Support
Detailed Hot Plug event handling and also routing the hot plug event to host processor

These features will be added in future.

Sathya Prakash M R (2):
  OMAPDSS: Add Sil9022 DPI-HDMI Encoder Driver
  ARM: DTS: AM43x: Add sii9022 dt information

 arch/arm/boot/dts/am437x-gp-evm.dts                |   58 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   59 +-
 drivers/video/omap2/displays-new/Kconfig           |    8 +
 drivers/video/omap2/displays-new/Makefile          |    1 +
 drivers/video/omap2/displays-new/encoder-sil9022.c |  748 ++++++++++++++++++++
 drivers/video/omap2/displays-new/encoder-sil9022.h |  105 +++
 6 files changed, 973 insertions(+), 6 deletions(-)
 create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.c
 create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.h

-- 
1.7.9.5

