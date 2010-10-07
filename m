From: David Anders <x0132446@ti.com>
Subject: [PATCH 0/3] omap4: pandaboard: machine cleanups
Date: Thu,  7 Oct 2010 14:36:27 -0500
Message-ID: <1286480190-20632-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab0JGTgf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 15:36:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jayabharath@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
Cc: David Anders <x0132446@ti.com>

PandaBoard machine file related cleanups.

David Anders (3):
  omap4: pandaboard: remove unused hsmmc definition
  omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
  omap4: pandaboard: enable the ehci port on pandaboard

 arch/arm/mach-omap2/board-omap4panda.c |   69 +++++++++++++++++++++++++++++---
 1 files changed, 63 insertions(+), 6 deletions(-)

