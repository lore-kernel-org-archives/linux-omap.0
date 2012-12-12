From: Jon Hunter <jon-hunter@ti.com>
Subject: [RFC 0/5] ARM: Add Cross Trigger Interface driver
Date: Wed, 12 Dec 2012 15:43:03 -0600
Message-ID: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47055 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194Ab2LLVou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 16:44:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>, Jon Hunter <jon-hunter@ti.com>

Adds AMBA driver for ARM Coresight Cross Trigger Interface (CTI) driver
and device-tree binding for CTI module.

I have tested the driver on an OMAP4430 device and include the relevant
patches needed to enable CTI on OMAP4 devices for reference.

I would like to get some feedback on the binding, CTI APIs and usage of
the APB clock for OMAP4. I have seen that there has been some recent
discussion around adding other coresight drivers for ARM devices [1]
and so it would be also good to align on the appropriate location for
coresight drivers in general.

This series is based on the ARM-SOC for-next branch and Will Deacon's
patch for the CTI lock registers [2].

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/204591/match=coresight+bus
[2] http://article.gmane.org/gmane.linux.ports.arm.kernel/200199/match=fix+manipulation+debug+lock+register

Jon Hunter (5):
  ARM: CORESIGHT: Add generic lock/unlock helpers
  ARM: dts: Add Cross Trigger Interface binding
  ARM: CTI: Convert CTI helpers to AMBA bus driver
  ARM: dts: OMAP4: Add CTI nodes
  ARM: OMAP4: Add AMBA APB Clock

 Documentation/devicetree/bindings/arm/cti.txt |   32 +++
 arch/arm/boot/dts/omap4.dtsi                  |   23 ++
 arch/arm/include/asm/cti.h                    |  163 --------------
 arch/arm/include/asm/hardware/coresight.h     |   16 +-
 arch/arm/mach-omap2/cclock44xx_data.c         |    1 +
 drivers/Kconfig                               |    2 +
 drivers/amba/Kconfig                          |   20 ++
 drivers/amba/Makefile                         |    1 +
 drivers/amba/cti.c                            |  284 +++++++++++++++++++++++++
 include/linux/amba/cti.h                      |   82 +++++++
 10 files changed, 453 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cti.txt
 delete mode 100644 arch/arm/include/asm/cti.h
 create mode 100644 drivers/amba/Kconfig
 create mode 100644 drivers/amba/cti.c
 create mode 100644 include/linux/amba/cti.h

-- 
1.7.10.4

