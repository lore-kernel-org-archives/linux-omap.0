From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP4: clock: Fix missing optional clocks
Date: Tue, 21 Sep 2010 23:10:29 +0200
Message-ID: <1285103430-5964-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab0IUVKf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 17:10:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

The previous OMAP4 clock data did not contain the nodes to allow the modules
to enable the proper bit in the CLKCTRL register.

This patch is based on kevin/pm-wip/hwmods-omap4 rebased on top of your 
hwmod_hardreset_dev branch + my reset-fixes series + Partha's patch...
...and that's all.

This is also available here:
git://gitorious.org/omap-pm/linux.git pm-wip/hwmods-clocks

The pm-wip/hwmods-omap4-full will be then rebased on this branch.

Please note that the diff is pretty bad for the clock table. It looks like
everything has changed. I don't know if there is a way to have a better diff
with git.

Thanks,
Benoit


Benoit Cousson (1):
  OMAP4: clock: Add optional clock nodes

 arch/arm/mach-omap2/clock44xx_data.c |  893 ++++++++++++++++++++++++----------
 1 files changed, 625 insertions(+), 268 deletions(-)

