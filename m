From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Omap board updates for merge window after 2.6.29
Date: Fri, 13 Mar 2009 15:43:36 -0700
Message-ID: <20090313224259.8810.3283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62261 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbZCMWnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 18:43:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some board updates and few new boards.

Regards,

Tony

---

Lauri Leukkunen (1):
      ARM OMAP3: Initial support for Nokia RX-51

Steve Sakoman (2):
      ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform
      ARM: OMAP3: Add SMSC911X support to Overo platform (V2)

Syed Mohammed Khasim (1):
      ARM: OMAP3: Add support for 3430 SDP


 arch/arm/configs/omap_3430sdp_defconfig      | 2061 ++++++++++++++++++++++++++
 arch/arm/configs/rx51_defconfig              | 1821 +++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                  |   10 
 arch/arm/mach-omap2/Makefile                 |    6 
 arch/arm/mach-omap2/board-3430sdp.c          |  514 ++++++
 arch/arm/mach-omap2/board-overo.c            |  126 ++
 arch/arm/mach-omap2/board-rx51-peripherals.c |  419 +++++
 arch/arm/mach-omap2/board-rx51.c             |   96 +
 8 files changed, 5052 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/omap_3430sdp_defconfig
 create mode 100644 arch/arm/configs/rx51_defconfig
 create mode 100644 arch/arm/mach-omap2/board-3430sdp.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 create mode 100644 arch/arm/mach-omap2/board-rx51.c

-- 
Signature
