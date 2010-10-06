From: David Anders <x0132446@ti.com>
Subject: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Wed,  6 Oct 2010 16:14:29 -0500
Message-ID: <1286399673-912-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58980 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933126Ab0JFVOt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 17:14:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Anders <x0132446@ti.com>

PandaBoard machine file related cleanups.

David Anders (4):
  omap4: pandaboard: remove unused hsmmc definition
  omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
  omap4: pandaboard: Adding card detect support for MMC1
  omap4: pandaboard: enable the ehci port on pandaboard

 arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
 1 files changed, 69 insertions(+), 7 deletions(-)

