From: David Anders <x0132446@ti.com>
Subject: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Tue, 21 Sep 2010 16:24:00 -0500
Message-ID: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0IUVYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 17:24:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org
Cc: David Anders <x0132446@ti.com>

PandaBoard machine file related cleanups.

David Anders (4):
  omap4: pandaboard: remove unused hsmmc definition
  omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
  omap4: pandaboard: Adding card detect support for MMC1
  omap4: pandaboard: enable the ehci port on pandaboard

 arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
 1 files changed, 69 insertions(+), 7 deletions(-)

