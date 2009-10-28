From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv2 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Wed, 28 Oct 2009 12:42:32 +0530 (IST)
Message-ID: <35552.192.168.10.88.1256713952.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492AbZJ1HM2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 03:12:28 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9S7CW65028041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:12:33 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9S7CUQ8018026
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:12:31 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 8f743a2fcb704b2bef35b314426209a9c4197aa4 Mon Sep 17 00:00:00 2001
From: Govindraj R <govindraj.raja@ti.com>
Date: Wed, 28 Oct 2009 12:27:42 +0530
Subject: [PATCHv2 0/3] OMAP UART: Adding support for omap-serial driver.

The Following series of patch adds support for OMAP3430-HIGH SPEED UART Controller.

Govindraj R (3):
  OMAP UART: Add omap-serial driver support.
  OMAP UART: Add platform data for omap-serial driver.
  OMAP UART: Add omap-serial driver support in omap_3430sdp_defconfig

 arch/arm/configs/omap_3430sdp_defconfig       |    1 +
 arch/arm/mach-omap2/serial.c                  |  166 +++
 arch/arm/plat-omap/include/plat/omap-serial.h |  155 +++
 drivers/serial/Kconfig                        |   23 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1778 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 7 files changed, 2127 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c



