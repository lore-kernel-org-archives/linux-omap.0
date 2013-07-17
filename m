From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Date: Wed, 17 Jul 2013 09:23:40 -0700
Message-ID: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:44387
	"EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756440Ab3GQQX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 12:23:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Long overdue patches to add the device tree updates and
documentation for the SHAM and AES modules on the am33xx.
The supporting code is already in the mainline kernel.

This series is based on the current mainline kernel,
c0d15cc (linked-list: Remove __list_for_each).

Changes from v1:
 - Added missing '};' as pointed out by Lokesh Vutla <lokeshvutla@ti.com>

Mark A. Greer (2):
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        | 35 ++++++++++++++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 33 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 +++++
 arch/arm/boot/dts/am335x-evm.dts                   |  8 +++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  8 +++++
 arch/arm/boot/dts/am33xx.dtsi                      | 21 +++++++++++++
 6 files changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.7.12

