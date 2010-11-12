From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Subject: [PATCHv4 0/4] OMAP: Serial: remove magic and diplicates
Date: Fri, 12 Nov 2010 15:03:59 +0200
Message-ID: <1289567043-6213-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:35726 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab0KLNFy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Nov 2010 08:05:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.arm.linux.org.uk, linux-serial@vger.kernel.org

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Add MDR1 Serial register definition to serial_reg and remove duplicated
code, remove magic MDR1 register numbers from serial drivers.

*v2 add OMAP keyword to MDR1 definition
*v3 remove magic from serial drivers
*v4 taking comments from Manjunath and Govindraj: typos, CC

Andrei Emeltchenko (4):
  OMAP: Serial: Define OMAP uart MDR1 register definitions
  OMAP1: Serial: remove magic numbers for MDR1 reg
  OMAP2: Serial: remove magic numbers for MDR1 reg
  OMAP: Serial: remove redefined MDR1 register definitions

 arch/arm/mach-omap1/serial.c                  |    6 ++++--
 arch/arm/mach-omap2/serial.c                  |   15 +++++++++------
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ---
 drivers/serial/omap-serial.c                  |    6 +++---
 include/linux/serial_reg.h                    |   12 ++++++++++++
 5 files changed, 28 insertions(+), 14 deletions(-)

