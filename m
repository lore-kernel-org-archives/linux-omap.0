From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 0/2] OMAP: RX51: save atags data to be exported on /proc/atags
Date: Thu, 24 Dec 2015 18:37:54 +0200
Message-ID: <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Nokia N900 legacy userspace needs ATAGS passed by the bootloder to be
available in /proc/atags. With DT booted kernel this information is
no longer availabe. Fix that by saving ATAGS data early in the boot 
stage so it can be exported in /proc/atags later

Ivaylo Dimitrov (2):
  ARM: ATAGS: move save_atags() to include/asm
    arch/arm/include/asm/setup.h
  OMAP: RX51: save ATAGS data in the early boot stage

 arch/arm/include/asm/setup.h        |  6 ++++++
 arch/arm/kernel/atags.h             |  6 ------
 arch/arm/mach-omap2/board-generic.c | 12 +++++++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.9.1
