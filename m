From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 0/3] OMAP: RX51: save atags data to be exported on /proc/atags
Date: Thu, 24 Dec 2015 16:00:55 +0200
Message-ID: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Nokia N900 legacy userspace needs ATAGS passed by the bootloder to be
available in /proc/atags. With DT booted kernel this information is
no longer availabe. Fix that by saving ATAGS data early in the boot 
stage so it can be exported in /proc/atags later

Ivaylo Dimitrov (3):
  ARM: ATAGS: move atags.h to include/asm so it can be included by files
        outside kernel/
  ARM: ATAGS: Fix declaration of function save_atags
  OMAP: RX51: save ATAGS data in the early boot stage

 arch/arm/include/asm/atags.h        | 20 ++++++++++++++++++++
 arch/arm/kernel/atags.h             | 20 --------------------
 arch/arm/kernel/atags_parse.c       |  3 +--
 arch/arm/kernel/setup.c             |  3 +--
 arch/arm/mach-omap2/board-generic.c | 12 +++++++++++-
 5 files changed, 33 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/include/asm/atags.h
 delete mode 100644 arch/arm/kernel/atags.h

-- 
1.9.1
