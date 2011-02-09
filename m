From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] OMAP4: enable clk32kg in TWL6030
Date: Wed,  9 Feb 2011 21:06:51 +0530
Message-ID: <1297265811-21901-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab1BIPet (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 10:34:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, sameo@linux.intel.com, Balaji T K <balajitk@ti.com>

add clk32kg to twl-regulator
add clk32kg board data to Blaze and Panda

Balaji T K (2):
  regulator: twl: add clk32kg to twl-regulator
  OMAP4: add clk32kg data to omap4panda and blaze board file

 arch/arm/mach-omap2/board-4430sdp.c    |   10 ++++++++++
 arch/arm/mach-omap2/board-omap4panda.c |   10 ++++++++++
 drivers/mfd/twl-core.c                 |    4 ++++
 drivers/regulator/twl-regulator.c      |    3 ++-
 include/linux/i2c/twl.h                |    2 ++
 5 files changed, 28 insertions(+), 1 deletions(-)

