From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH v2 0/2] ARM: dts: OMAP4+: Add dmm device bindings
Date: Wed, 20 Mar 2013 15:50:40 -0500
Message-ID: <1363812642-2921-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36042 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab3CTUuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 16:50:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, devicetree-discuss@lists.ozlabs.org, Andy Gross <andy.gross@ti.com>

This patch set adds devicetree bindings for the Dynamic Memory Manager (DMM)
inside the OMAP4 and OMAP5 devices, removes generation of the device node via
the hwmod, and adds documentation for the minimal binding.

This patch series is based on device tree patches queued up for OMAP 3.10.

Patches are located at:
https://github.com/andygross/omap_dmm_tiler/commits/for-benoit

Changes in v2:
	- Moved documentation file to bindings patch.
 	- Modified drm code to allow for cases where DT info is unavailable.

Andy Gross (2):
  ARM: dts: OMAP4+: Add DMM bindings
  ARM: OMAP2+: Don't create DMM if DT present

 Documentation/devicetree/bindings/arm/omap/dmm.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |    7 +++++++
 arch/arm/mach-omap2/drm.c                          |   18 ++++++++++++------
 4 files changed, 42 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

-- 
1.7.5.4

