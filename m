From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Subject: [PATCHv3 0/4] OMAP: Serial: remove magic and diplicates
Date: Fri, 12 Nov 2010 11:21:38 +0200
Message-ID: <1289553702-28041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Add MDR1 Serial register definition to serial_reg and remove duplicated
code.
*v2 add OMAP keyword to MDR1 definition
*v3 remove magic from serial drivers

Andrei Emeltchenko (4):
  OMAP: Serial: Define OMAP uart MDR1 register definitions
  OMAP1: Serial: remobe magic from MDR1 register
  OMAP2: Serial: remobe magic from MDR1 register
  OMAP: Serial: remove redefined MDR1 register definitions

 arch/arm/mach-omap1/serial.c                  |    6 ++++--
 arch/arm/mach-omap2/serial.c                  |   15 +++++++++------
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ---
 drivers/serial/omap-serial.c                  |    6 +++---
 include/linux/serial_reg.h                    |   12 ++++++++++++
 5 files changed, 28 insertions(+), 14 deletions(-)
