From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v3 0/2] ARM: dts: Add SHAM and AES DT information
Date: Fri, 23 Aug 2013 14:12:34 -0700
Message-ID: <1377292356-19199-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from m1plsmtpa01-01.prod.mesa1.secureserver.net ([64.202.165.173]:38730
	"EHLO m1plsmtpa01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756307Ab3HWVM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Aug 2013 17:12:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <bcousson@baylibre.com>, Lokesh Vutla <lokeshvutla@ti.com>, Mark Rutland <mark.rutland@arm.com>, Joel Fernandes <joelf@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>

Long overdue patches to add the device tree updates and
documentation for the SHAM and AES modules on the am33xx.

This series is based on k.o 1f8b766 (Merge tag 'fixes-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc)

There are 2 prerequisite patches (thanks Lokesh):

	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92176.html
	https://patchwork.kernel.org/patch/2849040/

	(Note that
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92177.html
	is not strictly necessary)

You can view the actual source that I tested here:
	
	git@github.com:mgreeraz/linux-mag.git submitted/crypto/hwmod-v3-extra

Changes from v2:
 - Change some of the text added to the Documentation files to address
   comments by Mark Rutland <mark.rutland@arm.com>
   (http://www.spinics.net/lists/arm-kernel/msg269006.html)

Changes from v1:
 - Added missing '};' as pointed out by Lokesh Vutla <lokeshvutla@ti.com>

Mark A. Greer (2):
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++++++++++++++
 .../devicetree/bindings/crypto/omap-sham.txt       | 31 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |  8 +++++
 arch/arm/boot/dts/am335x-evm.dts                   |  8 +++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  8 +++++
 arch/arm/boot/dts/am33xx.dtsi                      | 21 +++++++++++++
 6 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.8.3.4

