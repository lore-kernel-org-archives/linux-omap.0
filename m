From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 0/2] ARM: dts: Add SHAM and AES DT information
Date: Tue, 16 Jul 2013 16:29:26 -0700
Message-ID: <1374017368-5267-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:42160
	"EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755191Ab3GPX3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jul 2013 19:29:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Long overdue patches to add the device tree updates and
documentation for the SHAM and AES modules on the am33xx.
The supporting code is already in the mainline kernel.

Mark A. Greer (2):
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        | 35 ++++++++++++++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 33 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 +++++
 arch/arm/boot/dts/am335x-evm.dts                   |  8 +++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  7 +++++
 arch/arm/boot/dts/am33xx.dtsi                      | 20 +++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.7.12

