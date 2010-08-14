From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2 0/13] OMAP: dmtimer: hwmod
Date: Sat, 14 Aug 2010 21:09:19 +0530
Message-ID: <1281800359-15285-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52921 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932661Ab0HNEkD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:40:03 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7E4e0FB002334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 23:40:02 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7E4dxGi028802
	for <linux-omap@vger.kernel.org>; Sat, 14 Aug 2010 10:09:59 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch series contains:
(*) most of the comments provided in v1 implemented and
(*) OMAP4 timers support

The comment details are availabe in respective patch series.

The comment regarding usage of "dmtimer" name will be resolved
after final round of consultation with members.

Baseline: "origin/pm-wip/hwmods-omap4"
Test info: Tested on OMAP4430SDP, OMAP3630SDP

Tarun Kanti DebBarma (13):
  dmtimer: hwmod: OMAP4: add device names to flck nodes
  dmtimer: hwmod: add omap3xxx database
  dmtimer: hwmod: OMAP: rev field to identify timer version
  dmtimer: hwmod: OMAP: api to read omap_hwmod _clk
  dmtimer: hwmod: OMAP: conversion to platform driver
  dmtimer: OMAP: multi-platform register map definitions
  dmtimer: hwmod: OMAP2PLUS: device registration
  dmtimer: OMAP: multi-platform register access support
  dmtimer: hwmod: OMAP3: add device names to flck nodes
  dmtimer: hwmod: add omap2430 database
  dmtimer: hwmod: add omap2420 database
  dmtimer: hwmod: OMAP2: add device names to flck nodes
  dmtimer: hwmod: OMAP1: device registration

 arch/arm/mach-omap1/Makefile                 |    2 +-
 arch/arm/mach-omap1/dmtimer.c                |  146 +++++
 arch/arm/mach-omap1/timer32k.c               |    3 -
 arch/arm/mach-omap2/Makefile                 |    2 +-
 arch/arm/mach-omap2/clock2420_data.c         |   12 +
 arch/arm/mach-omap2/clock2430_data.c         |   12 +
 arch/arm/mach-omap2/clock3xxx_data.c         |   24 +-
 arch/arm/mach-omap2/clock44xx_data.c         |   22 +-
 arch/arm/mach-omap2/dmtimer.c                |  403 +++++++++++++
 arch/arm/mach-omap2/dmtimer.h                |   19 +
 arch/arm/mach-omap2/io.c                     |    2 +
 arch/arm/mach-omap2/omap_hwmod.c             |   21 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  597 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  595 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  674 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    3 +
 arch/arm/mach-omap2/timer-gp.c               |    1 -
 arch/arm/plat-omap/dmtimer.c                 |  781 ++++++++++++--------------
 arch/arm/plat-omap/include/plat/dmtimer.h    |   15 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 20 files changed, 2894 insertions(+), 441 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap1/Makefile
 create mode 100755 arch/arm/mach-omap1/dmtimer.c
 mode change 100644 => 100755 arch/arm/mach-omap1/timer32k.c
 mode change 100644 => 100755 arch/arm/mach-omap2/clock2420_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/clock2430_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/clock3xxx_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/clock44xx_data.c
 create mode 100755 arch/arm/mach-omap2/dmtimer.c
 create mode 100755 arch/arm/mach-omap2/dmtimer.h
 mode change 100644 => 100755 arch/arm/mach-omap2/io.c
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod.c
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_2420_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_2430_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_44xx_data.c
 mode change 100644 => 100755 arch/arm/plat-omap/dmtimer.c
 mode change 100644 => 100755 arch/arm/plat-omap/include/plat/dmtimer.h
 mode change 100644 => 100755 arch/arm/plat-omap/include/plat/omap_hwmod.h

