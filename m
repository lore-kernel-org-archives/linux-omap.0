From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/3] Serial: Adding support for HS-UART Omap-serial driver
Date: Mon, 12 Apr 2010 16:11:39 +0530 (IST)
Message-ID: <65497.192.168.10.89.1271068899.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393Ab0DLKll (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Apr 2010 06:41:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>


This patch series adds support for omap-serial driver
incorporating platform data support.

Posting the driver this time as a series along with
platform data support as per tonys comments.

http://marc.info/?l=linux-serial&m=126832535107135&w=2

Govindraj.R (3):
  serial: Add OMAP high-speed UART driver
  Serial: Remove 8250 driver assumptions.
  Serial: Add omap-serial platform data support.

 arch/arm/mach-omap2/serial.c                  |  385 +++++---
 arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
 drivers/serial/Kconfig                        |   27 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1336 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 6 files changed, 1764 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c




