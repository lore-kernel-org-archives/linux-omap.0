From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/6] OMAP2+: GPMC: NAND fixes for 3.17
Date: Tue, 2 Sep 2014 16:57:01 +0300
Message-ID: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbaIBN5O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 09:57:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi Tony,

These are some of the issues I found while testing v3.17-rc3.

- Wrong ECC scheme used for am43x GP and EPOS evm. We need to use
BCH16 instead of BCH8.

- Wrong read/write wait pin monitoring setting used for NAND
resulting in "L3 application error" debug message on console.

- Pin conflict issue on am43x EPOS evm with QSPI and NAND.

Patches are available at
git@github.com:rogerq/linux.git
* [new branch]      for-v3.17/gpmc-fixes

cheers,
-roger

Roger Quadros (6):
  ARM: dts: am43x-epos-evm: Use BCH16 ECC scheme instead of BCH8
  ARM: dts: am437x-gp-evm: Use BCH16 ECC scheme instead of BCH8
  ARM: dts: am437x-gp-evm: Don't use read/write wait monitoring
  ARM: dts: am43xx-epos-evm: Don't use read/write wait monitoring
  ARM: OMAP2+: gpmc: Don't complain if wait pin is used without r/w
    monitoring
  ARM: dts: am43x-epos-evm: Disable QSPI to prevent conflict with
    GPMC-NAND

 arch/arm/boot/dts/am437x-gp-evm.dts  | 4 +---
 arch/arm/boot/dts/am43x-epos-evm.dts | 9 ++++-----
 arch/arm/mach-omap2/gpmc.c           | 7 +++----
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
1.8.3.2

