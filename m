From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] regulator: twl6030: do not write to _GRP for enable/disable
Date: Fri, 20 May 2011 19:03:50 +0530
Message-ID: <1305898432-14939-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933946Ab1ETNfD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 09:35:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, gg@slimlogic.co.uk, Balaji T K <balajitk@ti.com>

TWL6030: regulator is enabled/disabled via VREG_STATE
Resetting VREG_GRP is not needed to disable it.

TWL4030: regulator is enabled/disabled via VREG_GRP
Since there is nothing common, split twlreg_enable similar to other regulator_ops


Balaji T K (2):
  regulator: twl6030: do not write to _GRP for regulator enable
  regulator: twl6030: do not write to _GRP for regulator disable

 drivers/regulator/twl-regulator.c |   86 ++++++++++++++++++++-----------------
 1 files changed, 47 insertions(+), 39 deletions(-)

