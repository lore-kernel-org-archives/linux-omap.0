From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Fri, 13 Nov 2009 12:23:40 +0530 (IST)
Message-ID: <44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com>
References: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43025 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbZKMGxf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:53:35 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAD6rfSa009436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:53:41 -0600
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAD6rc2p003070
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:53:39 -0600 (CST)
In-Reply-To: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 8dae69c5e17421123b88414021289974e968fd02 Mon Sep 17 00:00:00 2001
From: Govindraj R <govindraj.raja@ti.com>
Date: Fri, 13 Nov 2009 12:09:38 +0530
Subject: [PATCH] OMAP UART: Adding support for omap-serial driver.

The Following series of patch adds support for OMAP3430-HIGH SPEED UART Controller.

Govindraj R (3):
  OMAP UART: Add omap-serial driver support.
  OMAP UART: Add platform data for omap-serial driver.
  OMAP UART: Add omap-serial driver support in omap_3430sdp_defconfig

 arch/arm/configs/omap_3430sdp_defconfig       |    1 +
 arch/arm/mach-omap2/serial.c                  |  335 +++++--
 arch/arm/plat-omap/include/plat/omap-serial.h |  115 +++
 drivers/serial/Kconfig                        |   23 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1330 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 7 files changed, 1714 insertions(+), 94 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c


